#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

packages=(
  "xray|XTLS/Xray-core|pkgs/xray.nix|https://github.com/XTLS/Xray-core/releases/download/{TAG}/Xray-linux-64.zip"
  "sing-box|SagerNet/sing-box|pkgs/sing-box.nix|https://github.com/SagerNet/sing-box/releases/download/{TAG}/sing-box-{VERSION}-linux-amd64-glibc.tar.gz"
  "mihomo|MetaCubeX/mihomo|pkgs/mihomo.nix|https://github.com/MetaCubeX/mihomo/releases/download/{TAG}/mihomo-linux-amd64-{TAG}.gz"
)

changed=0

for entry in "${packages[@]}"; do
  IFS='|' read -r name owner_repo file url_template <<< "$entry"

  cur_version="$(sed -n 's/^  version = "\(.*\)";$/\1/p' "$file")"
  tag="$(curl -fsS "https://api.github.com/repos/$owner_repo/releases/latest" | jq -r '.tag_name')"

  if [[ -z "$tag" || "$tag" == "null" ]]; then
    echo "::warning::could not determine latest release for $owner_repo"
    continue
  fi

  new_version="${tag#v}"
  echo "[$name] current=$cur_version latest=$new_version"

  if [[ "$new_version" == "$cur_version" ]]; then
    continue
  fi

  url="${url_template//\{TAG\}/$tag}"
  url="${url//\{VERSION\}/$new_version}"

  echo "[$name] new release $new_version, fetching hash..."
  base32_hash="$(nix-prefetch-url --type sha256 "$url")"
  sri_hash="$(nix hash to-sri --type sha256 "$base32_hash")"

  sed -i 's|^  version = ".*";$|  version = "'"$new_version"'";|' "$file"
  sed -i 's|^    hash = "sha256-[^"]*";$|    hash = "'"$sri_hash"'";|' "$file"

  echo "[$name] updated to $new_version"
  changed=1
done

if [[ "$changed" -eq 0 ]]; then
  echo "No updates."
  exit 0
fi

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

git add pkgs
git commit -m "chore: bump xray / sing-box / mihomo"
git push origin HEAD
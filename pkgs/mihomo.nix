{ pkgs }:

pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "mihomo";
  version = "1.19.27";

  src = pkgs.fetchurl {
    url = "https://github.com/MetaCubeX/mihomo/releases/download/v${finalAttrs.version}/mihomo-linux-amd64-v${finalAttrs.version}.gz";
    hash = "sha256-+z40xVhE84n/VGeeWjrsMx1ew4AGwg+NzEdvtHdopY8=";
  };

  nativeBuildInputs = [ pkgs.gzip ];

  unpackPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    gunzip -c $src > $out/bin/mihomo
    chmod +x $out/bin/mihomo
  '';

  meta = {
    homepage = "https://github.com/MetaCubeX/mihomo";
    description = "A rule-based tunnel in Go";
    license = pkgs.lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
  };
})
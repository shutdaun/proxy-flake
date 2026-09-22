{
  description = "xray, sing-box, mihomo packaged from upstream releases";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      xray    = import ./pkgs/xray.nix    { inherit pkgs; };
      sing-box = import ./pkgs/sing-box.nix { inherit pkgs; };
      mihomo  = import ./pkgs/mihomo.nix { inherit pkgs; };
    in {
      packages.${system} = { inherit xray sing-box mihomo; };
      overlays.default = final: prev: { inherit xray sing-box mihomo; };
    };
}
# proxy-flake

Nix flake packaging [xray](https://github.com/XTLS/Xray-core), [sing-box](https://github.com/SagerNet/sing-box) and [mihomo](https://github.com/MetaCubeX/mihomo/tree/Meta) from official
upstream releases.

Packages in `nixpkgs` can lag behind upstream. This flake builds each proxy straight
from its official GitHub release, so you always get the current version.

## Usage

Add flake input:
```nix
{
  inputs = {
    proxy-flake.url = "github:shutdaun/proxy-flake";
  };
}
```

Add overlay and packages:
```nix
{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [
    inputs.proxy-flake.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    xray
    sing-box
    mihomo
  ];
}
```

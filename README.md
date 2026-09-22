# proxy-flake

Nix flake packaging [xray], [sing-box] and [mihomo] from official
upstream releases.

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

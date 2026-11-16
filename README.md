# proxy-flake

Nix flake packaging [xray](https://github.com/xtls/xray-core), [sing-box](https://github.com/sagernet/sing-box) and [mihomo](https://github.com/metacubex/mihomo/tree/meta) from official upstream releases.

## Usage

Flake input:
```nix
{
  inputs = {
    proxy-flake.url = "github:shutdaun/proxy-flake";
  };
}
```

Overlay and packages:
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

Binary [cache](https://app.cachix.org/cache/proxy-flake):
```nix
{
  nix.settings = {
    substituters = [
      "https://proxy-flake.cachix.org"
    ];
    trusted-public-keys = [
      "proxy-flake.cachix.org-1:MExFcHEQ7KA3AALzrwSKDvOdityyoR3yhxhzfqB7qfc="
    ];
  };
}
```


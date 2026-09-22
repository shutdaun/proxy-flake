{ pkgs }:

pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "xray";
  version = "26.3.27";

  src = pkgs.fetchurl {
    url = "https://github.com/XTLS/Xray-core/releases/download/v${finalAttrs.version}/Xray-linux-64.zip";
    hash = "sha256-I82a+Td0TZd3buNeytSXLPSyEJ0eD+a+mTBGdgj3yK4=";
  };

  nativeBuildInputs = [ pkgs.unzip ];

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    cp xray $out/bin/
    chmod +x $out/bin/xray
  '';

  meta = {
    homepage = "https://github.com/XTLS/Xray-core";
    description = "A platform for building proxies";
    license = pkgs.lib.licenses.mpl20;
    platforms = [ "x86_64-linux" ];
  };
})
{ pkgs }:

pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "xray";
  version = "26.10.21";

  src = pkgs.fetchurl {
    url = "https://github.com/XTLS/Xray-core/releases/download/v${finalAttrs.version}/Xray-linux-64.zip";
    hash = "sha256-Duw+1BY8Jz2Mi/gh99IZ4leSHPWEqj+5cHFeRY5jGXg=";
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
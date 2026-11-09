{ pkgs }:

pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "xray";
  version = "26.11.9";

  src = pkgs.fetchurl {
    url = "https://github.com/XTLS/Xray-core/releases/download/v${finalAttrs.version}/Xray-linux-64.zip";
    hash = "sha256-tlH34dmWbuLBse4b+LUscncYJNMGXc6Wu8i8wZ7ZX4I=";
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
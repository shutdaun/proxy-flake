{ pkgs }:

pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "sing-box";
  version = "1.14.1";

  src = pkgs.fetchurl {
    url = "https://github.com/SagerNet/sing-box/releases/download/v${finalAttrs.version}/sing-box-${finalAttrs.version}-linux-amd64-glibc.tar.gz";
    hash = "sha256-TGyGCpb3/OJS16ENBgiuTLfna8vl88qcEQpgQAcJB1Y=";
  };

  nativeBuildInputs = [ pkgs.autoPatchelfHook ];

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    cp $(find . -name "sing-box" -type f) $out/bin/
    chmod +x $out/bin/sing-box
  '';

  meta = {
    homepage = "https://sing-box.sagernet.org";
    description = "Universal proxy platform";
    license = pkgs.lib.licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
  };
})
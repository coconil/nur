{ stdenv , fetchurl
, lib
, autoPatchelfHook
, makeWrapper
, callPackage

# depency
, gtk3
, libgcc
, xorg
,cairo
,alsa-lib
,nss
,libdrm
,mesa
}:

stdenv.mkDerivation rec {
  name = "cfw-${version}";
  version = "0.20.39";
  src = fetchurl{
    url = "https://github.com/Z-Siqi/Clash-for-Windows_Chinese/releases/download/CFW-V0.20.39_OPT-1/Clash.for.Windows-${version}-Opt.1-linux-x64.tar.gz";
    sha256="sha256-YnbfluHXdLPjEoxXuRvehZFH3c/PA4PJjt07PpWeZ9k=";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

  unpackPhase = ''
    tar xf ${src}
  '';

  buildInputs = [ makeWrapper
                  gtk3
                  libgcc
                  cairo
                  nss
                  libdrm
                  mesa
                      alsa-lib
                  xorg.libxcb
                  xorg.libX11
                   xorg.libX11
    xorg.libICE
    xorg.libSM
     xorg.xcbutil
      xorg.xcbutilimage
      xorg.xcbutilkeysyms
      xorg.xcbproto
      xorg.xcbutilerrors
      xorg.xcbutilrenderutil
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXinerama
    xorg.libXmu
    xorg.libXrandr
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libXt
    xorg.libXtst
                ];

  installPhase = ''
  mkdir -p $out
  cp -r Clash.for.Windows-${version}-Opt.1-linux-x64/* $out/

  '';
}

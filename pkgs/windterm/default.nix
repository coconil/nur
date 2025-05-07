{ stdenv , fetchurl
, lib
, autoPatchelfHook
, makeWrapper
, makeDesktopItem
, callPackage
, unzip
, libgcc
, freetype
, xorg
, glib
, glibc
, libGL
, fontconfig
, libxkbcommon
, gst_all_1
,cairo
,pango
,gtk3
,gdk-pixbuf
,gatk
,libpulseaudio
,alsa-lib
,qt5
,copyDesktopItems
# depency

}:

stdenv.mkDerivation rec {
  name = "windterm-${version}";
  version = "2.7.0";
  src = fetchurl{
    url = "https://goppx.com/https://github.com/kingToolbox/WindTerm/releases/download/${version}/WindTerm_${version}_Linux_Portable_x86_64.zip";
    sha256="sha256-d5dpfutgI5AgUS4rVJaVpgw5s/0B/n67BH/VCiiJEDw=";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper unzip copyDesktopItems];

  unpackPhase = ''
    unzip ${src}
  '';

  buildInputs = [ makeWrapper
 libgcc
 freetype
 glib
 glibc
 libGL
 libxkbcommon
 gst_all_1.gstreamer
 gst_all_1.gst-plugins-base
 xorg.libX11
    xorg.libICE
    xorg.libSM
    xorg.libX11
    xorg.libxcb
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
    fontconfig
    gdk-pixbuf
    cairo
    pango
    gtk3
    gdk-pixbuf
    gatk
    libpulseaudio
    alsa-lib
    qt5.full
 ];

  installPhase = ''
  mkdir -p $out/opt/WindTerm_${version}
  install -Dm644  WindTerm_${version}/* $out/opt/WindTerm_${version}

  chmod 777 $out/opt/WindTerm_${version}/WindTerm

  # App Menu
  install -Dm644 $out/opt/WindTerm_${version}/windterm.png $out/share/pixmaps/windterm.png

  '';

  desktopItems = [
    (makeDesktopItem {
      name = "windterm";
      desktopName = "windterm";
      genericName = "windterm";
      categories = [ "Development" ];
      exec = "windterm %u";
      icon = "windterm";
    })
  ];

  meta = {
    maintainers = with lib.maintainers; [ coconil ];
    description = "windterm";
    homepage = "https://github.com/kingToolbox/WindTerm";
    platforms = [ "x86_64-linux" ];
    license = lib.licenses.asl20;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    mainProgram = "windterm";
  };
}

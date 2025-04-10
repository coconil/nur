{ stdenv , fetchurl
, lib
, autoPatchelfHook
, makeWrapper
, makeDesktopItem
, callPackage
, unzip
, libgcc
, freetype
, glib
, glibc
,qt5
,libpqxx
,psqlodbc
,cups
,hyphen
# depency

}:

stdenv.mkDerivation rec {
  name = "mybase-${version}";
  version = "8220";
  src = fetchurl{
    url = "https://www.wjjsoft.com/downloads/Mybase-Desktop-Ver${version}-Linux-amd64.tar.xz";
    sha256="sha256-g32CB3Z1Il1fx+6IHlbQ/i4xZGggovzvyhxZmD9nDSI=";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper unzip ];

  unpackPhase = ''
    tar xf ${src}
  '';

  buildInputs = [ makeWrapper
 libgcc
 freetype
 glib
 glibc
 qt5.full
 libpqxx
 psqlodbc
 cups
 hyphen
 ];

  installPhase = ''
  mkdir -p $out
  cp -r Mybase8/* $out/

  # App Menu
  install -Dm644 $out/nyf8_logo_256.png $out/share/pixmaps/mybase.png

  '';

  desktopItems = [
    (makeDesktopItem {
      name = "mybase";
      desktopName = "mybase";
      genericName = "mybase";
      categories = [ "Network" ];
      exec = "Mybase %u";
      icon = "mybase";
    })
  ];

  meta = {
    maintainers = with lib.maintainers; [ coconil ];
    description = "mybase";
    homepage = "https://www.wjjsoft.com/";
    platforms = [ "x86_64-linux" ];
    license = lib.licenses.unfreeRedistributable;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    mainProgram = "Mybase";
  };
}

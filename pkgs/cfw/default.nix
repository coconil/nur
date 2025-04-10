{ stdenv , fetchurl
, lib
, autoPatchelfHook
, makeWrapper
, electron
}:

stdenv.mkDerivation rec {
  name = "cfw-${version}";
  version = "0.20.39";
  src = fetchurl{
    url = "https://github.com/Z-Siqi/Clash-for-Windows_Chinese/releases/download/CFW-V0.20.39_OPT-1/Clash.for.Windows-${version}-Opt.1-linux-x64.tar.gz";
    sha256="sha256-YnbfluHXdLPjEoxXuRvehZFH3c/PA4PJjt07PpWeZ9k=";
  };

  #nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

  unpackPhase = ''
    tar xf ${src}
  '';

  buildInputs = [ makeWrapper
                ];

  installPhase = ''
  mkdir -p $out/bin
  cp -r Clash.for.Windows-${version}-Opt.1-linux-x64/resources/ $out/

  makeWrapper ${electron}/bin/electron $out/bin/cfw \
      --argv0 "cfw" \
      --add-flags "$out/resources/app.asar"

  '';
}

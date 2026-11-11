{
  stdenv,
  autoreconfHook,
  fetchFromGitHub,
  lib,
}:
stdenv.mkDerivation rec {
  name = "libgtextutils";
  version = "0.0.7";

  nativeBuildInputs = [autoreconfHook];

  src = fetchFromGitHub {
    owner = "agordon";
    repo = "libgtextutils";
    rev = version;
    sha256 = "sha256-pFNR/euPlShGCz+eN27oNGJlstwCbSkq/KgO/WHdIGU=";
  };

  patches = [
    ./libgtextutils.patch
  ];

  meta = {
    description = "Gordon's Text utils Library";
    hompage = "https://github.com/agordon/libgtextutils";
    license = lib.licenses.agpl3Plus;
  };
}

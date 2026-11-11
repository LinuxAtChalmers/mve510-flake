{
  stdenv,
  autoreconfHook,
  fetchFromGitHub,
  pkg-config,
  libgtextutils,
}:
stdenv.mkDerivation rec {
  name = "fastx-toolkit";
  version = "0.0.14";

  nativeBuildInputs = [autoreconfHook pkg-config];
  buildInputs = [libgtextutils];

  src = fetchFromGitHub {
    owner = "agordon";
    repo = "fastx_toolkit";
    rev = version;
    sha256 = "sha256-aPS9bRksUhgDSRmw8SN/wiciUj3bV5rJMvMxNwHwqS4=";
  };

  patches = [
    ./fastx-toolkit.patch
  ];

  meta = {
    description = "FASTA/FASTQ pre-processing programs";
    hompage = "https://github.com/agordon/fastx_toolkit";
    license = {
      fullName = "FASTX-Toolkit LICENSE";
      url = "https://github.com/agordon/fastx_toolkit/blob/master/LICENSE";
    };
  };
}

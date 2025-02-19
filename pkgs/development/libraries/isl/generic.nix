{ version
, urls
, sha256
, configureFlags ? []
, patches ? []
}:

{ lib, stdenv, fetchurl, gmp, autoreconfHook
}:

stdenv.mkDerivation {
  pname = "isl";
  inherit version;

  src = fetchurl {
    inherit urls sha256;
  };

  inherit patches;

  strictDeps = true;
  nativeBuildInputs = lib.optionals (stdenv.hostPlatform.isRiscV && lib.versionOlder version "0.24") [ autoreconfHook ];
  buildInputs = [ gmp ];

  inherit configureFlags;

  enableParallelBuilding = true;

  meta = {
    homepage = "https://libisl.sourceforge.io/";
    license = lib.licenses.lgpl21;
    description = "A library for manipulating sets and relations of integer points bounded by linear constraints";
    platforms = lib.platforms.all;
  };
}

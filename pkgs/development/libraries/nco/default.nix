{ stdenv, fetchzip, netcdf, netcdfcxx4, gsl, udunits, antlr, which, curl, flex, coreutils }:

stdenv.mkDerivation rec {
  version = "4.9.5";
  pname = "nco";

  nativeBuildInputs = [ flex which ];
  buildInputs = [ netcdf netcdfcxx4 gsl udunits antlr curl coreutils ];

  src = fetchzip {
    url = "https://github.com/nco/nco/archive/${version}.tar.gz";
    sha256 = "0xp377rsamn2hwhzaf0ih70wd5274flpz74grys1b7rpbvbyf1bw";
  };

  prePatch = ''
    substituteInPlace src/nco/nco_fl_utl.c \
      --replace "/bin/cp" "${coreutils}/bin/cp"
    substituteInPlace src/nco/nco_fl_utl.c \
      --replace "/bin/mv" "${coreutils}/bin/mv"
  '';

  meta = {
    description = "NetCDF Operator toolkit";
    longDescription = "The NCO (netCDF Operator) toolkit manipulates and analyzes data stored in netCDF-accessible formats, including DAP, HDF4, and HDF5";
    homepage = "http://nco.sourceforge.net/";
    license = stdenv.lib.licenses.gpl3;
    maintainers = [ stdenv.lib.maintainers.bzizou ];
    platforms = stdenv.lib.platforms.linux;
  };
}

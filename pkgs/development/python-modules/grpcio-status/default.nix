{ lib
, buildPythonPackage
, fetchPypi
, googleapis-common-protos
, grpcio
, protobuf
, pythonOlder
}:

buildPythonPackage rec {
  pname = "grpcio-status";
  version = "1.54.2";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-MlXL7Ft8cGyqPU3VhGBsCA5kFeFWMbsvYhXitwBVg20=";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace 'protobuf>=4.21.6' 'protobuf'
  '';

  propagatedBuildInputs = [
    googleapis-common-protos
    grpcio
    protobuf
  ];

  # Projec thas no tests
  doCheck = false;

  pythonImportsCheck = [
    "grpc_status"
  ];

  meta = with lib; {
    description = "GRPC Python status proto mapping";
    homepage = "https://github.com/grpc/grpc/tree/master/src/python/grpcio_status";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
  };
}

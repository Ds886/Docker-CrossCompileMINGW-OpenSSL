#!/bin/bash
strOpenSSLVersion="1.1.1k"
strRootDir=$(pwd)

touch ./OpenSSL-buildlog.log
exec &> >(tee  -a $strRootDir/OpenSSL-buildlog.log)


if ! [ -z $1 ]; then
	strOpenSSLVersion=$1
fi

echo "Buiding base image"
docker build -t dash/buildssl:latest "$strRootDir/image"


echo "Buiding SSL version: $strOpenSSLVersion"
mkdir -p release
docker run --mount type=bind,source="$strRootDir/release",target=/opt/rel --env SSLVERSION=$strOpenSSLVersion dash/buildssl:latest

FROM ubuntu:latest AS opensslbase
RUN sed -i "s/# deb-src/deb-src/g" /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

FROM opensslbase AS opensslinstalldependencies
RUN apt-get install wget tar bash curl build-essential cpanminus mingw-w64 -y
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

FROM opensslinstalldependencies AS opensslbuild
ADD build.sh /opt
WORKDIR /opt
CMD ./build.sh



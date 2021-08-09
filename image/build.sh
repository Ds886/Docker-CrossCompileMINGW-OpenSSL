#!/bin/bash
strOpenSSLVersion=$SSLVERSION
mkdir -p /opt/building
mkdir -p /opt/out
cd /opt/building
wget -nv "https://www.openssl.org/source/openssl-$strOpenSSLVersion.tar.gz"
tar xf "openssl-$strOpenSSLVersion.tar.gz"
cd "/opt/building/openssl-$strOpenSSLVersion"
sed -i 's/:.dll.a/ -Wl,--export-all -shared:.dll.a/g' ./Configure
sed -i 's,.*target already defined.*,$target=$_;,g' Configure
./Configure mingw shared --cross-compile-prefix=i686-w64-mingw32- --prefix=/opt/out --openssldir=/opt/out/ no-ssl2 no-ssl3  no-weak-ssl-ciphers
make -j
sed -i '/# define HEADER_X509V3_H/a \\n#ifdef X509_NAME\n#undef X509_NAME\n#endif' openssl/x509v3.h
make install_sw
cd /opt/ou
tar czf "/opt/rel/openssl-$strOpenSSLVersion-mingw-$(date "+%Y-%m-%d_%H-%M-%S").tgz" ./*

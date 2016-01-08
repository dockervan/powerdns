#!/usr/bin/env sh
set -e

apt-get update
apt-get install --yes \
    autoconf automake bison flex g++ libboost-all-dev libtool make pkg-config ragel libmysqlclient-dev \
    wget bzip2 mysql-client
rm --recursive --force /var/lib/apt/lists/*

wget https://downloads.powerdns.com/releases/pdns-3.4.7.tar.bz2 -O pdns.tar.bz2
mkdir pdns
tar xf pdns.tar.bz2 -C pdns --strip-components 1
chown -R root:root pdns
rm --recursive pdns.tar.bz2

cd pdns

./configure --with-modules="gmysql"
make -j$(nproc)
make install
make clean

cd ..

rm -r pdns
apt-get remove --purge --yes \
    autoconf automake bison flex g++ libtool make pkg-config ragel \
    wget bzip2 mysql-client
apt-get autoremove --yes

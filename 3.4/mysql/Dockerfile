FROM debian

RUN apt-get update && \
apt-get install --yes \
autoconf automake bison flex g++ git libboost-all-dev libtool make pkg-config ragel libmysqlclient-dev \
wget bzip2 mysql-client && \
rm --recursive --force /var/lib/apt/lists/*

RUN wget https://downloads.powerdns.com/releases/pdns-3.4.7.tar.bz2 -O pdns.tar.bz2 && \
mkdir pdns && tar xf pdns.tar.bz2 -C pdns --strip-components 1 && chown -R root:root pdns && \
rm --recursive pdns.tar.bz2

WORKDIR pdns

RUN du -sh . && ./configure --with-modules="gmysql" && \
make -j$(nproc) && \
make install && \
make clean

ADD pdns.conf /usr/local/etc/pdns.conf

EXPOSE 53

CMD ["pdns_server", "--loglevel=9", "--log-dns-queries"]

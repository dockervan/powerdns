FROM alpine:3.3

MAINTAINER Sullivan SENECHAL <soullivaneuh@gmail.com>

RUN apk add --no-cache --virtual .deps boost-serialization libstdc++ \
&& apk add --no-cache --virtual .build-deps openssl tar file gcc g++ make autoconf boost-dev \
&& apk add --no-cache --virtual .modules-build-deps cmake \

&& wget https://dev.mysql.com/get/Downloads/Connector-C/mysql-connector-c-6.1.6-src.tar.gz -O mysql-connector-c.tar.gz \
&& mkdir mysql-connector-c && tar xf mysql-connector-c.tar.gz -C mysql-connector-c --strip-components 1 \
&& cd mysql-connector-c \
&& cmake -G "Unix Makefiles" && make -j$(getconf _NPROCESSORS_ONLN) && make install \
&& ln -s /usr/local/mysql/bin/* /usr/local/bin \
&& ln -s /usr/local/mysql/lib/libmysqlclient.so.18 /usr/lib/libmysqlclient.so.18 \
&& cd .. \
&& rm -r mysql-connector-c.tar.gz mysql-connector-c \

&& wget https://downloads.powerdns.com/releases/pdns-3.4.7.tar.bz2 -O pdns.tar.bz2 \
&& mkdir pdns && tar xf pdns.tar.bz2 -C pdns --strip-components 1 \
&& rm -rf pdns.tar.bz2 \
&& cd pdns \
&& ./configure --with-modules="gmysql" \
&& make -j$(getconf _NPROCESSORS_ONLN) && make install && make clean \
&& cd .. \
&& rm -r pdns \

&& apk del .build-deps .modules-build-deps

ADD pdns.conf /usr/local/etc/pdns.conf

EXPOSE 53

CMD ["pdns_server", "--loglevel=9", "--log-dns-queries"]

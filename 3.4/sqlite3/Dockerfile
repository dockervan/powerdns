FROM alpine:3.3

MAINTAINER Sullivan SENECHAL <soullivaneuh@gmail.com>

RUN apk add --no-cache --virtual .deps boost-serialization libstdc++ \
&& apk add --no-cache --virtual .modules-deps sqlite-libs \
&& apk add --no-cache --virtual .build-deps openssl tar file gcc g++ make autoconf boost-dev \
&& apk add --no-cache --virtual .modules-build-deps sqlite-dev \

&& wget https://downloads.powerdns.com/releases/pdns-3.4.7.tar.bz2 -O pdns.tar.bz2 \
&& mkdir pdns && tar xf pdns.tar.bz2 -C pdns --strip-components 1 \
&& rm -rf pdns.tar.bz2 \
&& cd pdns \
&& ./configure --with-modules="gsqlite3" \
&& make -j$(getconf _NPROCESSORS_ONLN) && make install && make clean \
&& cd .. \
&& rm -r pdns \

&& apk del .build-deps .modules-build-deps

ADD pdns.conf /usr/local/etc/pdns.conf

EXPOSE 53

CMD ["pdns_server", "--loglevel=9", "--log-dns-queries"]

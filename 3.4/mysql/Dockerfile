FROM debian

ADD build.sh /

RUN sh build.sh

ADD pdns.conf /usr/local/etc/pdns.conf

EXPOSE 53

CMD ["pdns_server", "--loglevel=9", "--log-dns-queries"]

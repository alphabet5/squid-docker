FROM alpine:latest
LABEL maintainer="John Burt"

ENV SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
 bash \
 squid

COPY entrypoint.sh /sbin/entrypoint.sh
COPY example /example
COPY example/squid.conf /etc/squid/squid.conf
RUN chmod 755 /sbin/entrypoint.sh
RUN ln -sf /dev/stdout /var/log/squid/access.log && \
    ln -sf /dev/stdout /var/log/squid/cache.log

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]
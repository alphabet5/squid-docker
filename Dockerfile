FROM alpine:latest
LABEL maintainer="John Burt"

ENV SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
 bash \
 squid \
 sudo

RUN echo -e "Defaults:squid !requiretty" > /etc/sudoers.d/squid
RUN echo -e "squid ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/squid

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh
COPY example /example
COPY example/squid.conf /etc/squid/squid.conf

EXPOSE 3128/tcp

USER squid
ENTRYPOINT ["sudo", "/sbin/entrypoint.sh"]
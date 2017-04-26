
FROM alpine:latest
MAINTAINER HyperApp <HyperAppCloud@gmail.com>

ARG VERSION 0.9.3

RUN apk add --no-cache --update wget \
 && wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v$VERSIOn/frp_$VERSION_linux_amd64.tar.gz \
 && tar zxvf frp_0.8.1_linux_amd64.tar.gz \
 && mv frp_0.8.1_linux_amd64/frps /usr/local/bin/ \
 && rm -r frp_0.8.1_linux_amd64* \
 && chmod +x /usr/local/bin/frps

ENV PROXY_PORT=
ENV AUTH_TOKEN=
ENV DASHBOARD_PORT 80
ENV DASHBOARD_USER=
ENV DASHBOARD_PWD=

EXPOSE 80
VOLUME /etc
ADD docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
# ENTRYPOINT ["/usr/local/bin/frps", "-L", "console", "-c", "/data/frps.ini"]
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/local/bin/frps", "-c", "/etc/frps.ini"]

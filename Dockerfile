FROM alpine:latest
MAINTAINER HyperApp <HyperAppCloud@gmail.com>

ARG VERSION=0.9.3

RUN apk add --no-cache --update wget \
 && wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_amd64.tar.gz \
 && tar zxvf frp_${VERSION}_linux_amd64.tar.gz \
 && mv frp_${VERSION}_linux_amd64/frps /usr/local/bin/ \
 && rm -r frp_${VERSION}_linux_amd64* \
 && chmod +x /usr/local/bin/frps \
 && chown root:root /usr/local/bin/frps

ENV PROXY_PORT=
ENV AUTH_TOKEN=
ENV DASHBOARD_PORT 80
ENV DASHBOARD_USER=
ENV DASHBOARD_PWD=

EXPOSE 80
VOLUME /etc/frp
ADD docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
# ENTRYPOINT ["/usr/local/bin/frps", "-L", "console", "-c", "/data/frps.ini"]
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/local/bin/frps", "-c", "/etc/frp/frps.ini"]

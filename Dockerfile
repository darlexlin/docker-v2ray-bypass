FROM phusion/baseimage:18.04-1.0.0-amd64

ENV DEBIAN_FRONTEND noninteractive
ENV PUID=1000 PGID=1000
ENV TZ Asia/Shanghai

WORKDIR /v2ray

COPY install-release.sh /install-release.sh

RUN apt-get update -y && \
    apt-get install -y wget tzdata iptables && \
    /install-release.sh && \
    apt-get update -y && \
    ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf && sysctl -p && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get clean
    
COPY start.sh /start.sh

USER v2ray

VOLUME /v2ray

CMD ["./start.sh"]
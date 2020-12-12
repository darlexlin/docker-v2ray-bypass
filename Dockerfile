FROM phusion/baseimage:18.04-1.0.0-amd64

ENV DEBIAN_FRONTEND noninteractive
ENV PUID=1000 PGID=1000
ENV TZ Asia/Shanghai

COPY v2ray.sh /root/v2ray.sh

RUN apt-get update -y && \
    apt-get install -y wget tzdata iptables openssl ca-certificates unzip iproute2 iproute2-doc && \
    mkdir -p /etc/v2ray /usr/local/share/v2ray /var/log/v2ray /v2ray && \
    chmod +x /root/v2ray.sh && \
    /root/v2ray.sh && \
    apt-get update -y && \
    ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf && sysctl -p && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get clean

WORKDIR /v2ray

COPY config.json /etc/v2ray/config.json
COPY start.sh ./start.sh

RUN chmod +x ./start.sh

VOLUME /etc/v2ray

CMD ["./start.sh"]
FROM phusion/baseimage:18.04-1.0.0-amd64

ENV DEBIAN_FRONTEND noninteractive
ENV PUID=1000 PGID=1000
ENV TZ Asia/Shanghai

WORKDIR /etc/v2ray

COPY v2ray.sh /root/v2ray.sh

RUN apt-get update -y && \
    apt-get install -y wget tzdata iptables openssl ca-certificates unzip && \
    mkdir -p /etc/v2ray /usr/local/share/v2ray /var/log/v2ray && \
    chmod +x /root/v2ray.sh && \
    /root/v2ray.sh && \
    apt-get update -y && \
    ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf && sysctl -p && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get clean
    
COPY start.sh /start.sh

#USER v2ray

VOLUME /etc/v2ray

CMD [ "/usr/bin/v2ray", "-config", "/etc/v2ray/config.json", "./start.sh" ]
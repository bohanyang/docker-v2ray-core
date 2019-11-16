FROM alpine:3.10

ARG V2RAY_VERSION=4.21.3

RUN set -ex; \
    apk add --no-cache ca-certificates unzip wget; \
    wget -q "https://github.com/v2ray/v2ray-core/releases/download/v$V2RAY_VERSION/v2ray-linux-64.zip"; \
    mkdir /usr/bin/v2ray /etc/v2ray; \
    unzip \
        v2ray-linux-64.zip \
            v2ray \
            v2ctl \
            geoip.dat \
            geosite.dat \
            vpoint_vmess_freedom.json \
        -d /usr/bin/v2ray \
    ; \
    rm v2ray-linux-64.zip; \
    chmod +x /usr/bin/v2ray/v2ray /usr/bin/v2ray/v2ctl; \
    mv /usr/bin/v2ray/vpoint_vmess_freedom.json /etc/v2ray/config.json; \
    apk del unzip wget

ENV PATH "$PATH:/usr/bin/v2ray"

CMD ["v2ray", "-config=/etc/v2ray/config.json"]

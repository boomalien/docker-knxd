FROM ghcr.io/linuxserver/baseimage-alpine:3.12
#FROM debian:latest
#COPY tmp/qemu-arm-static /usr/bin/qemu-arm-static
#COPY tmp/qemu-aarch64-static /usr/bin/qemu-aarch64-static

LABEL maintainer="Oliver Mazur"
LABEL Description="knxd multi arch image. This Image uses debian as base image"

## Choose between branches

#COPY entrypoint.sh /

RUN apk add --no-cache build-base gcc abuild binutils binutils-doc gcc-doc git libev-dev automake autoconf libtool argp-standalone linux-headers libusb-dev cmake cmake-doc dev86 \
    && mkdir -p /usr/local/src && cd /usr/local/src \
    && git clone https://github.com/knxd/knxd.git \
    && cd knxd && ./bootstrap.sh \
    && ./configure --disable-systemd --enable-eibnetip --enable-eibnetserver --enable-eibnetiptunnel \
    && mkdir -p src/include/sys && ln -s /usr/lib/bcc/include/sys/cdefs.h src/include/sys \
    && make && make install && cd .. && rm -rf knxd \
#    && mkdir -p /etc/knxd \
#    && addgroup -S knxd \
#    && adduser -D -S -s /sbin/nologin -G knxd knxd \
#    && chmod a+x /entrypoint.sh \
    && apk del --no-cache build-base abuild binutils binutils-doc gcc-doc git automake autoconf libtool argp-standalone cmake cmake-doc dev86

#RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
#    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
#    && apt-get install knxd knxd-tools\
#    && addgroup -S knxd \
#    && adduser -D -S -s /sbin/nologin -G knxd knxd \
#    && chmod a+x /entrypoint.sh
#ENV LANG en_US.utf8

#COPY knxd.ini /root   
#COPY knxd.ini /etc/knxd    

# copy local files
COPY root/ /

# Ports and volumes
EXPOSE 3671/udp
EXPOSE 3672/udp
EXPOSE 6720
VOLUME /config

#ENTRYPOINT ["/entrypoint.sh"]
#CMD ["/etc/knxd/knxd.ini"]


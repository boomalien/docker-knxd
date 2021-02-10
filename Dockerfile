FROM ghcr.io/linuxserver/baseimage-alpine:3.12

LABEL maintainer="Oliver Mazur"
LABEL Description="knxd multi arch image. This Image uses debian as base image"

RUN apk add --no-cache build-base gcc abuild binutils binutils-doc gcc-doc git libev-dev automake autoconf libtool argp-standalone linux-headers libusb-dev cmake cmake-doc dev86 \
    && mkdir -p /usr/local/src && cd /usr/local/src \
    && git clone https://github.com/knxd/knxd.git \
    && cd knxd && ./bootstrap.sh \
    && ./configure --disable-systemd --enable-eibnetip --enable-eibnetserver --enable-eibnetiptunnel \
    && mkdir -p src/include/sys && ln -s /usr/lib/bcc/include/sys/cdefs.h src/include/sys \
    && make && make install && cd .. && rm -rf knxd \
    && apk del --no-cache build-base abuild binutils binutils-doc gcc-doc git automake autoconf libtool argp-standalone cmake cmake-doc dev86   

# copy local files
COPY root/ /

# Ports and volumes
EXPOSE 3671/udp
EXPOSE 6720
VOLUME /config


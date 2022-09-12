FROM ubuntu:18.04

RUN apt-get update && apt-get install -y gzip wget

RUN wget https://github.com/GarlicoinOrg/Garlicoin/releases/download/v0.18.0/garlicoin-0.18.0-x86_64-linux-gnu.tar.gz
RUN gunzip < garlicoin-0.18.0-x86_64-linux-gnu.tar.gz | tar xvf - -C /etc/

RUN apt-get update --allow-unauthenticated --allow-insecure-repositories  -y    \
    && apt-get install  --allow-unauthenticated -y   \
        --allow-unauthenticated \
        git                 \
        build-essential     \
        libtool             \
        autotools-dev       \
        automake            \
        pkg-config          \
        libssl-dev          \
        libevent-dev        \
        bsdmainutils        \
        libboost-all-dev  
        
RUN apt install --assume-yes libx11-xcb1 libasound2 x11-apps libice6 libsm6 libxaw7 libxft2 libxmu6 libxpm4 libxt6 x11-apps xbitmaps

COPY ./docker/entrypoint.sh /

COPY ./docker/.garlicoin /etc/garlicoin-0.18.0/.garlicoin

ENTRYPOINT ["/entrypoint.sh"]
FROM ubuntu:xenial

COPY MCR_R2013a_glnxa64_installer.zip /mcr-install/MCR.zip

RUN apt-get -qq update && apt-get -qq install -y unzip \
    && mkdir /opt/mcr \
    && cd /mcr-install \
    && unzip MCR.zip \
    && rm MCR.zip \
    && ./install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent \
    && cd / \
    && rm -rf mcr-install \
    && apt-get remove --purge  -y unzip \
    && rm -rf /var/lib/apt/lists/*

ENV MCROOT=/opt/mcr/v81
ENV MCR_LIBRARY_PATH="$LD_LIBRARY_PATH:$MCROOT/runtime/glnxa64:$MCROOT/bin/glnxa64:$MCROOT/sys/os/glnxa64:$MCROOT/sys/java/jre/glnxa64/jre/lib/amd64/naive_threads:$MCROOT/sys/java/jre/glnxa64/jre/lib/amd64/server:$MCROOT/sys/java/jre/glnxa64/jre/lib/amd64"



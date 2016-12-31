#### enqack/esp8266-micropython
FROM phusion/baseimage:0.9.19
ARG VERSION=master

RUN apt-get update \
    && apt-get install -y \
        autoconf \
        automake \
        bash \
        bison \
        build-essential \
        flex \
        gawk \
        gcc \
        g++ \
        git \
        gperf \
        help2man \
        libexpat-dev \
        libffi-dev \
        libreadline-dev \
        libtool \
        libtool-bin \
        make \
        ncurses-dev \
        pkg-config \
        python \
        python-dev \
        python-serial \
        python-setuptools \
        texinfo \
        sed \
        unrar-free \
        unzip \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --no-create-home micropython \
    && git clone --recursive https://github.com/pfalcon/esp-open-sdk.git \
    && git clone https://github.com/micropython/micropython.git \
    && cd micropython && git checkout $VERSION && git submodule update --init \
    && chown -R micropython:micropython ../esp-open-sdk ../micropython

USER micropython

RUN cd /esp-open-sdk && make STANDALONE=y

ENV PATH=/esp-open-sdk/xtensa-lx106-elf/bin:$PATH

USER root

RUN cd /micropython/unix && make axtls && make

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh \
    && /docker-entrypoint.sh build

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["build"]

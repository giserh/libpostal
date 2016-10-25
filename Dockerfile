FROM ubuntu:trusty

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      make \
      curl \
      libsnappy-dev \
      autoconf \
      automake \
      libtool \
      pkg-config \
      ca-certificates

VOLUME /data/libpostal

WORKDIR /libpostal

COPY resources ./resources
COPY scripts ./scripts
COPY src ./src
COPY test ./test

COPY bootstrap.sh ./
COPY configure.ac ./
COPY libpostal.pc.in ./
COPY Makefile.am ./

RUN ./bootstrap.sh \
    && mkdir -p /data \
    && ./configure --datadir=/data \
    && make \
    && make install \
    && ldconfig

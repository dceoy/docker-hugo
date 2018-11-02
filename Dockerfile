FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN set -e \
      && ln -sf /bin/bash /bin/sh

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y install --no-install-recommends --no-install-suggests \
        ca-certificates git golang \
      && apt-get -y autoremove \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

ENV PATH /opt/go/bin:${PATH}
ENV GOPATH /opt/go

RUN set -e \
      && mkdir /opt/go \
      && go get github.com/gohugoio/hugo

EXPOSE 1313

ENTRYPOINT ["/opt/go/bin/hugo"]

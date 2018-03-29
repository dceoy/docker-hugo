FROM golang

RUN set -e \
      && ln -sf /bin/bash /bin/sh

RUN set -e \
      && apt-get -y update \
      && apt-get -y upgrade \
      && apt-get -y autoremove \
      && apt-get clean

RUN set -e \
      && go get -v github.com/gohugoio/hugo

ENTRYPOINT ["/go/bin/hugo"]

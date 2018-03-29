FROM golang

RUN set -e \
      && ln -sf /bin/bash /bin/sh

RUN set -e \
      && apt-get -y update \
      && apt-get -y upgrade \
      && apt-get -y autoremove \
      && apt-get clean

RUN set -e \
      && go get github.com/magefile/mage \
      && go get -d github.com/gohugoio/hugo \
      && cd /go/src/github.com/gohugoio/hugo \
      && mage vendor \
      && mage install

EXPOSE 1313

ENTRYPOINT ["/go/bin/hugo"]

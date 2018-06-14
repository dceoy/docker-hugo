FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y install --no-install-recommends --no-install-suggests \
                            ca-certificates git golang make \
      && apt-get -y autoremove \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

ENV PATH ${PATH}:/go/bin
ENV GOPATH /go

RUN set -e \
      && mkdir /go \
      && go get github.com/magefile/mage \
      && go get -d github.com/gohugoio/hugo \
      && cd /go/src/github.com/gohugoio/hugo \
      && mage vendor \
      && mage install

EXPOSE 1313

ENTRYPOINT ["/go/bin/hugo"]

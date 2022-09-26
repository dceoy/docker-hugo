FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

ADD https://raw.githubusercontent.com/dceoy/print-github-tags/master/print-github-tags /usr/local/bin/print-github-tags

RUN set -e \
      && ln -sf bash /bin/sh

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y install --no-install-recommends --no-install-suggests \
        ca-certificates curl \
      && apt-get -y autoremove \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

RUN set -eo pipefail \
      && chmod +x /usr/local/bin/print-github-tags \
      && print-github-tags --release --latest gohugoio/hugo \
        | tr -d v \
        | xargs -i curl -SL \
          https://github.com/gohugoio/hugo/releases/download/v{}/hugo_extended_{}_linux-amd64.deb \
          -o /tmp/hugo.deb \
      && apt-get -y install /tmp/hugo.deb \
      && rm -f /tmp/hugo.deb

EXPOSE 1313

ENTRYPOINT ["/usr/local/bin/hugo"]

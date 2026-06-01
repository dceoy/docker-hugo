# syntax=docker/dockerfile:1
ARG UBUNTU_VERSION=26.04
FROM public.ecr.aws/docker/library/ubuntu:${UBUNTU_VERSION} AS app

ARG HUGO_VERSION=latest
ARG USER_NAME=hugo
ARG USER_UID=1001
ARG USER_GID=1001

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

RUN \
      rm -f /etc/apt/apt.conf.d/docker-clean \
      && echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' \
        > /etc/apt/apt.conf.d/keep-cache

# hadolint ignore=DL3008
RUN \
      --mount=type=cache,target=/var/cache/apt,sharing=locked \
      --mount=type=cache,target=/var/lib/apt,sharing=locked \
      apt-get -yqq update \
      && apt-get -yqq upgrade \
      && apt-get -yqq install --no-install-recommends --no-install-suggests \
        ca-certificates curl

RUN \
      curl -fsSL -o /usr/local/bin/print-github-tags \
        https://raw.githubusercontent.com/dceoy/print-github-tags/master/print-github-tags \
      && chmod +x /usr/local/bin/print-github-tags

RUN \
      --mount=type=tmpfs,target=/tmp \
      arch="$(dpkg --print-architecture)" \
      && if [[ "${HUGO_VERSION}" == "latest" ]]; then \
        hugo_version="$(print-github-tags --release --latest gohugoio/hugo | sed 's/^v//')"; \
      else \
        hugo_version="${HUGO_VERSION#v}"; \
      fi \
      && curl -fsSL -o /tmp/hugo.deb \
        "https://github.com/gohugoio/hugo/releases/download/v${hugo_version}/hugo_extended_${hugo_version}_linux-${arch}.deb" \
      && apt-get -yqq install --no-install-recommends --no-install-suggests /tmp/hugo.deb

RUN \
      groupadd --gid "${USER_GID}" "${USER_NAME}" \
      && useradd --uid "${USER_UID}" --gid "${USER_GID}" --shell /bin/bash --create-home "${USER_NAME}" \
      && mkdir -p /workspace \
      && chown "${USER_NAME}:${USER_NAME}" /workspace

EXPOSE 1313

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -sS http://127.0.0.1:1313/ >/dev/null

WORKDIR /workspace

USER ${USER_NAME}

ENTRYPOINT ["/usr/local/bin/hugo"]
CMD ["server", "--bind=0.0.0.0", "--port=1313", "--buildDrafts", "--buildExpired", "--buildFuture", "--watch"]

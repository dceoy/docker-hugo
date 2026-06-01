# docker-hugo

Dockerfile and compose.yml for [Hugo](https://gohugo.io/)

[![CI/CD](https://github.com/dceoy/docker-hugo/actions/workflows/ci.yml/badge.svg)](https://github.com/dceoy/docker-hugo/actions/workflows/ci.yml)

This repository provides a Docker image and Docker Compose workflow for Hugo
Extended.

## Docker image

Pull the image from [GitHub Container Registry](https://github.com/dceoy/docker-hugo/pkgs/container/hugo).

```bash
docker image pull dceoy/hugo
```

## Usage

Run hugo commands

```bash
# Run a web server
docker container run --rm -p 1313:1313 -v "${PWD}:/workspace" -w /workspace \
    dceoy/hugo server --bind=0.0.0.0 --buildDrafts --watch

# Create a new content
docker container run --rm -v "${PWD}:/workspace" -w /workspace \
    dceoy/hugo new post/new.md
```

Run hugo commands with Docker Compose

```bash
# Run a web server
docker compose -f /path/to/docker-hugo/compose.yml up

# Execute another command
docker compose -f /path/to/docker-hugo/compose.yml run --rm hugo <hugo_command>
```

## Build args

| Argument       | Default | Description           |
| -------------- | ------- | --------------------- |
| `HUGO_VERSION` | latest  | Hugo version to build |
| `USER_NAME`    | hugo    | Container user name   |
| `USER_UID`     | 1001    | Container user UID    |
| `USER_GID`     | 1001    | Container user GID    |

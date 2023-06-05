[![Bit Docker](https://img.shields.io/badge/Bit-Docker-086dd7)](https://hub.docker.com/u/bitsrc) ![version](https://img.shields.io/badge/Image-bitsrc/dev:0.1.48-brightgreen) ![version](https://img.shields.io/badge/Image-bitsrc/dev:0.1.48m-brightgreen) ![version](https://img.shields.io/badge/Image-bitsrc/dev:0.1.42-brightgreen) ![version](https://img.shields.io/badge/Image-bitsrc/dev:0.1.42m-brightgreen)
# Docker Image for Bit Application Development

## Getting Started

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/).

2. Install [VSCode Docker Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker).

3. Install [VSCode Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

## Using the Image

Pull the Docker Image using CLI or VSCode extension.

> `docker pull bitsrc/dev:latest`

Start the container and attach to it from VSCode (via Docker extension).

![VSCode Docker Attach](images/vscode-docker-attach.png)

For more information on best practices:

- [Developing inside a Container](https://code.visualstudio.com/docs/devcontainers/containers)

# Contributor Guide
If you plan to push a new image to Docker Hub, you can follow the below steps.

Build the docker image locally and publish

```sh
docker buildx build --platform linux/amd64,linux/arm64 --build-arg BIT_VERSION=0.1.52 -t bitsrc/dev:0.1.52 . --push
```

**Note:** To run the build image locally, use a single platform (either `linuxamd64, linux/arm64`) and use `--load` parameter replacing `--push`

## NODE_HEAP_SIZE (Optional, Default 4096)

You can specify a custom heap size for the image.

- 4096 (default)
- 8192

```
docker buildx build --platform linux/amd64,linux/arm64 --build-arg BIT_VERSION=0.1.52 --build-arg NODE_HEAP_SIZE=8192 -t bitsrc/dev:0.1.52m . --push
```

**Note:** For image naming convensions, use the suffix `m` added to the version for heap size 8192.

## Using GitHub Action

You can use the GitHub Action specified in this repository to release never versions of the image.

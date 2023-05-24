[![Bit Docker](https://img.shields.io/badge/Bit-Docker-086dd7)](https://hub.docker.com/u/bitsrc) ![version](https://img.shields.io/badge/Image-bitsrc/dev:0.1.48-brightgreen)
# Docker Images for Bit Application Development

## Getting Started

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/).

2. Install [VSCode Docker Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker).

3. Install [VSCode Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

## Using the Image

Pull the container to your local machine. Run the below command in your CLI (e.g For bit version 0.1.48).

> `docker pull bitsrc/dev:0.1.48`

Start the container and attach to it from VSCode.

![VSCode Docker Attach](images/vscode-docker-attach.png)

# Contributor Guide
If you plan to push a new image to Docker Hub, you can follow the below steps.

1. Build the docker image locally

```sh
docker build --build-arg BIT_VERSION=0.1.48 -t bitsrc/dev:0.1.48 .
```

## NODE_HEAP_SIZE (Optional, Default 2048)

You can specify a custom heap size for the image. However, we would recommend to use one of the below sizes.

- 4096 (default)
- 8192

Then specify it as a build-arg to the image (e.g Heap memory 8192).

```
docker build --build-arg BIT_VERSION=0.1.48 --build-arg NODE_HEAP_SIZE=8192 -t bitsrc/dev-m:0.1.48 .
```

**Note:** For image naming convensions, use the suffix `m` followed by a `-` for 8192, as a part of the image name.

2. Push the docker image to Docker Hub

```
docker push bitsrc/dev:0.1.48
```

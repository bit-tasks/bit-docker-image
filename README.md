[![Bit Docker](https://img.shields.io/badge/Bit-Docker-086dd7)](https://hub.docker.com/u/bitsrc) [![version](https://img.shields.io/badge/Image-bitsrc/stable:latest-brightgreen)](https://hub.docker.com/layers/bitsrc/stable/latest/images/sha256-e0f1fe5332e633b382185b08c17d0e3a7db898ec648f79eaa9bfa40caa663ce0?context=explore)
# Docker Images for Bit DevOps

## Getting Started

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/).

2. Install [VSCode Docker Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker).

3. Install [VSCode Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

## Using the Stable Image

Pull the Docker Image using CLI or VSCode extension.

> `docker pull bitsrc/stable:latest`

Start the container and attach to it from VSCode (via Docker extension).

![VSCode Docker Attach](images/vscode-docker-attach.png)

For more information on best practices:

- [Developing inside a Container](https://code.visualstudio.com/docs/devcontainers/containers)

## Using the Nightly Image

Pull the Docker Image using CLI or VSCode extension.

> `docker pull bitsrc/nightly:latest`

Start the container and attach to it from VSCode (via Docker extension).

![VSCode Docker Attach](images/vscode-docker-attach.png)

For more information on best practices:

- [Developing inside a Container](https://code.visualstudio.com/docs/devcontainers/containers)

## Using with CI/CD

### Github Actions

```
# @file github-action.yml

name: Build

on:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: bitsrc/stable:latest
    env:
      HOME: /home/bituser
    steps:
      - name: Initialize a workspace
        run: |
          bit -v
        displayName: 'Initialize a workspace'
```

### Azure DevOps Pipelines

```
# @file azure-pipelines.yml

trigger: none

pr: none

jobs:
- job: build
  displayName: Build
  pool:
    vmImage: 'ubuntu-latest'
  container:
    image: bitsrc/stable:latest
  env:
    HOME: /home/bituser
  steps:
  - script: |
      bit -v
    displayName: 'Check bit version'
```

### GitLab CI/CD

```
GitLab CI/CD

# @file .gitlab-ci.yml

stages:
  - build

variables:
  HOME: "/home/bituser"

build:
  stage: build
  image: bitsrc/stable:latest
  variables:
    HOME: /bit
  script:
    - echo "Check bit version"
    - bit -v
```

## Custom Scripts

### CheckServer
`checkserver` command, let's you test `bit start` and `bit run <app-name>` commands

```
checkserver <your-server-url> 
```

You can optionally specifiy the **maximum timeout** and **check frequency**. e.g:

```
cd my-workspace
bit start &
checkserver http://localhost:3000 600 5 # maximum timeout: 600 seconds, check frequency: 5 seconds
```

**Note:** You have to use '&' to run the dev server in the background, before executing `checkserver` command.

### BareScope
`barescope` command let's you create Bare Scope in your CI environment.

```
barescope <scope-name> <workspace-directory>
```

Here, it will create the barescope and update the remote in the given workspace directory. e.g:

```
barescope my-scope my-workspace
cd my-workspace
bit scope rename org.scope-name my-scope --refactor
bit link
bit compile
bit tag --message "CI tag"
bit export
```

# Contributor Guide
If you plan to push a new image to Docker Hub, you can follow the below steps.

Build the docker image locally and publish

```sh
docker buildx build --platform linux/amd64,linux/arm64 -t bitsrc/stable:latest . --push
```

**Note:** To run the build image locally, use a single platform (either `linuxamd64, linux/arm64`) and use `--load` parameter replacing `--push`

## NODE_HEAP_SIZE (Optional, Default 4096)

Specify a custom heap size for the image.

- 4096 (default)
- 8192

```
docker buildx build --platform linux/amd64,linux/arm64 --build-arg NIGHTLY=true --build-arg NODE_HEAP_SIZE=8192 -t bitsrc/stable:latest . --push
```

## Using GitHub Action

You can use the GitHub Action specified in this repository to release never versions of the image.

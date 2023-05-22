# Set the base Node.js version as a build argument
ARG NODE_IMAGE_VARIANT=16

# Use Node.js 16 as the base image
FROM node:${NODE_IMAGE_VARIANT}

# Set the working directory
WORKDIR /workspace

# Install system packages and clean up in a single step
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        libasound2 \
        libatk1.0-0 \
        libatk-bridge2.0-0 \
        libatspi2.0-0 \
        libdbus-1-3 \
        libdrm2 \
        libgbm1 \
        libnspr4 \
        libnss3 \
        libxcomposite1 \
        libxdamage1 \
        libxfixes3 \
        libxkbcommon0 \
        libxrandr2 \
        libcups2 \
    && rm -rf /var/lib/apt/lists/*

# Install TypeScript if not already installed
RUN npm install -g typescript

# Set the BVM version as a build argument
ARG BIT_VERSION

# Install BVM
RUN npx @teambit/bvm install

# Install the latest Bit version 
RUN npx @teambit/bvm install

# Set labels for BVM version and Node version
LABEL bvm.version=${BIT_VERSION}
LABEL node.version=${NODE_IMAGE_VARIANT}

# Set the node heap size as a build argument and label
ARG NODE_HEAP_SIZE=4096
LABEL node.heap.size=${NODE_HEAP_SIZE}

# Set the NODE_OPTIONS environment variable to increase the heap size
ENV NODE_OPTIONS="--max-old-space-size=${NODE_HEAP_SIZE}"

# Set the correct registry for @bit, @teambit
RUN npm config set '@bit:registry' https://node-registry.bit.cloud \
    && npm config set '@teambit:registry' https://node-registry.bit.cloud

# Set the SHELL environment variable to your shell name
ENV SHELL=/bin/bash

# Set the default command to start a shell
CMD ["/bin/bash"]

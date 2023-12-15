FROM node:20

# Set the SHELL environment variable to your shell name
ENV SHELL=/bin/bash

# Install system packages needed for Bit development server
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        jq \
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
        zstd \
    && rm -rf /var/lib/apt/lists/*

# Create a new user "bituser" and switch to it
RUN useradd -m bituser
USER bituser

# Create the workspace directory within the user's home directory
RUN mkdir -p /home/bituser/workspace

# Set the correct permissions for the workspace directory
RUN chown -R bituser:bituser /home/bituser/workspace

# Set the working directory to the user's workspace
WORKDIR /home/bituser/workspace

# Create a directory for global installations
RUN mkdir /home/bituser/.npm-global
RUN mkdir -p /home/bituser/.npm-global/lib

# Configure npm to use the new directory path
ENV PATH=/home/bituser/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/bituser/.npm-global

# Install BVM and Bit
RUN npm install -g @teambit/bvm

# Set release type to nightly based on NIGHTLY argument
ARG NIGHTLY=false
RUN if [ "$NIGHTLY" = "true" ] ; then npx @teambit/bvm config set RELEASE_TYPE nightly ; fi

RUN npx @teambit/bvm install
ENV PATH=$PATH:/home/bituser/bin

# Set the NODE_OPTIONS environment variable to increase the heap size
ARG NODE_HEAP_SIZE=4096
LABEL node.heap.size=${NODE_HEAP_SIZE}
ENV NODE_OPTIONS="--max-old-space-size=${NODE_HEAP_SIZE}"

# Set the correct registry
RUN npm config set '@bit:registry' https://node-registry.bit.cloud
RUN npm config set '@teambit:registry' https://node-registry.bit.cloud

# Set the default bit configurations for docker
ENV BIT_CONFIG_ANALYTICS_REPORTING="false"
ENV BIT_CONFIG_ANONYMOUS_REPORTING="false"
ENV BIT_CONFIG_INTERACTIVE="false"

USER root
COPY scripts /home/bituser/scripts
RUN chown -R bituser:bituser /home/bituser/scripts
RUN chmod +x /home/bituser/scripts/*
ENV PATH=$PATH:/home/bituser/scripts
User bituser

# Set the default command to start a shell
CMD ["/bin/bash"]

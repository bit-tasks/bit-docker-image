FROM node:18

# Set the SHELL environment variable to your shell name
ENV SHELL=/bin/bash

# Install system packages needed for Bit development server
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

# Configure npm to use the new directory path
ENV PATH=/home/bituser/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/bituser/.npm-global

# Install the given Bit version
ARG BIT_VERSION
LABEL bit.version=${BIT_VERSION}
RUN npm install -g @teambit/bvm
RUN bvm install ${BIT_VERSION}
ENV PATH=$PATH:/home/bituser/bin

# Set the NODE_OPTIONS environment variable to increase the heap size
ARG NODE_HEAP_SIZE=4096
LABEL node.heap.size=${NODE_HEAP_SIZE}
ENV NODE_OPTIONS="--max-old-space-size=${NODE_HEAP_SIZE}"

# Set the correct registry for @bit, @teambit
RUN npm config set '@bit:registry' https://node-registry.bit.cloud
RUN npm config set '@teambit:registry' https://node-registry.bit.cloud

# Set the default bit configurations for docker
RUN bit config set analytics_reporting false
RUN bit config set no_warnings false
RUN bit config set interactive false
RUN bit config set error_reporting true

# Set the default command to start a shell
CMD ["/bin/bash"]

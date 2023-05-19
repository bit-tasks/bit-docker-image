# Use Node.js 16 as the base image
FROM node:16

# Set the working directory
WORKDIR /workspace

# Install TypeScript if not already installed
RUN npm list -g typescript || npm install -g typescript

# Set the SHELL environment variable to your shell name
ENV SHELL=/bin/bash

# Run the command to install @teambit/bvm using NPX
RUN npx @teambit/bvm install

# Set the correct registry for @bit, @teambit
RUN npm config set '@bit:registry' https://node-registry.bit.cloud
RUN npm config set '@teambit:registry' https://node-registry.bit.cloud

# Set the default command to start a shell
CMD ["/bin/bash"]

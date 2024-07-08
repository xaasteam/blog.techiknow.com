# Build and run
# from ./ project folder run: 
# docker build -t quarto-blog ./.devcontainer/ 
# docker run -v "$(pwd):/app" -p 8080:8080 quarto-blog
# http://localhost:8080

FROM debian:latest

ARG WORKDIR=/app
ARG PORT=8080

# Install wget, ca-certificates, curl, gnupg, unzip, and Node.js
RUN apt-get update && apt-get install -y wget ca-certificates curl gnupg unzip && \
    curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs && \
    # Cleanup to reduce image size
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN node --version

# Download Quarto CLI
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.53/quarto-1.5.53-linux-arm64.tar.gz

# Create a directory for Quarto CLI and extract the tarball
RUN mkdir -p /opt/quarto \
    && tar -C /opt/quarto -xvzf quarto-1.5.53-linux-arm64.tar.gz

# Create a symlink in /usr/local/bin to make `quarto` available system-wide
RUN ln -s /opt/quarto/quarto-1.5.53/bin/quarto /usr/local/bin/quarto

# Cleanup the tarball
RUN rm quarto-1.5.53-linux-arm64.tar.gz

# Verify installation
RUN quarto --version

# Install Deno (ensure the version is compatible with your architecture)
RUN curl -fsSL https://deno.land/x/install/install.sh | sh && \
    ln -s /root/.deno/bin/deno /usr/local/bin/deno

# Set the working directory
WORKDIR /app

# Expose port 8080 for the HTTP server
EXPOSE 8080

# Serve the static site from working directory
CMD ["quarto", "preview", "--no-browser", "--port", "8080", "--host", "localhost"]
# CMD ["quarto", "preview"]
#, "-p", "8080"]
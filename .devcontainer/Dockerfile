# docker build -t quarto-blog . 
# docker run -p 8080:8080 quarto-blog .
# http://localhost:8080

FROM debian:latest

# RUN adduser -u 1000 -G root -D vscode

# # Set the working directory to the 'vscode' user's home directory
# WORKDIR /home/vscode

# # Switch to the 'vscode' user
# USER vscode

# Install wget and ca-certificates
RUN apt-get update && apt-get install -y wget ca-certificates \
    # Cleanup to reduce image size
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Download Quarto CLI
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.53/quarto-1.5.53-linux-amd64.tar.gz

# Create a directory for Quarto CLI and extract the tarball
RUN mkdir -p /opt/quarto \
    && tar -C /opt/quarto -xvzf quarto-1.5.53-linux-amd64.tar.gz

# Create a symlink in /usr/local/bin to make `quarto` available system-wide
RUN ln -s /opt/quarto/quarto-1.5.53/bin/quarto /usr/local/bin/quarto

# Cleanup the tarball
RUN rm quarto-1.5.53-linux-amd64.tar.gz

# Verify installation
RUN quarto --version


# Install dependencies:
# wget, ca-certificates, Node.js, and npm
# RUN apt-get update && apt-get install -y wget ca-certificates curl gnupg \
#     && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
#     && apt-get install -y nodejs \
#     # Cleanup to reduce image size
#     && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN apt-get install -y nodejs

# Install http-server for serving static files
RUN npm install -g http-server

# Set the working directory
WORKDIR /app


# # # Copy your Quarto project into the Docker image
# # COPY . /app

# # # Build your Quarto project
# # RUN quarto render

# Expose port 8080 for the HTTP server
EXPOSE 8080

# Serve the static site
CMD ["http-server", "website", "-p", "8080"]
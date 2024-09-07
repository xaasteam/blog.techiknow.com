# docker build -t devcontainer  . 
# docker run -n devcontainer -d
# or
# docker run -it $(docker build -q .)

FROM python:3.12

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Terraform
RUN apt-get update && apt-get install -y gnupg software-properties-common

RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

RUN gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint


RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list
    
RUN apt update && apt-get install terraform

# Non-root user
# ARG USER_UID=1000
# ARG USER_GID=$USER_UID
# RUN groupadd --gid $USER_GID devuser && \
#     useradd --uid $USER_UID --gid $USER_GID -m devuser

# Switch to the devuser
# USER devuser

# Install node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Install commitlint
RUN npm install -g commitlint @commitlint/cli @commitlint/config-conventional

# Setup git hooks
RUN git config --global core.hooksPath git-config
COPY git-config/ /home/git-config/

# Change owner
RUN chmod -R +x /home/git-config

# USER devuser

WORKDIR /workspace

# Install python dependencies if needed
# RUN pip install ...
 
CMD ["/bin/bash"]


# # Copy your hooks into the container
# COPY git-config /home/vscode/git-config

# # # Set permissions to make the hooks executable
# # RUN chmod -R +x /home/vscode/git-config/hooks

# # # Configure Git to use your custom hooks directory
# # RUN git config --global core.hooksPath /home/vscode/git-config/hooks

# WORKDIR /workspaces/devcontainer

# RUN chmod +x /home/vscode/git-config/scripts/git-setup.sh
# ENTRYPOINT ["/home/vscode/git-config/scripts/git-setup.sh"]

# keep docker running
ENTRYPOINT [ "tail", "-f", "/dev/null" ]
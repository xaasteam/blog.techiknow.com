FROM jupyter/base-notebook:latest

# Install Quarto
USER root
RUN wget -qO- "https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.53/quarto-1.5.53-linux-amd64.deb" > quarto.deb && \
    dpkg -i quarto.deb && \
    rm quarto.deb
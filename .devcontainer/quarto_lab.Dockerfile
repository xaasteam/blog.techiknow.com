# Local build
# docker build -t localhost:5000/quarto-base:latest .
# docker run -p 8888:8888 localhost:5000/quarto-base:latest
# docker push localhost:5000/quarto-base:latest


# docker run -d -p 5000:5000 --name registry registry:2
# lsof -i tcp:5000


FROM jupyter/base-notebook:latest

# Install Quarto
USER root
RUN wget -qO- "https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.53/quarto-1.5.53-linux-arm64.deb" > quarto.deb && \
    dpkg -i quarto.deb && \
    rm quarto.deb

    wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.53/quarto-1.5.53-linux-amd64.tar.gz
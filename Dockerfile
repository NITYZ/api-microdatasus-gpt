FROM rocker/r-base:latest

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('plumber', repos = 'https://cloud.r-project.org')"

CMD ["R", "-e", "library(plumber); print(packageVersion('plumber'))"]

FROM rocker/r-base:latest

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('plumber', repos = 'https://cloud.r-project.org')"

COPY plumber.R /app/plumber.R

EXPOSE 8080

CMD ["R", "-e", "pr <- plumber::plumb('/app/plumber.R'); pr$run(host='0.0.0.0', port=8080)"]

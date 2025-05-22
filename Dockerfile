FROM rocker/r-base:latest

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Instala TODOS os pacotes R necessários
RUN R -e "install.packages(c('plumber', 'remotes', 'dplyr', 'checkmate', 'cli', 'curl', 'data.table', 'dtplyr', 'foreign', 'lubridate', 'magrittr', 'RCurl', 'rlang', 'stringi', 'tibble', 'utils', 'zip'), repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('read.dbc', repos = 'https://packagemanager.posit.co/cran/2024-07-05')"
RUN R -e "remotes::install_github('rfsaldanha/microdatasus')"

COPY plumber.R /app/plumber.R

EXPOSE 8080

CMD ["R", "-e", "pr <- plumber::plumb('/app/plumber.R'); pr$run(host='0.0.0.0', port=8080)"]

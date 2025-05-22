FROM rocker/plumber:latest

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('remotes', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('dplyr', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('checkmate', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('cli', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('curl', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('data.table', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('dtplyr', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('foreign', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('lubridate', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('magrittr', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('RCurl', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('rlang', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('stringi', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('tibble', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('utils', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('zip', repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('read.dbc', repos = 'https://packagemanager.posit.co/cran/2024-07-05')"
RUN R -e "remotes::install_github('rfsaldanha/microdatasus')"

COPY plumber.R /app/plumber.R

EXPOSE 8080

CMD ["R", "-e", "pr <- plumber::plumb('/app/plumber.R'); pr$run(host='0.0.0.0', port=8080)"]

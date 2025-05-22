FROM rocker/r-base:latest

# Instala dependências do sistema (curl para remotes, etc)
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala pacotes R necessários
RUN R -e "install.packages(c('plumber', 'remotes', 'dplyr'), repos = 'https://cloud.r-project.org')"
RUN R -e "install.packages('read.dbc', repos = 'https://packagemanager.posit.co/cran/2024-07-05')"
RUN R -e "remotes::install_github('rfsaldanha/microdatasus')"

# Copia o script da API
COPY plumber.R /app/plumber.R

EXPOSE 8080

CMD ["R", "-e", "pr <- plumber::plumb('/app/plumber.R'); pr$run(host='0.0.0.0', port=8080)"]

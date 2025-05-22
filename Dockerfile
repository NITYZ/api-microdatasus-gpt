FROM rocker/plumber:latest

# Instalação dos pacotes necessários
RUN install2.r --error \
    remotes \
    plumber \
    dplyr \
    read.dbc

RUN Rscript -e "remotes::install_github('rfsaldanha/microdatasus')"

# Copia seus arquivos para dentro do container
COPY plumber.R /app/plumber.R

EXPOSE 8080

CMD ["R", "-e", "pr <- plumber::plumb('/app/plumber.R'); pr$run(host='0.0.0.0', port=8080)"]

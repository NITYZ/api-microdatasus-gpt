# plumber.R

library(plumber)
library(microdatasus)
library(dplyr)

#* @apiTitle API microdatasus GPT
#* @apiDescription Consulta dinâmica ao DATASUS usando microdatasus (R)

#* Consulta óbitos sumarizados por município
#* @param ano Ano dos óbitos (ex: 2020)
#* @param uf Estado (ex: RJ)
#* @param cid CID-10 (ex: U07, I21, A90)
#* @get /obitos
function(ano, uf, cid){
  dados <- fetch_datasus(
    year_start = as.numeric(ano),
    year_end = as.numeric(ano),
    uf = uf,
    information_system = "SIM-DO"
  )
  dados <- process_sim(dados)
  resultado <- dados %>%
    filter(grepl(cid, CAUSABAS)) %>%
    group_by(MUNICRES) %>%
    summarise(qtd=n())
  return(resultado)
}

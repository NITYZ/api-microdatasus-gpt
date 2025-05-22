# API microdatasus GPT

API em R/plumber para consulta automática de dados do DATASUS via microdatasus, pronta para integração com ChatGPT e aplicações médicas.

## Como funciona

- Endpoint `/obitos`: Retorna, sob demanda, a contagem de óbitos por município filtrando por ano, UF e CID-10.
- Faz download e processamento automático direto do DATASUS (não precisa subir arquivos manualmente).
- Retorno em JSON, pronto para ser consumido por sistemas inteligentes (GPTs customizados, dashboards, etc).

## Exemplo de uso

GET https://<seu-endpoint>.onrender.com/obitos?ano=2020&uf=RJ&cid=U07


## Deploy

1. Crie uma conta gratuita em https://render.com
2. Clique em “New Web Service” e selecione seu repositório.
3. Configure:
   - **Build Command:** `Rscript install.R`
   - **Start Command:** `R -e "pr <- plumber::plumb('plumber.R'); pr$run(host='0.0.0.0', port=8080)"`
   - **Port:** 8080
4. Aguarde o deploy e use o endpoint gerado.

## Integração com GPT

Adicione o endpoint como Action/Function no seu GPT Builder ou aplicação customizada.  
Perguntas como “Óbitos por dengue no RJ em 2020” são respondidas automaticamente, sem download manual.


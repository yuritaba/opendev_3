# Use uma imagem base do Python
FROM python:3.9-slim

# Definir diretório de trabalho no container
WORKDIR /app

# Copiar todos os arquivos do projeto para o diretório de trabalho
COPY . /app

# Instalar dependências do sistema e do Python
RUN apt-get update && apt-get install -y \
    sqlite3 \
    && pip install --no-cache-dir Flask flask_httpauth

# Definir variáveis de ambiente para o Flask
ENV FLASK_APP=softdes.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000

# Criar o banco de dados e tabelas rodando o script SQL
RUN sqlite3 quiz.db < quiz.sql

# Adicionar usuários do arquivo users.csv rodando o script adduser.py
RUN python adduser.py

# Expor a porta 5000 para acessar o serviço
EXPOSE 5000

# Comando para iniciar o servidor Flask
CMD ["flask", "run"]
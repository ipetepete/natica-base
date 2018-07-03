#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER django WITH PASSWORD 'django' CREATEDB;
    CREATE DATABASE archive;
    CREATE DATABASE test;

    GRANT ALL PRIVILEGES ON DATABASE archive to django;
    GRANT ALL PRIVILEGES ON DATABASE test to django;
EOSQL

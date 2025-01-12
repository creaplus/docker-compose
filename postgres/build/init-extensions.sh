#!/bin/bash
set -e

echo "shared_preload_libraries = 'timescaledb,pg_stat_statements'" >> $PGDATA/postgresql.conf

pg_ctl -D $PGDATA restart

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;
    CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
    CREATE EXTENSION IF NOT EXISTS vector;
    CREATE EXTENSION IF NOT EXISTS pgmq;
EOSQL
    # CREATE EXTENSION IF NOT EXISTS vectorize CASCADE;
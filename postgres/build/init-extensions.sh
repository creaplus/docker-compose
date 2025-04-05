#!/bin/bash
set -e

echo "shared_preload_libraries = 'timescaledb,pg_stat_statements,pg_cron,vectorize'" >> $PGDATA/postgresql.conf
echo "cron.database_name = 'postgres'" >> $PGDATA/postgresql.conf
echo "wal_level = logical" >> $PGDATA/postgresql.conf


pg_ctl -D $PGDATA restart

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;
    CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
    CREATE EXTENSION IF NOT EXISTS pg_cron;
    CREATE EXTENSION IF NOT EXISTS vector;
    CREATE EXTENSION IF NOT EXISTS pgmq;
    CREATE EXTENSION IF NOT EXISTS aws_s3;
    CREATE EXTENSION IF NOT EXISTS vectorize CASCADE;
EOSQL
    # CREATE EXTENSION IF NOT EXISTS vectorize CASCADE;





    
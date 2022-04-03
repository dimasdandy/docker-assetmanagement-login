FROM postgres:13.2-alpine

ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=postgres

COPY migration.sql /docker-entrypoint-initdb.d

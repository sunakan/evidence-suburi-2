FROM node:22-bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends unzip curl ca-certificates

RUN curl -fsSL https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/main/install.sh | bash
RUN curl -fsSL https://github.com/duckdb/duckdb/releases/download/v1.2.0/duckdb_cli-linux-aarch64.zip | funzip > /usr/local/bin/duckdb && chmod 755 /usr/local/bin/duckdb


WORKDIR /app
RUN adduser app && chown app:app /app
COPY --chown=app:app . .
USER app
RUN npm --prefix ./my-evidence install

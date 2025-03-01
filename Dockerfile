FROM debian:bookworm-slim
#
# duckdb
# https://github.com/duckdb/duckdb/releases
# circleci cli
# https://github.com/CircleCI-Public/circleci-cli/releases
#
ENV DUCKDB_VERSION=1.2.0
ENV CIRCLECI_CLI_VERSION=0.1.31425
ENV CIRCLECI_CLI_TELEMETRY_OPTOUT=true

RUN apt-get update && apt-get install -y --no-install-recommends git unzip curl ca-certificates openssh-client
RUN curl -fsSL https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-aarch64.zip | funzip > /usr/local/bin/duckdb && chmod 755 /usr/local/bin/duckdb
RUN curl -fsSL https://github.com/CircleCI-Public/circleci-cli/releases/download/v${CIRCLECI_CLI_VERSION}/circleci-cli_${CIRCLECI_CLI_VERSION}_linux_arm64.tar.gz | tar -xzC /usr/local/bin circleci-cli_${CIRCLECI_CLI_VERSION}_linux_arm64/circleci --strip-components=1
RUN adduser tool
USER tool

#
# curl
# -f: HTTPサーバエラーが発生した時、失敗させる
# -s: サイレントモード
# -S: エラー時、エラーを表示
# -L: リダイレクトに追従
#

#
# tar
# -x: 抽出。tarファイルの内容を展開
# -z: gzip圧縮されたアーカイブを処理
# -C: 抽出先のディレクトリを指定
# --strip-components=1: 指定された数のディレクトリ階層を除去
#

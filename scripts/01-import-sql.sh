#!/usr/bin/env bash
set -euo pipefail
#set -x
# -e: エラーが発生した時点でスクリプトを終了
# -u: 未定義の変数を使用した場合にエラーを発生
# -x: スクリプトの実行内容を表示(debugで利用)
# -o pipefail: パイプライン内のエラーを検出

#
# sql(dataset)のimport
#
# 引数
# 1. SQLファイルパス
#
# 処理概要
# 1. ディレクトリ名がDB名
# 2. DB作成
# 3. datasetをimport
#
readonly file_path="${1}"
db_name=$(dirname "${file_path}" | xargs basename)
readonly db_name

echo
echo "IMPORT DATASET: ${file_path}"
echo "psql -Upostgres -c \"create database ${db_name};\""
psql -Upostgres -c "create database ${db_name};"
echo "psql -Upostgres -d \"${db_name}\" -f \"${file_path}\" &> /dev/null"
psql -Upostgres -d "${db_name}" -f "${file_path}" &> /dev/null

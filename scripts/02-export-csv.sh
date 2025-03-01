#!/usr/bin/env bash
set -euo pipefail
#set -x
# -e: エラーが発生した時点でスクリプトを終了
# -u: 未定義の変数を使用した場合にエラーを発生
# -x: スクリプトの実行内容を表示(debugで利用)
# -o pipefail: パイプライン内のエラーを検出

#
# DBにあるテーブルをcsvにexport
#
# 引数
# 1. ディレクトリパス
#
# 処理概要
# 1. ディレクトリ名がDB名
# 2. DBにあるテーブルを全てCSVへexport
#
readonly dir_path="${1}"
readonly csv_dir_path="${dir_path}/csv"
db_name=$(basename "${dir_path}")
readonly db_name

echo
echo "EXPORT CSV: ${db_name}"

tables=$(psql -Upostgres -d "${db_name}" -t -c "select tablename from pg_tables where schemaname = 'public';")
readonly tables

rm -rf "${csv_dir_path}"
mkdir -p "${csv_dir_path}"
for table in ${tables}
do
  csv_path="${csv_dir_path}/${table}.csv"
  psql -Upostgres -d "${db_name}" -c "copy \"${table}\" to '${csv_path}' with csv header;"
  ls "${csv_path}"
done

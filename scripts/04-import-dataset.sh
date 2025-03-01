#!/usr/bin/env bash
set -euo pipefail
#set -x
# -e: エラーが発生した時点でスクリプトを終了
# -u: 未定義の変数を使用した場合にエラーを発生
# -x: スクリプトの実行内容を表示(debugで利用)
# -o pipefail: パイプライン内のエラーを検出

#
# duckdbにimport
#
# 引数
# 1. ディレクトリパス
#
# 処理概要
# 1. ディレクトリパス/duckdb/以下にあるddl.sqlを実行
readonly dir_path="${1}"
readonly ddl_path="${dir_path}/duckdb/ddl.sql"
readonly duckdb_path="${dir_path}/duckdb/db.duckdb"

rm -f "${duckdb_path}"

echo
echo "IMPORT DATASET: ${dir_path}"

# migration
duckdb "${duckdb_path}" < "${ddl_path}"

#
# import
# 冪等性を持たせたいので、PK重複はignore
#
# auto_detect=trueは列の型や区切り文字、ヘッダ行の有無などを自動検出
#
while read -r csv_file
do
  table_name=$(basename "${csv_file%.csv}")
  echo $table_name
  duckdb "${duckdb_path}" "insert or ignore into \"${table_name}\" select * from read_csv('${csv_file}', auto_detect=true);"

  count=$(duckdb -csv -noheader "${duckdb_path}" "select count(1) from \"${table_name}\";")
  echo "${table_name}: ${count}行"
done < <(ls -1 "${dir_path}"/csv/*.csv)

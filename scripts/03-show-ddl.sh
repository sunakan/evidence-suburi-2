#!/usr/bin/env bash
set -euo pipefail
#set -x
# -e: エラーが発生した時点でスクリプトを終了
# -u: 未定義の変数を使用した場合にエラーを発生
# -x: スクリプトの実行内容を表示(debugで利用)
# -o pipefail: パイプライン内のエラーを検出

#
# DDLを表示(tables.sqlを手書きする時、楽するため)
#
# 引数
# 1. ディレクトリパス
#
# 処理概要
# 1. ディレクトリ名がDB名
# 2. ディレクトリパス/csv/以下にあるCSVをimport
# 3. DDL表示
#
readonly dir_path="${1}"
readonly duckdb_path="tmp/tmp.duckdb"
rm -f "${duckdb_path}"

echo
echo "SHOW DDL: ${dir_path}"

#
# %.csvは"〇〇.csv"から"〇〇"を抽出
#
while read -r csv_file_path
do
  table_name=$(basename "${csv_file_path%.csv}")
  duckdb "${duckdb_path}" "create table '${table_name}' as from '${csv_file_path}';"
done < <(ls -1 "${dir_path}"/csv/*.csv)

duckdb -csv -noheader "${duckdb_path}" -c 'select sql from duckdb_tables() where internal = false;'

rm -f "${duckdb_path}"

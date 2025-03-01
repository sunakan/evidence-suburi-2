.PHONY: up
up:
	@docker compose up -d

.PHONY: down
down:
	@docker compose down

.PHONY: import-sql
import-sql:
	@docker compose exec db bash -c 'ls -1 /app/data/**/*.sql | xargs -I{} bash /app/scripts/01-import-sql.sh {}'

.PHONY: export-csv
export-csv:
	@docker compose exec db bash -c 'ls -1 /app/data/ | xargs -I{} bash /app/scripts/02-export-csv.sh /app/data/csv/{}'

.PHONY: show-ddl
show-ddl:
	ls -1 data/ | xargs -I{} bash scripts/03-show-ddl.sh data/{}

.PHONY: import-dataset
import-dataset:
	ls -1 data/ | xargs -I{} bash scripts/04-import-dataset.sh data/{}

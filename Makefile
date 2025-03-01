.PHONY: up
up:
	@docker compose up -d db

.PHONY: up-evidence
up-evidence:
	@docker compose run --rm --service-ports evidence npm run dev

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
	@docker compose run --rm tool bash -c 'ls -1 data/ | xargs -I{} bash scripts/03-show-ddl.sh data/{}'

.PHONY: import-dataset
import-dataset:
	@docker compose run --rm tool bash -c 'ls -1 data/ | xargs -I{} bash scripts/04-import-dataset.sh data/{}'

.PHONY: gen-circleci-config
gen-circleci-config:
	@docker compose run --rm tool bash -c 'bash .circleci/bin/generate-config.sh'

.PHONY: build-and-push-image
build-and-push-image:
	$(eval IMAGE_REPO := ghcr.io/sunakan/evidence-suburi-2-tool)
	$(eval IMAGE_TAG := $(shell git rev-list -1 HEAD -- Dockerfile))
	docker build . --tag "${IMAGE_REPO}:latest"
	docker tag "${IMAGE_REPO}:latest" "${IMAGE_REPO}:${IMAGE_TAG}"
	docker push "${IMAGE_REPO}:latest"
	docker push "${IMAGE_REPO}:${IMAGE_TAG}"

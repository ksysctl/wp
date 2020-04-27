#!make

dev_dir=dev
data_dir=data

deploy_dir=$(dev_dir)/deploy
build_dir=$(dev_dir)/build
script_dir=$(dev_dir)/script

env_file=$(deploy_dir)/.env

ifneq ("$(wildcard $(env_file))","")
	include $(env_file)
	export $(shell sed 's/=.*//' $(env_file))
endif

compose_file=$(build_dir)/docker-compose.yml
docker_file=$(build_dir)/Dockerfile
setup_file=$(script_dir)/setup.sh
live_dump=$(data_dir)/sql/live.sql
local_dump=$(data_dir)/sql/local.sql

common_args=-f $(compose_file) --env-file $(env_file)

.PHONY: build rebuild up down logs shell setup restore backup

all: build
build:
ifdef WP_PROJECT
	docker-compose $(common_args) up --build --remove-orphans
endif
rebuild:
ifdef WP_PROJECT
	docker-compose $(common_args) build --no-cache
endif
up:
ifdef WP_PROJECT
	docker-compose $(common_args) up -d
endif
down:
ifdef WP_PROJECT
	docker-compose $(common_args) down
endif
logs:
ifdef WP_PROJECT
	docker-compose $(common_args) --verbose logs -f
endif
shell:
ifdef WP_PROJECT
	docker exec -it wp_webserver bash
endif
setup:
ifndef WP_PROJECT
	./$(setup_file)
endif
restore:
ifdef WP_PROJECT
	cat ${live_dump} | docker exec -i db_mysql \
		mysql -uroot -p${DB_ROOT_PASSWORD} ${DB_NAME} >/dev/null
	
	docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root search-replace ${WP_LIVE_URL} ${WP_LOCAL_URL} --skip-columns=guid'
endif
backup:
ifdef WP_PROJECT
	docker-compose $(common_args) exec db sh -c \
		'exec mysqldump ${DB_NAME} -uroot -p${DB_ROOT_PASSWORD}' > ${local_dump}
	sed -i '.bak' 1,1d ${local_dump} && rm "${local_dump}.bak"
endif
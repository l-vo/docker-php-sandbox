.DEFAULT_GOAL := help
PHP_VERSION := 7.3
SHELL := /bin/bash

.PHONY: clean exec logs new run start status stop

## ------

## Remove containers
clean:
	@PHP_VERSION=${PHP_VERSION} docker-compose -f docker/docker-compose.yml rm -vf

## Exec a shell into the phpfpm container
exec:
	@PHP_VERSION=${PHP_VERSION} docker-compose -f docker/docker-compose.yml exec php bash

## View logs
logs:
	@PHP_VERSION=${PHP_VERSION} docker-compose -f docker/docker-compose.yml logs -f

## Build, stop, remove and start containers
new: stop clean start

## Run and log into a PHP container
run:
	@PHP_VERSION=${PHP_VERSION} docker-compose -f docker/docker-compose.yml run --rm  php bash

## Start containers
start:
	@PHP_VERSION=${PHP_VERSION} docker-compose -f docker/docker-compose.yml up -d

## View containers states
status:
	@PHP_VERSION=${PHP_VERSION} docker-compose -f docker/docker-compose.yml ps

## Stop containers
stop:
	@PHP_VERSION=${PHP_VERSION} docker-compose -f docker/docker-compose.yml stop

## ------

# APPLICATION
APPLICATION := "PHP Sandbox"

# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

TARGET_MAX_CHAR_NUM=20
## Show this help
help:
	@echo '# ${YELLOW}${APPLICATION}${RESET} / ${GREEN}${ENV}${RESET}'
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			gsub(":", " ", helpCommand); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST) | sort
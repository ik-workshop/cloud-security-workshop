SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

INSTALL_BREW ?= false
export PYENV_LOCATION ?= $(shell which pyenv)
CLOUDMAPPER_PATH ?= vendor/cloudmapper

help:
	@printf "Usage: make [target] [VARIABLE=value]\nTargets:\n"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install-cm: ## Install Cloud Mapper
	-@scripts/install.sh --cloud-mapper

build-cm: ## Docker build Cloudmapper
	@scripts/cloudmapper.sh --docker-build

run-cm: ## Run cloudmapper
	@aws-vault exec $(AWS_PROFILE) -- scripts/cloudmapper.sh --docker-run

install-scout: ## Install StoryScout
	@scripts/scout.sh --install

run-scout: ## Install StoryScout
	@aws-vault exec $(AWS_PROFILE) -- scripts/scout.sh --run

run-prowler: ## Prowler
	@aws-vault exec $(AWS_PROFILE) -- scripts/prowler.sh --docker-run

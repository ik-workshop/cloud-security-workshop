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
	-@bin/install.sh --cloud-mapper

run-cm: ## Run cloudmapper on demo account
	@cd $(CLOUDMAPPER_PATH)
	@python cloudmapper.py prepare --config config.json.demo --account demo
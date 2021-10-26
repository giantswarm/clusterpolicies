SHELL:=/usr/bin/env bash

# If not already set through env
KUBERNETES_VERSION ?= v1.21.1

##@ Generate

.PHONY: generate
generate: ## Replace variables on Helm manifests.
	./hack/template.sh

.PHONY: verify
verify:
	@$(MAKE) generate
	git diff --exit-code

.PHONY: clean
clean:
	./hack/cleanup-local.sh

.PHONY: setup
setup:
	@$(MAKE) generate
	./hack/setup-local.sh $(KUBERNETES_VERSION)

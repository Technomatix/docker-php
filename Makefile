duild:
	cd image && IMAGE_NAME=local/php:5.6-cli-jessie ../hooks/build
	cd image && IMAGE_NAME=local/php:dev-5.6-cli-jessie ../hooks/build

test-environment: duild
	cd test && ./run.sh

.PHONY: test
test: lint

lint:
	shellcheck --exclude=SC2148 Makefile
	scripts/scripts.sh shellcheck
	scripts/scripts.sh shfmt -l -d

fmt:
	scripts/scripts.sh shfmt -l -w

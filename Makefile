test: lint

lint:
	shellcheck --exclude=SC2148 Makefile
	scripts/scripts.sh shellcheck
	scripts/scripts.sh shfmt -l -d

fmt:
	scripts/scripts.sh shfmt -l -w

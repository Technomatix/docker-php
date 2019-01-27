#!/usr/bin/env bash

cmd="$*"

for file in $(find . -iname "*.sh") $(find ./image/hooks/ -type f); do
	${cmd} "${file}"
done

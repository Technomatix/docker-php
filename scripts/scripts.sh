#!/usr/bin/env bash

cmd="$*"

for file in $(find . -iname "*.sh") $(find ./images/hooks/ -type f); do
	${cmd} "${file}"
done

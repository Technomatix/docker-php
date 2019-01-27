#!/usr/bin/env bash

set -e

docker run -it --rm --volume "$(pwd)/environment:/spec" local/php:5.6-cli-jessie /spec/environment.sh
docker run -it --rm --volume "$(pwd)/environment:/spec" local/php:dev-5.6-cli-jessie /spec/environment.sh _dev

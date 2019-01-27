#!/usr/bin/env bash

# Expands variables and prints a little + sign before the line.
set -o xtrace

version=${1:-"5.6-cli-jessie"}

export BUILD_CODE="local"
export BUILD_PATH="/images/Dockerfile-$version"
export CACHE_TAG=
export COMMIT_MSG=""
export DEBIAN_FRONTEND=noninteractive
export DOCKERCFG=
export DOCKERFILE_PATH=
export DOCKER_HOST=unix:///var/run/docker.sock
export DOCKER_REPO=local/php
export DOCKER_TAG="$version"
export GIT_MSG=
GIT_SHA1=$(git log -n 1 --pretty=format:%h)
export GIT_SHA1
#export HOME=$(pwd)
#export  HOSTNAME=$(hostname)
export IMAGE_NAME="$DOCKER_REPO:$version"
export MAX_LOG_SIZE=67108864
#PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PUSH=true
#PWD=/src/bhryrpcjxhfmt42gbp57uac/images
export PYTHONUNBUFFERED=1
export SHLVL=1
export SIGNED_URLS=
export SOURCE_BRANCH=
export SOURCE_TYPE=git

cd images || exit
hooks/build
hooks/post_push

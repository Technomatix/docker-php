#!/usr/bin/env sh

GOSS_VERSION="0.3.4"
SPEC_NAME=environment${1}.yaml

echo "Download Goss..."
curl --silent --location https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/goss-linux-amd64 --output goss >/dev/null
chmod +rx goss

echo "Validate spec: ${SPEC_NAME}..."
./goss --gossfile "/spec/${SPEC_NAME}" validate

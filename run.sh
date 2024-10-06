#!/usr/bin/env bash

set -xeuo pipefail

docker build -t lh-test .
docker run --rm -ti lh-test

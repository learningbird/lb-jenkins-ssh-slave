#!/bin/bash
set -euo pipefail

tag_name=$(git describe --tags --abbrev=0);

$(aws ecr get-login --profile default)
docker push 563519383004.dkr.ecr.us-west-2.amazonaws.com/lb-jenkins-ssh-slave:"$tag_name"

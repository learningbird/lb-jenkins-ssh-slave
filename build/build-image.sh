#!/bin/bash
set -euo pipefail

env

tag_name=$(git describe --tags --abbrev=0)
tag_hash=$(git rev-list -n 1 "$tag_name")
current_commit_hash=$(git rev-parse HEAD)

echo "Tag name: $tag_name"
if [[ "$current_commit_hash" !=  "$tag_hash" ]]; then
    echo "Cannot build an untagged commit. Tag the commit you want to build."
    echo "Tag is at commit: $tag_hash"
    echo "Current commit: $current_commit_hash"
    exit 1
fi

docker build image --tag 563519383004.dkr.ecr.us-west-2.amazonaws.com/lb-jenkins-ssh-slave:"$tag_name"

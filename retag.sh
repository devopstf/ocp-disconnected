#!/bin/bash

if [ $# -lt 2 ]; then
  echo 1>&2 "Usage: retag.sh <path/to/file/to/be/read> <rh-repository-name>"
  exit 2
elif [ $# -gt 2 ]; then
  echo 1>&2 "[ERROR]: too many arguments"
  exit 2
fi

filename=$1
filelines=`cat $filename`
registry="registry.redhat.io/$2"
major="v3.11"
minor="16"
local="localhost:5000"
tag="latest"

echo Start

for line in $filelines ; do
    echo $line
done

for line in $filelines ; do
    sh -c "docker tag $registry/$line:$tag $local/$line:$major.$minor" && \
    sh -c "docker push $local/$line:$major.$minor" && \
    sh -c "docker tag $registry/$line:$tag $local/$line:$major" && \
    sh -c "docker push $local/$line:$major" && \
done

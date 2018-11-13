#!/bin/bash

filename=./test-images
filelines=`cat $filename`
registry="registry.hub.docker.com/library"
major="1.14"
minor="1"
local="localhost:5000"
tag="latest"

echo Start

for line in $filelines ; do
    echo "Pulling $line:$tag from $registry" && \
    sh -c "docker pull $registry/$line:$tag"
done

for line in $filelines ; do
    echo "Re-Tagging $line:$tag to $line:$major:$minor to local registry" && \
    sh -c "docker tag $registry/$line:$tag $local/$line:$major.$minor" && \
    echo "Pushing $line:$major.$minor to local registry" && \
    sh -c "docker push $local/$line:$major.$minor" && \
    echo "Re-Tagging $line:$tag to $line:$major for local registry" && \
    sh -c "docker tag $registry/$line:$tag $local/$line:$major" && \
    echo "Pushing $line:$major to local registry" && \
    sh -c "docker push $local/$line:$major" && \
    echo "Removing $line:$tag image" && \
    sh -c "docker rmi $registry/$line:$tag" && \
    echo "I'm Done!"
done

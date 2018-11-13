#!/bin/bash

filename=./etcd-images
filelines=`cat $filename`
registry="registry.redhat.io"
major="3.2"
minor="22"
local="localhost:5000"
tag="latest"

echo Start

for line in $filelines ; do
    echo $line
done

for line in $filelines ; do
    sh -c "docker tag $registry/$line:$tag $local/$line:$major.$minor" && \
    sh -c "docker push $local/$line:$major.$minor" && \
    sh -c "docker rmi $registry/$line:$tag" && \
    sh -c "docker rmi $registry/$line:$major.$minor"
done

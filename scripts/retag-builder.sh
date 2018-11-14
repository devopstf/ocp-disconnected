#!/bin/bash

filename=../images/builder-images
filelines=`cat $filename`
registry="registry.redhat.io"
major="v3.11"
minor="16"
local="localhost:5000"
tag="latest"

echo Start

for line in $filelines ; do
    echo $line
done

for line in $filelines ; do
    docker tag $registry/$line:$tag $local/$line:$major.$minor && \
    docker push $local/$line:$major.$minor && \
    docker rmi $registry/$line:$tag
done

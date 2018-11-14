#!/bin/bash

filename=../images/rhgs3-images
filelines=`cat $filename`
registry="registry.redhat.io"
local="localhost:5000"
tag="latest"

echo Start

for line in $filelines ; do
    echo $line
done

for line in $filelines ; do
    version=$(docker inspect $registry/$line | grep -m1 version | awk '{print $2}' | sed -e 's/^"//' -e 's/"$//') && \
    docker tag $registry/$line:$tag $local/$line:$version && \
    docker push $local/$line:$version && \
    docker rmi $registry/$line:$tag
done
#!/bin/sh

name="jupyterlab"
image="continuumio/anaconda3"

#if [ $# -ne 1 ]; then
#    echo usage: $0 password
#    exit 1
#fi

echo stopping $name container...
docker stop $name

echo removing $name container...
docker rm $name

#echo downloading latest image from $image...
#docker pull $image

echo starting service...

docker run \
-dt \
--restart always \
--cpus 1 \
--memory 1024M \
--name $name \
--net backend \
-v /mnt/notebook:/mnt \
$image \
/bin/bash \
-c "/opt/conda/bin/jupyter lab \
--notebook-dir=/mnt \
--ip='*' \
--port=80 \
--NotebookApp.password='sha1:52cd1c27f679:e7462eee42905d2b55ed2308fd4a3cd9acc75be4' \
--allow-root \
--no-browser"

echo $name server created, monitoring port 8844...


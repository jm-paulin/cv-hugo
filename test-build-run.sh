#! /usr/bin/env bash

docker build -t www-kalm-with-kally:latest \
    --build-arg BASE_URL=http://localhost:8080/ \
    .
docker rm kalm-with-kally
docker run -it --rm --name kalm-with-kally -p 8080:80 www-kalm-with-kally:latest

# wget --quiet "https://github.com/gohugoio/hugo/releases/download/v0.111.2/hugo_extended_0.111.2_linux-amd64.tar.gz" 
# tar xvzf hugo_extended_0.111.2_linux-amd64.tar.gz 
# rm -r hugo_extended_0.111.2_linux-amd64.tar.gz 
# mv hugo /usr/local/bin
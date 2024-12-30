FROM ubuntu AS build
ARG BASE_URL=https://jean-marc.paulin.co.uk/
RUN apt-get update && apt-get install -y wget unzip
    
ARG HUGO_VERSION="0.140.2"
ARG OWL_CAROUSEL_VERSION="2.3.4"
RUN wget --quiet "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz" && \
    tar xvzf hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz && \
    rm -r hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz && \
    mv hugo /usr/local/bin
COPY ./ /site 

WORKDIR /site
RUN hugo version && hugo --baseURL $BASE_URL

# Copy static files to Nginx
FROM nginx:alpine-slim
COPY --from=build /site/public /usr/share/nginx/html
COPY etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html

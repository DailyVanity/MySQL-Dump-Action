FROM alpine:latest

MAINTAINER Chris Sim <chris.sim@dailyvanity.sg>

RUN apk add --update \
    python \
    python-dev \
    py3-setuptools \
    py-pip \
    build-base \
    curl \
    mysql-client \
    && apk --purge -v del py-pip \
    && rm -rf /var/cache/apk/*

RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
RUN unzip awscli-bundle.zip
RUN ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

RUN mkdir /working
WORKDIR /working
COPY entryscript.sh /working/entryscript.sh
RUN chmod +x /working/entryscript.sh

ENTRYPOINT [ "/working/entryscript.sh" ]
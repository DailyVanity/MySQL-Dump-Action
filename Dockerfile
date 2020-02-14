FROM alpine:3.9

MAINTAINER Chris Sim <chris.sim@dailyvanity.sg>

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
    mysql-client \
    && pip install awscli==1.16.310 --upgrade --user \
    && apk --purge -v del py-pip \
    && rm -rf /var/cache/apk/*

RUN mkdir /working
WORKDIR /working
COPY entryscript.sh /entryscript.sh
RUN chmod +x /entryscript.sh

ENTRYPOINT ["/entryscript.sh"]
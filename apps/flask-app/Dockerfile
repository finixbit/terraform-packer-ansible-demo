FROM python:2.7-alpine3.8
MAINTAINER Samuel Asirifi <samuelasirifi1@gmail.com> 

RUN apk add --no-cache bash

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
RUN scripts/install.sh

# Expose the Flask port
EXPOSE 8000

CMD ["scripts/server.sh"]
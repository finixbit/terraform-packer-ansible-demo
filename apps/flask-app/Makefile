.PHONY: clean build run dev stop inspect

IMAGE_NAME = finixbit/flask-app
CONTAINER_NAME = flask-app

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker start $(CONTAINER_NAME) || docker run --restart=always --rm -d -p 8000:8000 --name $(CONTAINER_NAME) -e "FLASK_ENV=production" $(IMAGE_NAME) 

dev:
	docker run --rm -p 8000:8000 --name $(CONTAINER_NAME) -e "FLASK_ENV=development" -v $(shell pwd):/usr/src/app $(IMAGE_NAME)

inspect:
	docker inspect $(CONTAINER_NAME)

shell:
	docker exec -it $(CONTAINER_NAME) /bin/sh

stop:
	docker stop $(CONTAINER_NAME)

clean:
	docker ps -a | grep '$(CONTAINER_NAME)' | awk '{print $$1}' | xargs docker rm \
	docker images | grep '$(IMAGE_NAME)' | awk '{print $$3}' | xargs docker rmi
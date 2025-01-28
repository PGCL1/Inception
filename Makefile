SHELL := /bin/sh

IMAGES = $(shell docker images -q)
ACTIVE_CONTAINERS = $(shell docker ps -q)
ALL_CONTAINERS = $(shell docker ps -a -q)

all: 
	@echo "These are your docker images <$(IMAGES)>"
	@echo "These are your docker active containers <$(ACTIVE_CONTAINERS)>"
	@echo "These are your docker containers <$(ALL_CONTAINERS)>"

build: 
	@docker compose up -f srcs/docker-compose.yaml up -d build

remove:
	@docker compose down

clean: #clean containers
	@docker rm $(ACTIVE_CONTAINERS)

fclean: #clean all containers and images
	@docker rm $(ALL_CONTAINERS)
	@docker rmi $(IMAGES)



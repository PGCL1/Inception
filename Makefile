SHELL := /bin/sh
DOCKER_FOLDER := srcs

IMAGES = $(shell docker images -a -q)
ALL_CONTAINERS = $(shell docker ps -a -q)

# rajoute un check si images = NULL ou ALLCONTAINERS= NULL

all: 
	@docker compose -f $(DOCKER_FOLDER)/docker-compose.yaml up -d --build

remove:
	@docker compose -f $(DOCKER_FOLDER)/docker-compose.yaml down 

clean: #clean containers
	@docker stop $(ALL_CONTAINERS)
	@docker rm $(ALL_CONTAINERS)
	@docker rmi $(IMAGES)

fclean: #clean all containers and images
	@docker compose -f $(DOCKER_FOLDER)/docker-compose.yaml down --volumes
	@docker stop $(ALL_CONTAINERS)
	@docker rm $(ALL_CONTAINERS)
	@docker rmi $(IMAGES)



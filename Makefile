SHELL := /bin/sh
DOCKER_FOLDER := srcs

IMAGES = $(shell docker images -a -q)
ALL_CONTAINERS = $(shell docker ps -a -q)

all: 
	@mkdir -p ${HOME}/data/db
	@mkdir -p ${HOME}/data/wp-files
	@docker compose -f $(DOCKER_FOLDER)/docker-compose.yaml up -d --build

remove:
	@docker compose -f $(DOCKER_FOLDER)/docker-compose.yaml down 

clean: # clean containers
	@if [ -z "$(strip $(ALL_CONTAINERS))" ]; then \
		echo "No containers have been launched"; \
	else \
		docker stop $(ALL_CONTAINERS); \
		docker rm $(ALL_CONTAINERS); \
	fi
	@if [ -z "$(strip $(IMAGES))" ]; then \
		echo "No images are present"; \
	else \
		docker rmi $(IMAGES); \
	fi

fclean: # clean all containers and images
	@docker compose -f $(DOCKER_FOLDER)/docker-compose.yaml down --volumes
	@if [ -z "$(strip $(IMAGES))" ]; then \
		echo "No images are present"; \
	else \
		docker rmi $(IMAGES); \
	fi
	@rm -rf ${HOME}/data/db
	@rm -rf ${HOME}/data/wp-files


re: fclean all

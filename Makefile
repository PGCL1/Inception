SHELL := /bin/sh
DOCKER_FOLDER := srcs

IMAGES = $(shell docker images -a -q)
ALL_CONTAINERS = $(shell docker ps -a -q)
ALL_VOLUMES = $(shell docker volume list -q)

all: 
	@mkdir -p /home/glacroix/data/db
	@mkdir -p /home/glacroix/data/wp-files
	@docker compose -f $(DOCKER_FOLDER)/docker-compose.yaml up --build 

echo:
	@echo
	@docker images -a
	@echo "Active docker images are: " $(IMAGES)
	@echo
	@docker ps -a
	@echo "All docker containers are: "$(ALL_CONTAINERS)
	@echo
	@docker volume list
	@echo "All docker volumes are: "$(ALL_VOLUMES)

remove:
	@docker compose -f $(DOCKER_FOLDER)/docker-compose.yaml down 

clean: # clean containers
	@docker compose -f $(DOCKER_FOLDER)/docker-compose.yaml down --rmi all

fclean: # clean all containers and images
	@docker compose -f $(DOCKER_FOLDER)/docker-compose.yaml down --volumes --rmi all --remove-orphans
	rm -rf /home/glacroix/data/db
	rm -rf /home/glacroix/data/wp-files


re: fclean all

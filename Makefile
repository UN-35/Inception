WP_DATA = /home/data/wordpress #define the path to the wordpress data
DB_DATA = /home/data/mariadb #define the path to the mariadb data

# default target
all: up

# start the biulding process
# create the wordpress and mariadb data directories.
# start the containers in the background and leaves them running
up: build
	@sudo mkdir -p $(WP_DATA)
	@sudo mkdir -p $(DB_DATA)
	docker-compose -f ./srcs/docker-compose.yml up -d

# stop the containers
down:
	docker-compose -f ./srcs/docker-compose.yml down

# stop the containers
stop:
	docker-compose -f ./srcs/docker-compose.yml stop

# start the containers
start:
	docker-compose -f ./srcs/docker-compose.yml start

# build the containers
build:
	docker-compose -f ./srcs/docker-compose.yml build

# clean the containers
# stop all running containers and remove them.
# remove all images, volumes and networks.
# remove the wordpress and mariadb data directories.
# the (|| true) is used to ignore the error if there are no containers running to prevent the make command from stopping.
clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true

# clean and start the containers
re: clean up

# prune the containers: execute the clean target and remove all containers, images, volumes and networks from the system.
prune: clean
	@docker system prune -a --volumes -f
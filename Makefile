WP_DATA = /home/yoelansa/data/wordpress #define the path to the wordpress data
DB_DATA = /home/yoelansa/data/mariadb #define the path to the mariadb data

all: up

up: build
	@sudo mkdir -p $(WP_DATA)
	@sudo mkdir -p $(DB_DATA)
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

start:
	docker-compose -f ./srcs/docker-compose.yml start

build:
	docker-compose -f ./srcs/docker-compose.yml build

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true

re: clean up

prune: clean
	@docker system prune -a --volumes -f

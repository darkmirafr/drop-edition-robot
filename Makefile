all: install run logs

check_env_file:
	test -f .env || (echo "Create your .env from .env.dist first" && exit 2)

install: check_env_file
	git clone git@github.com:Darkmira/drop-robotapi.git services/drop-robotapi --branch feature/robot-api || true
	git clone git@github.com:Darkmira/drop-fleetcontrol-slave.git services/drop-fleetcontrol-slave || true

	docker-compose up -d
	docker exec -ti drop-robotapi-php sh -c "touch services/drop-robotapi/.env"
	docker exec -ti drop-robotapi-php sh -c "cd services/drop-robotapi && composer install"
	docker exec -ti drop-robotapi-php sh -c "cd services/drop-fleetcontrol-slave && composer install"

run:
	docker-compose up -d

stop:
	docker-compose down

logs:
	docker-compose logs -ft

bash: run
	docker exec -ti drop-robotapi-php sh

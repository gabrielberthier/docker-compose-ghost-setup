COMPOSE=docker-compose -f docker-compose.yml
COMPOSE_DEV=docker-compose -f ./dev/docker-compose.dev.yml

run: ./setup.sh

run-dev: docker compose -f ./dev/docker-compose.dev.yml

stop: docker stop $$(docker ps -q) || true

stop-containers: $(COMPOSE) $(shell true && echo $(COMPOSE_DEV)) stop $$ARGS

remove-containers: stop-containers
	$(COMPOSE) $(shell true && echo $(COMPOSE_dev)) rm -f $$ARGS
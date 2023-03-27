COMPOSE=docker-compose -f docker-compose.yml
COMPOSE_DEV=docker-compose -f docker-compose.dev.yml

run: ./setup.sh

stop: docker stop $$(docker ps -q) || true

stop-containers: $(COMPOSE) $(shell true && echo $(COMPOSE_DEV)) stop $$ARGS

remove-containers: stop-containers
	$(COMPOSE) $(shell true && echo $(COMPOSE_dev)) rm -f $$ARGS
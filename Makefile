# Customize project name, python version etc. in the variables bellow
	# Container
IMAGE_NAME=my-python
CONTAINER_NAME=hello
REP_TAG=3.8.6-alpine
UPDATE_ENABLE=false
	# Project
PRJ_NAME="Python Webserver"
PRJ_DESCRIPTION="Container to run a webserver using python 3.8"
PRJ_VERSION="0.1.0"
	# App
	# NOTE: USER must follow NAME_REGEX="^[a-z][-a-z0-9_]*\$"
APP_NAME=hello
APP_PORT=34040
APP_USER=pyuser

# Standalone python project
.PHONY: init
init:
	pip3 install -r requirements.txt

.PHONY: run
run:
	python3 -m $(APP_NAME)

# Python inside docker
.PHONY: build-docker
build-docker:
	echo $(APP_NAME) $(APP_PORT) $(APP_USERNAME)
	docker image build -t $(IMAGE_NAME) \
		--build-arg REP_TAG=$(REP_TAG) \
		--build-arg UPDATE_ENABLE=$(UPDATE_ENABLE) \
		--build-arg PRJ_NAME=$(PRJ_NAME) \
		--build-arg PRJ_DESCRIPTION=$(PRJ_DESCRIPTION) \
		--build-arg PRJ_VERSION=$(PRJ_VERSION) \
		--build-arg APP_NAME=$(APP_NAME) \
		--build-arg APP_PORT=$(APP_PORT) \
		--build-arg APP_USER=$(APP_USER) .

.PHONY: run-docker
run-docker:
	docker container run \
		--name $(CONTAINER_NAME) \
		--publish $(APP_PORT):$(APP_PORT) \
		--detach \
		$(IMAGE_NAME)

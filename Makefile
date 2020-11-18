# Customize project name, python version etc. in the variables bellow
	# Container with python
IMAGE_NAME=my-python
CONTAINER_NAME=hello
REP_TAG=3.8.6-alpine
	# Container with exe
EXE_IMAGE_NAME=my-python-exe
EXE_CONTAINER_NAME=hello-exe
EXE_REP_TAG=buster-slim
	# Overall container flags
UPDATE_ENABLE=false
RESTART=unless-stopped
	# Project labels
PRJ_NAME="Python Webserver"
PRJ_DESCRIPTION="Container to run a webserver using python"
PRJ_VERSION="0.1.0"
	# App parameters
	# NOTE: APP_NAME must be the name of project main folder
	# NOTE: USER must follow NAME_REGEX="^[a-z][-a-z0-9_]*\$"
APP_NAME=hello
APP_PORT=34040
APP_USER=pyuser

# encryption key to pyinstaller
KEY=DA20180514170054

# build python exe with pyinstaller
.PHONY: build
build:
	pyinstaller --onefile --name=$(APP_NAME) --key=$(KEY) ./$(APP_NAME)/__main__.py

# build docker container
.PHONY: build-docker
build-docker:
	echo $(APP_NAME) $(APP_PORT) $(APP_USERNAME)
	docker image build -t $(IMAGE_NAME) \
		--build-arg EXE_REP_TAG=$(REP_TAG) \
		--build-arg UPDATE_ENABLE=$(UPDATE_ENABLE) \
		--build-arg PRJ_NAME=$(PRJ_NAME) \
		--build-arg PRJ_DESCRIPTION=$(PRJ_DESCRIPTION) \
		--build-arg PRJ_VERSION=$(PRJ_VERSION) \
		--build-arg APP_NAME=$(APP_NAME) \
		--build-arg APP_PORT=$(APP_PORT) \
		--build-arg APP_USER=$(APP_USER) .

# build docker container for exe file
.PHONY: build-docker-exe
build-docker-exe:
	echo $(APP_NAME) $(APP_PORT) $(APP_USERNAME)
	docker image build -t $(EXE_IMAGE_NAME) -f DockerfileExe \
		--build-arg REP_TAG=$(EXE_REP_TAG) \
		--build-arg UPDATE_ENABLE=$(UPDATE_ENABLE) \
		--build-arg PRJ_NAME=$(PRJ_NAME) \
		--build-arg PRJ_DESCRIPTION=$(PRJ_DESCRIPTION) \
		--build-arg PRJ_VERSION=$(PRJ_VERSION) \
		--build-arg APP_NAME=$(APP_NAME) \
		--build-arg APP_PORT=$(APP_PORT) \
		--build-arg APP_USER=$(APP_USER) .

# removes files and folders generated by build
.PHONY: clear
clear:
	rm -R ./build
	rm -R ./dist
	rm -R ./$(APP_NAME).spec


# TODO build sphynx docs
.PHONY: docs
docs:
	echo "not implememted"

# Install install required libraries
.PHONY: init
init:
	pip3 install -r requirements.txt
	pip3 install -r requirements-dev.txt

# inspect security issues in python code
.PHONY: inspect
inspect:
	bandit -r ./$(APP_NAME)

# run with python
.PHONY: run
run:
	python3 -m $(APP_NAME)

# run exe (after build)
.PHONY: run-exe
run-exe:
	./dist/$(APP_NAME)

# run docker container
.PHONY: run-docker
run-docker:
	docker container run \
		--name $(CONTAINER_NAME) \
		--publish $(APP_PORT):$(APP_PORT) \
		--restart $(RESTART) \
		--detach \
		$(IMAGE_NAME)

# run exe docker container
.PHONY: run-docker-exe
run-docker-exe:
	docker container run \
		--name $(EXE_CONTAINER_NAME) \
		--publish $(APP_PORT):$(APP_PORT) \
		--restart $(RESTART) \
		--detach \
		$(EXE_IMAGE_NAME)

# run python tests with pytest
.PHONY: test
test:
	pytest -rA tests

# run pytest with coverage
.PHONY: test-cov
test-cov:
	pytest -rA --cov=$(APP_NAME) tests/

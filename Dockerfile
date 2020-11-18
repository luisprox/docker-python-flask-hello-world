# Base image
# https://hub.docker.com/_/python
ARG REP_TAG="3.8.6-alpine"
FROM python:${REP_TAG}

# Project args
ARG UPDATE_ENABLE=false
ARG PRJ_NAME="Python Webserver"
ARG PRJ_DESCRIPTION="Container to run a webserver using python 3.8"
ARG PRJ_VERSION="0.1.0"
ARG APP_NAME=hello
ARG APP_PORT=34040
ARG APP_USER=pyuser

# Logs forwarding
RUN ln -sf /dev/stdout /dev/stderr

# Descriptions
LABEL vendor="ACME" \
      project=${PRJ_NAME} \
      version=${PRJ_VERSION} \
      description=${PRJ_DESCRIPTION}

# Environment variables
ENV PORT=${APP_PORT} APP=${APP_NAME}

# App to project folder
WORKDIR /usr/src/
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY ./${APP_NAME} ./${APP_NAME}

# Non-root user
RUN addgroup --system ${APP_NAME} && \
    adduser --no-create-home --system ${APP_USER} && \
    adduser ${APP_USER} ${APP_NAME} && \
    mkdir -p /usr/src/${APP_NAME} && \
    chown -R ${APP_USER}:${APP_NAME} /usr/src/${APP_NAME} && \
    chmod -R 770 /usr/src/${APP_NAME}

# App webserver port
EXPOSE ${APP_PORT}/tcp

# OS update
RUN if [ "${UPDATE_ENABLE}" = "true" ]; \
    then apt-get update && apt-get dist-upgrade -y; \
    else echo "No OS update"; \
    fi

# App user and cmd
# NOTE1: CMD with "sh -c" is required to allow using ENV ${APP}
# NOTE2: ${APP} must not be alone in CMD list
USER ${APP_USER}
# ENTRYPOINT ["python"]
CMD ["sh", "-c", "python -m ${APP}"]

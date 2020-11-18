# Hello, World (Docker/Python/Flask)

Sample flask webserver using docker container in linux.

# Running standalone python

Installation
```bash
$ sudo apt update && sudo apt full-upgrade
$ sudo apt install python3 pip3
```
Run using Makefile
```bash
$ make init
$ make run
```

# Running inside Docker Container

Installation
```bash
$ sudo apt update && sudo apt full-upgrade
$ sudo apt install python3 pip3
```
Run using Makefile
```bash
$ make build-docker
$ make run-docker
```

# Customization parameters

Example using different python container with different webserver port
```bash
$ make build-docker REP_TAG=3.9-slim-buster APP_PORT=4040
$ make run-docker APP_PORT=4040
```
See [Makefile][Makefile] for more customizations.

# License

Licensed under MIT. Please see [LICENSE](LICENSE) for details.

# Recommended reads

[Structure your repository][https://docs.python-guide.org/writing/structure/#structure-of-the-repository]
[Simple Python Project Structure][https://dev.to/codemouse92/dead-simple-python-project-structure-and-imports-38c6]
[Sample Python Project][https://github.com/pypa/sampleproject]
[Sample Flask Project][https://flask.palletsprojects.com/en/1.0.x/tutorial/layout/]
[Dockerfile Best Practices][https://docs.docker.com/develop/develop-images/dockerfile_best-practices/]
[Use ARG and ENV variables in Dockerfile CMD][https://github.com/moby/moby/issues/5509]

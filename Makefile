NAME   := 025772230981.dkr.ecr.eu-central-1.amazonaws.com/blog
TAG    := $(shell git --no-pager log -n 1 --pretty=format:'%h-%cd' --date=short ./)

# TAG ?= $(shell git --no-pager log -n 1 --pretty=format:'%h-%cd' --date=short ./)

# Install virtualenv dir
install-venv:
	virtualenv -p python3.7 venv
	pip install -r requirements.txt

# Activate virtualenv
start-venv:
	source venv/bin/activate

save-dep:
	pip freeze > requirements.txt

dbuild:
	@docker build -t ${NAME}:latest .
	#@docker tag ${NAME}:${TAG} ${NAME}:latest


##############

.PHONY: init
init:
	@echo "Requirements: pip, virtualenv, docker, ansible"
	virtualenv -p python3.7 venv
	pip install -r requirements.txt
	source venv/bin/activate

.PHONY: build
build: init
	docker build -t ${NAME}:${TAG} .
	docker tag build:${TAG} ${DOCKER_REPO}/${NAME}:${TAG} #swap to version

.PHONY: deploy
deploy: build
	docker push ${NAME}:latest
	ansible-playbook -i "amaslakov.com," ./infra/ansible/blog_deployment.yml -u ec2-user --key-file "~/.ssh/amaslakov.com.pem"


.PHONY: run
run:
	docker run -p 80:80 -it ${NAME}:latest

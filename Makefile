TAG    := $(shell git --no-pager log -n 1 --pretty=format:'%h-%cd' --date=short ./)
DOCKER_REPO=amaslak0v
USER=ubuntu

### Local

.PHONY: init
init:
	@echo "Requirements: pip, virtualenv, docker, ansible"
	virtualenv -p python3.7 venv
	pip install -r requirements.txt
	ansible-galaxy install -r infra/ansible/requirements.yml

.PHONY: save-deps
save-deps:
	pip freeze > requirements.txt

.PHONY: local-run
local-run:
	flask run

### Docker

.PHONY: build
build: init
	docker build -t ${DOCKER_REPO}/blog:${TAG} .
# 	docker tag ${DOCKER_REPO}/log:${TAG} ${DOCKER_REPO}/blog:${TAG}

.PHONY: deploy
deploy: build
	docker push ${DOCKER_REPO}/blog:${TAG}
	@echo "Deploying ${DOCKER_REPO}/blog:${TAG}"
	export ANSIBLE_HOST_KEY_CHECKING=False
	ansible-playbook -i "amaslakov.com," ./infra/ansible/blog.yml -e "blog_image_version=${TAG}" -u ${USER} --key-file "~/.ssh/amaslakov.com.pem" -t deploy

.PHONY: redeploy
fdeploy:
	@echo "Deploying ${DOCKER_REPO}/blog:${TAG}"
	export ANSIBLE_HOST_KEY_CHECKING=False
	ansible-playbook -i "amaslakov.com," ./infra/ansible/blog.yml -e "blog_image_version=${TAG}" -u ${USER} --key-file "~/.ssh/amaslakov.com.pem" -t deploy

.PHONY: install
install:
	@echo "Installing infrastructure"
	export ANSIBLE_HOST_KEY_CHECKING=False
	ansible-playbook -i "amaslakov.com," ./infra/ansible/blog.yml -e "blog_image_version=${TAG}" -u ${USER} --key-file "~/.ssh/amaslakov.com.pem" -t install -v

.PHONY: run
run:
	docker run -p 80:80 -it ${DOCKER_REPO}/blog:${TAG}

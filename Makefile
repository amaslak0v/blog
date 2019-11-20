NAME   := 025772230981.dkr.ecr.eu-central-1.amazonaws.com/blog
TAG    := $(shell git --no-pager log -n 1 --pretty=format:'%h-%cd' --date=short ./)

# TAG ?= $(shell git --no-pager log -n 1 --pretty=format:'%h-%cd' --date=short ./)

# Install virtualenv dir
install-venv:
	virtualenv -p python3.7 venv

# Activate virtualenv
start-venv:
	source venv/bin/activate

save-dep:
	pip freeze > requirements.txt

install-dep:
	pip install -r requirements.txt

# TODO: test
run:
	flask run 

dbuild:
	@docker build -t ${NAME}:${TAG} .
	@docker tag ${NAME}:${TAG} ${NAME}:latest

drun:
	@docker run -p 80:5000 -it ${NAME}:latest

dpush:
	@echo "> Pushing to ECR"
	@docker push ${NAME}:${TAG}

deploy: dbuild dpush
	

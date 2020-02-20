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

run: 
	@echo "use `make start-venv`"
	flask run 

dbuild:
	@docker build -t ${NAME}:latest .
	#@docker tag ${NAME}:${TAG} ${NAME}:latest

drun:
	@docker run -p 80:80 -it ${NAME}:latest

dpush:
	@echo "> Pushing to ECR"
	@docker push ${NAME}:latest

deploy: dbuild dpush
	

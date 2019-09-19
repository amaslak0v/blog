
install-venv:
	virtualenv -p python3.7 venv

save-dep:
	pip freeze > requirements.txt

install-dep:
	pip install -r requirements.txt

flask-start:
	flask run

docker-build:
	docker build -t blog .

docker-run:
	docker run -p 80:5000 -it blog


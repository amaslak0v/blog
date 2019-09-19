
install-venv:
	virtualenv -p python3.7 venv

save-dep:
	pip freeze > requirements.txt

install-dep:
	pip install -r requirements.txt

flask-start:
	flask run

	

FROM python:3.7
ADD . /blog
WORKDIR /blog
EXPOSE 80
RUN pip install -r requirements.txt
CMD ["flask", "run", "--host=0.0.0.0", "--port=80"]

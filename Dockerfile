FROM python:3.7
ADD . /blog
WORKDIR /blog
EXPOSE 5000
RUN pip install -r requirements.txt
ENTRYPOINT ["flask","run","--host=0.0.0.0"]

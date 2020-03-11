FROM python:3.7

WORKDIR /blog
ENV FLASK_APP=blog.py

ADD requirements.txt .
RUN pip install -r requirements.txt
ADD blog.py .
ADD static/ ./static/
ADD templates/ ./templates/ 

EXPOSE 80
CMD ["flask", "run", "--host=0.0.0.0", "--port=8080"]

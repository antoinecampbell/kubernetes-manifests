FROM python:3.9-alpine

WORKDIR /app
ADD requirements.txt /app
RUN pip install -r requirements.txt
ADD app.py /app

CMD flask run

# docker build --rm -t local/python-app .

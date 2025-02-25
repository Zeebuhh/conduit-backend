FROM python:3.6

WORKDIR /app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY . /app

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/bin/sh", "/app/entrypoint.sh"]

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "conduit.wsgi:application"]
FROM apache/superset:2.1.0

RUN pip install mysqlclient
COPY config.py /app/superset/config.py

USER superset
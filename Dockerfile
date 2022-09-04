FROM apache/superset:2.0.0

RUN pip install pybigquery
RUN pip install redis
RUN pip install mysqlclient
COPY config.py /app/superset/config.py

USER superset

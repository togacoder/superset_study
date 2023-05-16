FROM apache/superset:2.1.0

RUN pip install pybigquery
COPY config.py /app/superset/config.py

USER superset
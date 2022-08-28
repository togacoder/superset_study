FROM apache/superset:2.0.0

RUN pip install pybigquery

USER superset
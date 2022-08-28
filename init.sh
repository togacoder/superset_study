#!/bin/bash
CONTAINER_NAME='superset'

docker exec -it ${CONTAINER_NAME} superset db upgrade

docker exec -it ${CONTAINER_NAME} superset fab create-admin \
    --username admin \
    --firstname admin \
    --lastname user \
    --email admin@fab.org \
    --password admin

# docker exec -it ${CONTAINER_NAME} superset load-examples

docker exec -it ${CONTAINER_NAME} superset init
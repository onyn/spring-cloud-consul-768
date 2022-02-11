#!/usr/bin/env bash

set -e

docker-compose down
docker-compose up -d consul-no-acl

sleep 3

curl -sX PUT \
  -d 'hello: world
hello2: world2' \
  http://127.0.0.1:8500/v1/kv/config/application/data

curl -sX PUT \
  -d 'hello2: 321
hello3: 123' \
  http://127.0.0.1:8500/v1/kv/config/myapp/data

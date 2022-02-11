#!/usr/bin/env bash

set -e

docker-compose down
docker-compose up -d consul

sleep 3

TOKEN=$(curl -sX PUT http://127.0.0.1:8500/v1/acl/bootstrap | grep 'SecretID' | awk -F'"' '{print $4}')

curl -sX PUT -H "X-Consul-Token: ${TOKEN}" -H 'Content-Type: application/json' \
  -d '{"Name": "default-agent", "Rules": "node_prefix \"\" {policy = \"write\"} service_prefix \"\" {policy = \"write\"} query_prefix \"\" {policy = \"write\"}"}' \
  http://127.0.0.1:8500/v1/acl/policy > /dev/null

AGENT_TOKEN=$(curl -sX PUT -H "X-Consul-Token: ${TOKEN}" -H 'Content-Type: application/json' \
  -d '{"Description": "default-agent", "Policies": [{"Name": "default-agent"}]}' \
  http://127.0.0.1:8500/v1/acl/token | grep 'SecretID' | awk -F'"' '{print $4}')

docker-compose exec consul consul acl set-agent-token -token ${TOKEN} default ${AGENT_TOKEN}

curl -sX PUT -H "X-Consul-Token: ${TOKEN}" -H 'Content-Type: application/json' \
  -d '{"Name": "app", "Rules": "key_prefix \"config/\" {policy = \"read\"}"}' \
  http://127.0.0.1:8500/v1/acl/policy > /dev/null

APP_TOKEN=$(curl -sX PUT -H "X-Consul-Token: ${TOKEN}" -H 'Content-Type: application/json' \
  -d '{"Description": "app", "Policies": [{"Name": "app"}]}' \
  http://127.0.0.1:8500/v1/acl/token | grep 'SecretID' | awk -F'"' '{print $4}')

curl -sX PUT -H "X-Consul-Token: ${TOKEN}" \
  -d 'hello: world
hello2: world2' \
  http://127.0.0.1:8500/v1/kv/config/application/data > /dev/null

curl -sX PUT -H "X-Consul-Token: ${TOKEN}" \
  -d 'hello2: 321
hello3: 123' \
  http://127.0.0.1:8500/v1/kv/config/myapp/data > /dev/null

echo "Root token: $TOKEN"
echo "App token: $APP_TOKEN"

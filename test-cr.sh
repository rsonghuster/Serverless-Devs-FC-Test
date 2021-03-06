#!/bin/bash
set -x
set -e
s clean --all

export core_load_serverless_devs_component='devsapp/fc-deploy@dev;devsapp/fc-core@dev'

# Test custom runtime
cd custom
cd python

echo "test custom python runtime event function ..."
rm -rf .s
s build -d
s local invoke -e '{"hello":"fc"}'
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'

echo "test custom python runtime http function ..."
rm -rf .s
s build -d -t s-http.yaml
s deploy -y --use-local -t s-http.yaml
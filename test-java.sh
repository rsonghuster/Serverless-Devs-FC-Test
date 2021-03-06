#!/bin/bash
set -x
set -e
s clean --all

export core_load_serverless_devs_component='devsapp/fc-deploy@dev;devsapp/fc-core@dev'

# Test Java Runtime
echo "test java8 runtime ..."
cd java
rm -rf .s
s build -d
s local invoke -e '{"hello":"fc"}'
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'

echo "test java11 runtime ..."
rm -rf .s
s build -d -t s-java11.yaml
s local invoke -e '{"hello":"fc"}' -t s-java11.yaml
s deploy -y --use-local -t s-java11.yaml
s invoke -e '{"hello":"fc"}' -t s-java11.yaml
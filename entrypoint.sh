#!/bin/sh
set -ex

token=$1
url=$2

if [[ ! -z "$OKTETO_CA_CERT" ]]; then
  echo "Custom certificate is provided"
  echo "$OKTETO_CA_CERT" > /usr/local/share/ca-certificates/okteto_ca_cert
  update-ca-certificates
fi

if [ -z $token ]; then
  echo "Okteto API token is required"
  exit 1
fi


export OKTETO_HOME=$RUNNER_TEMP
mkdir -p $OKTETO_HOME
echo running: okteto login --token=$token $url
okteto login -l=debug --token=$token $url 

#!/bin/sh
set -eu

org="${1:?organism is required}"

/bin/sh /usr/local/bin/wait-for-http.sh \
  http://keycloak:8080/realms/loculus \
  http://backend:8079/actuator/health

exec prepro \
  --backend-host="http://backend:8079/${org}" \
  --keycloak-host=http://keycloak:8080 \
  --keycloak-password="${KEYCLOAK_PASSWORD}" \
  --config="/config/${org}/preprocessing-config.yaml"

#!/bin/bash
set -eu

set -x

# configure ldap

/app/code/vault login
/app/code/vault auth enable ldap
/app/code/vault write auth/ldap/config \
  url="${CLOUDRON_LDAP_URL}" \
  userdn="${CLOUDRON_LDAP_USERS_BASE_DN}" \
  userattr=username \
  discoverdn=true \
  groupdn="${CLOUDRON_LDAP_GROUPS_BASE_DN}" \
  binddn="${CLOUDRON_LDAP_BIND_DN}" \
  bindpass="${CLOUDRON_LDAP_BIND_PASSWORD}"

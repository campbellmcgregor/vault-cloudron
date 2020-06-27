exec /app/code/vault write auth/ldap/config \
     url="ldap://${CLOUDRON_LDAP_SERVER}" \
     userdn="${CLOUDRON_LDAP_USERS_BASE_DN}" \
     groupdn="${CLOUDRON_LDAP_GROUPS_BASE_DN}" \
     binddn="${CLOUDRON_LDAP_BIND_DN}" \
     bindpass="${CLOUDRON_LDAP_BIND_PASSWORD}"
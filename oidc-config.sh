#!/bin/bash
set -eu

set -x

# this needs signing_methid = RS256 set in konnectd.cfg

# configure oidc
/app/code/vault login
/app/code/vault auth enable oidc
/app/code/vault write auth/oidc/config \
    oidc_discovery_url="https://meet.9wd.eu" \
    oidc_client_id="vault.9wd.eu" \
    oidc_client_secret=bla \
    default_role="internal"

/app/code/vault write auth/oidc/role/internal \
    bound_subject="subject" \
    bound_audiences="https://vault.9wd.eu" \
    user_claim="https://vault/user" \
    groups_claim="https://vault/groups" \
    policies=webapps \
    ttl=1h \
    allowed_redirect_uris="https://vault.9wd.eu/ui/vault/auth/oidc/oidc/callback"
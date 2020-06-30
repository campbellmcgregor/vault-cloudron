# Hashicorp Vault

To use your Vault installation you need to unseal it after each restart. For this you need at least three of the five unseal keys.

These keys will be generated at the first startup of the app. The keys will not be stored inside the app, but only printed to the log in Cloudron. Please get them from there and store them in a safe place or distribute them among trusted entities.

**The vault can only be initialized once!**

Once the vault is unsealed you still need to configure ldap authentication. For this the script `/app/pkg/ldap-config.sh` exists. Running the script requires you to enter the root token.

## TODO

- Vault does not integrate with Cloudron's users, yet.

# Hashicorp Vault

To use your Vault installation you need to unseal it after each restart. For this you need at least three of the five unseal keys.

The keys will not be stored inside the app. You can initialise the vault after install by going to the URL where the app was installed. Following directions from there. After download store them in a safe place or distribute them among trusted entities.

**The vault can only be initialized once!**

Once the vault is unsealed you still need to configure ldap authentication. For this the script `/app/pkg/ldap-config.sh` exists. Running the script requires you to enter the root token.

## TODO

- Vault does not integrate with Cloudron's users, yet.

# Networkd Orange PPPoE configuration script for Systemd enabled Linux distributions

CE SCRIPT FONCTIONNE SEULEMENT SUR CENTOS 7 POUR LE MOMENT

## Installation

### Configurer les interfaces

Des variables sont incluses dans le script et vous permettent de personnaliser les interfaces a utiliser. A ce jour seulement 2 interfaces réseau sont utilisés, une pour le WAN et une pour le LAN.

### S'identifier sur le reseau Orange

Vous devez éditer le fichier ```/etc/ppp/peers/orange``` pour etre identifié et donc connecté au reseau Orange.
Ces identifiants vous ont normalement été communiqués par courrier ou par SMS. Vous pouvez en refaire la demande auprès du Service Client au 3900.

```
name "fti/*******"    # Votre identifiant de connexion
password "*******"    # Le mot de passe associé
```


## Credits

Merci a Madison du forum LaFibre.info :
https://lafibre.info/remplacer-livebox/routeur-minimaliste-a-base-darchlinux-pour-fibre-orange/

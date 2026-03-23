# Azure Automation Scripts

Collection de scripts Bash et PowerShell pour l'automatisation de l'infrastructure sur Microsoft Azure.

## Scripts Inclus

### Réseau
- `create_vnet_azure.sh` / `.ps1` : Création de réseaux virtuels (VNet).
- `vnet_peering.sh` / `peering.ps1` : Configuration du peering entre VNets.

### Déploiement de Services
- `deploy_flask_vm.sh` : Déploiement d'une application Flask sur une VM Azure.
- `deploy_vmss_nginx.sh` : Mise en place d'un Virtual Machine Scale Set (VMSS) avec Nginx.
- `install_nginx.sh` : Script d'installation rapide de Nginx.
- `install_flask.sh` : Script d'installation des dépendances Flask.

### Configuration
- `config.json` : Paramètres globaux pour les scripts.
- `flask_config.json` : Configuration spécifique pour l'application Flask.

## Prérequis
- Azure CLI (`az`) installé et configuré.
- PowerShell (pour les scripts `.ps1`).
- Accès administrateur à une souscription Azure.

## Utilisation
Chaque script est indépendant. Assurez-vous de donner les droits d'exécution aux fichiers `.sh` :
```bash
chmod +x script_name.sh
./script_name.sh
```

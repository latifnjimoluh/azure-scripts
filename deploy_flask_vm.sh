#!/bin/bash

# Variables
rgName="TP-Azure-Migration"
location="westeurope"
appvm_name="vm-app-flask"
vnet_name="vnet-app"
subnet_name="subnet-app"
admin_user="azureuser"

# Création de la VM Flask (privée)
echo "➡️ Déploiement VM Flask..."
az vm create \
  --resource-group $rgName \
  --name $appvm_name \
  --image UbuntuLTS \
  --size Standard_B1s \
  --vnet-name $vnet_name \
  --subnet $subnet_name \
  --public-ip-address "" \
  --admin-username $admin_user \
  --generate-ssh-keys

# Appliquer l'extension CustomScript pour Flask
echo "➡️ Installation de Flask avec systemctl..."
az vm extension set \
  --resource-group $rgName \
  --vm-name $appvm_name \
  --name CustomScript \
  --publisher Microsoft.Azure.Extensions \
  --version 2.1 \
  --settings @flask_config.json

# Récupérer IP privée
flask_ip=$(az vm list-ip-addresses -g $rgName -n $appvm_name --query "[0].virtualMachine.network.privateIpAddresses[0]" -o tsv)
echo "✅ VM Flask déployée. IP Privée : $flask_ip"

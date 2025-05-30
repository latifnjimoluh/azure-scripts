#!/bin/bash

# ========================
# Script de déploiement VMSS + extension Nginx via CustomScript
# ========================

# Variables
rgName="TP-Azure-Migration"
location="westeurope"
vmss_name="vmss-frontend"
vnet_name="vnet-app"
subnet_name="subnet-frontend"
gateway_name="AppGateway01"
admin_username="azureuser"

# Déployer le VM Scale Set vide (2 instances, Ubuntu, sans IP publique)
az vmss create \
  --resource-group $rgName \
  --name $vmss_name \
  --image UbuntuLTS \
  --upgrade-policy-mode Automatic \
  --instance-count 2 \
  --vm-sku Standard_B1s \
  --vnet-name $vnet_name \
  --subnet $subnet_name \
  --public-ip-per-vm false \
  --admin-username $admin_username \
  --generate-ssh-keys \
  --app-gateway-name $gateway_name \
  --backend-pool-name appGatewayBackendPool

# Appliquer l'extension CustomScript pour installer Nginx
az vmss extension set \
  --resource-group $rgName \
  --vmss-name $vmss_name \
  --name CustomScript \
  --publisher Microsoft.Azure.Extensions \
  --version 2.1 \
  --settings @config.json

echo "✅ Déploiement VMSS + Nginx via script GitHub terminé."

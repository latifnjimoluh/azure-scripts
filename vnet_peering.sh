#!/bin/bash

# =============================
# Script de peering entre vnet-app et vnet-db
# =============================

# Variables de configuration
rgName="TP-Azure-Migration"
vnet_app_name="vnet-app"
vnet_db_name="vnet-db"

# Peering depuis vnet-app vers vnet-db
echo "Création du peering App_to_DB_Peering..."
az network vnet peering create \
  --name App_to_DB_Peering \
  --resource-group $rgName \
  --vnet-name $vnet_app_name \
  --remote-vnet $(az network vnet show -g $rgName -n $vnet_db_name --query id -o tsv) \
  --allow-vnet-access

# Peering depuis vnet-db vers vnet-app
echo "Création du peering DB_to_App_Peering..."
az network vnet peering create \
  --name DB_to_App_Peering \
  --resource-group $rgName \
  --vnet-name $vnet_db_name \
  --remote-vnet $(az network vnet show -g $rgName -n $vnet_app_name --query id -o tsv) \
  --allow-vnet-access

echo "✅ Peering entre vnet-app et vnet-db terminé avec succès."

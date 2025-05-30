#!/bin/bash

# =============================
# Script de création de VNets Azure avec sous-réseaux
# =============================

# Variables de configuration
location="westeurope"
rgName="TP-Azure-Migration"

# VNets
vnet_app_name="vnet-app"
vnet_db_name="vnet-db"

# Subnets
subnet_gateway_name="subnet-gateway"
subnet_front_name="subnet-frontend"
subnet_app_name="subnet-app"
subnet_db_name="subnet-sql-private-endpt"

# =============================
echo "Création du groupe de ressources..."
az group create --name $rgName --location $location

echo "Création du VNet applicatif ($vnet_app_name) avec subnet-gateway..."
az network vnet create \
  --resource-group $rgName \
  --name $vnet_app_name \
  --address-prefixes 10.0.0.0/16 \
  --subnet-name $subnet_gateway_name \
  --subnet-prefixes 10.0.0.0/24

echo "Ajout du subnet-frontend..."
az network vnet subnet create \
  --resource-group $rgName \
  --vnet-name $vnet_app_name \
  --name $subnet_front_name \
  --address-prefixes 10.0.1.0/24

echo "Ajout du subnet-app..."
az network vnet subnet create \
  --resource-group $rgName \
  --vnet-name $vnet_app_name \
  --name $subnet_app_name \
  --address-prefixes 10.0.2.0/24

echo "Création du VNet base de données ($vnet_db_name) avec subnet-sql-private-endpt..."
az network vnet create \
  --resource-group $rgName \
  --name $vnet_db_name \
  --location $location \
  --address-prefixes 10.1.0.0/16 \
  --subnet-name $subnet_db_name \
  --subnet-prefixes 10.1.0.0/24

echo "✅ Réseaux virtuels et sous-réseaux créés avec succès."

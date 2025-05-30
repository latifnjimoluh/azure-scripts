$rgName = "TP-Azure-Migration"
$vnet_app_name = "vnet-app"
$vnet_db_name = "vnet-db"

Write-Host "Création du peering App_to_DB_Peering..."
$remoteVnetDbId = az network vnet show -g $rgName -n $vnet_db_name --query id -o tsv
az network vnet peering create `
  --name App_to_DB_Peering `
  --resource-group $rgName `
  --vnet-name $vnet_app_name `
  --remote-vnet $remoteVnetDbId `
  --allow-vnet-access

Write-Host "Création du peering DB_to_App_Peering..."
$remoteVnetAppId = az network vnet show -g $rgName -n $vnet_app_name --query id -o tsv
az network vnet peering create `
  --name DB_to_App_Peering `
  --resource-group $rgName `
  --vnet-name $vnet_db_name `
  --remote-vnet $remoteVnetAppId `
  --allow-vnet-access

Write-Host "✅ Peering entre vnet-app et vnet-db terminé avec succès."

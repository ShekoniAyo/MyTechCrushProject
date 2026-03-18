#!/bin/bash
set -e
set -x

RESOURCE_GROUP=$1
STORAGE_ACCOUNT=$2
CONTAINER_NAME=$3



echo '>>>>>>>>>> Creating Resource Group...'

az group create --name "$RESOURCE_GROUP" --location eastus
echo '>>>>>>>>>> Resource Group Created successfully.'
echo '>>>>>>>>>> Checking For Storage Group...'

az group exists --name "$RESOURCE_GROUP"

echo '>>>>>>>>>> Creating Storage Account...'

az storage account create --name "$STORAGE_ACCOUNT" --resource-group "$RESOURCE_GROUP" --location eastus --sku Standard_LRS --allow-blob-public-access true

echo '>>>>>>>>>> Storage Account "$STORAGE_ACCOUNT" created successfully.'
echo '>>>>>>>>>> Creating storage container...'

az storage container create --name "$CONTAINER_NAME" --account-name "$STORAGE_ACCOUNT" --public-access blob

echo '>>>>>>>>>> storage container "$CONTAINER_NAME" created successfully.'
echo '>>>>>>>>>> diplaying list of resource in "$RESOURCE_GROUP"...'

az resource list --resource-group "$RESOURCE_GROUP" --output table

echo '>>>>>>>>>> displaying list of containers in storage account "$STORAGE_ACCOUNT"...'

if [ -z "$(az storage blob list --account-name "$STORAGE_ACCOUNT" --container-name "$CONTAINER_NAME" --output tsv)" ]; then 
    echo "Container is empty"
else
  echo "Blobs found"
fi
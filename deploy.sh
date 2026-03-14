#!/bin/bash
echo '>>>>>>>>>> Creating Resource Group...'

az group create --name TechCrush --location eastus
echo '>>>>>>>>>> Resource Group Created successfully.'
echo '>>>>>>>>>> Checking For Storage Group...'

az group exists --name TechCrush

echo '>>>>>>>>>> Creating Storage Account...'

az storage account create --name mytccapstone --resource-group TechCrush --location eastus --sku Standard_LRS --allow-blob-public-access true

echo '>>>>>>>>>> Storage Account created successfully.'
echo '>>>>>>>>>> Creating storage container...'

az storage container create --name testcontainer --account-name mytccapstone --public-access blob

echo '>>>>>>>>>> storage container created successfully.'
echo '>>>>>>>>>> diplaying list of resource in TechCrush...'

az resource list --resource-group TechCrush --output table

echo '>>>>>>>>>> displaying list of containers in storage account...'

az storage blob list --account-name mytccapstone --container-name testcontainer --output table

echo '>>>>>>>>>> Storage Account created succesfully'
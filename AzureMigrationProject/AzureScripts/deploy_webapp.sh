#!/bin/bash

# Variables
RESOURCE_GROUP="AzureMigrationRG"
APP_SERVICE_PLAN="WebAppPlan"
WEB_APP_NAME="AzureMigrationWebApp"
RUNTIME="NODE|14-lts"

# Create a resource group
az group create --name $RESOURCE_GROUP --location eastus

# Create an App Service plan
az appservice plan create --name $APP_SERVICE_PLAN --resource-group $RESOURCE_GROUP --sku B1

# Create a Web App
az webapp create --name $WEB_APP_NAME --resource-group $RESOURCE_GROUP --plan $APP_SERVICE_PLAN --runtime $RUNTIME

# Deploy the Web App
az webapp up --name $WEB_APP_NAME --resource-group $RESOURCE_GROUP --runtime $RUNTIME

echo "Web App deployed successfully!"

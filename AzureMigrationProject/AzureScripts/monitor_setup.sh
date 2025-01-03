#!/bin/bash

# Variables
RESOURCE_GROUP="AzureMigrationRG"
WEB_APP_NAME="AzureMigrationWebApp"
ALERT_NAME="HighCPUAlert"

# Create an alert for high CPU usage
az monitor metrics alert create \
  --name $ALERT_NAME \
  --resource-group $RESOURCE_GROUP \
  --scopes $(az webapp show --name $WEB_APP_NAME --resource-group $RESOURCE_GROUP --query id -o tsv) \
  --condition "avg Percentage CPU > 80" \
  --description "Alert when CPU usage exceeds 80%"

echo "Azure Monitor alert configured successfully!"

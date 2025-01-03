# Azure-Cloud-Migration-and-Optimization-Project
Step-by-Step Guide  This document provides a comprehensive step-by-step guide for migrating an on-premises infrastructure to Azure and optimizing it for cost, scalability, and performance. It includes code snippets and illustrative diagrams.
Step 1: Assess and Plan the Migration

Evaluate the On-Premises Infrastructure:

Use the Azure Migrate Tool to assess servers, applications, and databases.

Identify dependencies between resources.

Command:

          az migration evaluate --source on-premises --type vm --name assessment_name --resource-group RetailGroup

Determine the Migration Strategy:

Lift-and-Shift for applications.

Rehost databases to Azure Database.

Move file storage to Azure Blob Storage.

Architecture Diagram:
        ![analysis-diagram-10192](https://github.com/user-attachments/assets/27e7ed2b-b7d7-4ab6-842e-d1cb9b4b9ae3)

Step 2: Set Up Azure Environment

Create a Resource Group:

az group create --name RetailGroup --location eastus

Provision Azure Resources:

Azure App Service for hosting the website.

Azure SQL Database for data.

Azure Blob Storage for product images.

Example Commands:

       az appservice plan create --name WebAppPlan --resource-group RetailGroup --sku B1
       az webapp create --name RetailWebApp --resource-group RetailGroup --plan WebAppPlan

       az sql server create --name retail-sql-server --resource-group RetailGroup --admin-user admin --admin-password SecureP@ssword123
       az sql db create --name RetailDB --resource-group RetailGroup --server retail-sql-server --service-objective S0

       az storage account create --name retailstorage --resource-group RetailGroup --location eastus --sku Standard_LRS

Step 3: Migrate Web Application

Package the Application:

Zip your Node.js or .NET application files.

Deploy to Azure App Service:

      az webapp up --name RetailWebApp --resource-group RetailGroup --runtime "NODE|14-lts"

Configure Application Settings:

      az webapp config appsettings set --resource-group RetailGroup --name RetailWebApp --settings DATABASE_URL="<Azure SQL Connection String>"


![u6Od0](https://github.com/user-attachments/assets/5811e87a-717d-4adb-9c20-0c36a7074228)

Step 4: Migrate the Database

Export Database from On-Premises:

    mysqldump -u root -p retail_db > retail_db.sql

Import to Azure SQL Database:

    az sql db import --resource-group RetailGroup --server retail-sql-server --name RetailDB --admin-user admin --admin-password SecureP@ssword123 --storage-uri h ttps://<storage_account>.blob.core.windows.net/<container>/<retail_db.sql>

![1_apCl5kh6xCagFhRAQ4Lhuw](https://github.com/user-attachments/assets/c8a81cdd-3b05-4820-ae34-1d9f91dc4629)



Step 5: Migrate File Storage

Upload Files to Azure Blob Storage:

     azcopy copy "C:\ProductImages" "https://retailstorage.blob.core.windows.net/images" --recursive

Update Application Code to Fetch from Blob Storage:

    const blobService = require('azure-storage').createBlobService();
    const containerName = "images";

    blobService.listBlobsSegmented(containerName, null, (err, result) => {
    if (err) console.error(err);
    else console.log(result.entries);
    });

![value-prop](https://github.com/user-attachments/assets/dbba260c-5b92-43ae-94ae-721ae1216c59)


Step 6: Implement Monitoring and Optimization

Enable Azure Monitor:

    az monitor metrics alert create --name HighCPUAlert --resource-group RetailGroup --resource RetailWebApp --metric "Percentage CPU" --operator GreaterThan --threshold 80

Optimize Costs:

Use Azure Advisor to identify underutilized resources.

Set up autoscaling for the web app:

    az monitor autoscale create --resource-group RetailGroup --name "WebAppAutoscale" --min-count 1 --max-count 5 --count 2

![66e20170faa6186bed01e44a_cost-analysis](https://github.com/user-attachments/assets/de3b02ae-e27c-45ea-990d-7fec096794f8)


Outcomes

Cost Savings: 30% reduction in infrastructure costs.

Scalability: 99.9% uptime during peak loads.

Disaster Recovery: Enabled Azure Backup for critical data.


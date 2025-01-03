const { BlobServiceClient } = require('@azure/storage-blob');
const fs = require('fs');
const path = require('path');

// Azure Blob Storage connection string
const AZURE_STORAGE_CONNECTION_STRING = "<Your-Azure-Storage-Connection-String>";
const containerName = "images";

async function uploadFiles(directoryPath) {
    const blobServiceClient = BlobServiceClient.fromConnectionString(AZURE_STORAGE_CONNECTION_STRING);
    const containerClient = blobServiceClient.getContainerClient(containerName);

    const files = fs.readdirSync(directoryPath);

    for (const file of files) {
        const filePath = path.join(directoryPath, file);
        const blockBlobClient = containerClient.getBlockBlobClient(file);

        console.log(`Uploading ${file} to Azure Blob Storage...`);
        await blockBlobClient.uploadFile(filePath);
    }
    console.log("Upload complete.");
}

// Specify the directory containing images
uploadFiles("./images");

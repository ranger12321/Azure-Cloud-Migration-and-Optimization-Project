const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.send('Welcome to the Azure Migration Project Web App!');
});

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});

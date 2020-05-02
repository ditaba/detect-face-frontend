const fs = require('fs');
const http = require('http');
const express = require('express');
const path = require('path');
const app = express();

console.log('[server start]', __dirname);

app.use(express.static(path.join(__dirname, 'build')));

app.get('/*', function (req, res) {
  res.sendFile(path.join(__dirname, 'build', 'index.html'));
});

const httpServer = http.createServer(app);

httpServer.listen(8080);

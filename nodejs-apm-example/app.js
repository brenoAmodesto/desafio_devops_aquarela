// app.js

// Require the Elastic APM module at the very top of the file
var apm = require('elastic-apm-node').start({
    serviceName: 'nodejs-apm-example',
    serverUrl: 'http://localhost:8200', // Replace <APM_SERVER_URL> with your APM Server URL
  })
  
  const express = require('express')
  const app = express()
  const port = 3000
  
  app.get('/', (req, res) => {
    res.send('Hello World!')
  })
  
  app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
  })
  
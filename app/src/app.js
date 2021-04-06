const express = require('express')
const redis = require('redis')
const app = express()

const port = process.env.PORT || 3000
const db_host = process.env.DB_HOST || 'localhost'
const db_port = process.env.DB_PORT || 6379
const db_password = process.env.DB_PASSWORD || ''

// connect and read value from DB once

const dbClient = redis.createClient({
    host: db_host,
    port: db_port,
    password: db_password,
})

dbClient.on('error', err => {
    console.log('Error ' + err);
})

dbClient.get('stringFromDB', (err, reply) => {
    if (err) throw err;
    stringFromDB = reply
})

app.get('/', (_req, res) => res.send(stringFromDB))
app.get('/healthz', (_req, res) => {
    res.setHeader('Content-Type', 'application/json');
    res.send(JSON.stringify({ status: true }))
})

app.listen(port, () => console.log(`Server is listening on port ${port}`))
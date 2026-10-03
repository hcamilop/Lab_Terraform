const express = require('express');
const { Pool } = require('pg');

const app = express();

const PORT = process.env.PORT || 3000;
const MESSAGE = process.env.MESSAGE || 'Backend sin mensaje configurado';
const ENV_NAME = process.env.ENV_NAME || 'unknown';

const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT || 5432,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

app.get('/', async (req, res) => {
  let dbStatus = 'desconectado';
  try {
    await pool.query('SELECT 1');
    dbStatus = 'conectado';
  } catch (err) {
    dbStatus = `error: ${err.message}`;
  }

  res.json({
    message: MESSAGE,
    environment: ENV_NAME,
    db: dbStatus,
    timestamp: new Date().toISOString(),
  });
});

app.listen(PORT, () => {
  console.log(`API [${ENV_NAME}] escuchando en el puerto ${PORT}`);
});
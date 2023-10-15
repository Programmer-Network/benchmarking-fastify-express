const express = require("express");
const app = express();

const { pool, getDummy } = require("./db");
const { expressPort } = require("./constants");

app.get("/", (req, res) => {
  res.send("Hello, world!");
});

app.get('/db', async (req, res) => {
  const client = await pool.connect();
  const { rows } = await getDummy(client)
  client.release();
  res.send(rows);
});

app.listen(expressPort, () => {
  console.log(`Express server running at http://localhost:${expressPort}`);
});

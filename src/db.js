const { Pool } = require("pg");
const { dbOptions } = require("./constants");

const pool = new Pool(dbOptions);

const getDummy = client => {
  return client.query("SELECT * FROM dummy_table");
};

module.exports = { pool, getDummy };

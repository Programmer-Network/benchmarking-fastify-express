const fastify = require('fastify')({ logger: true });

const { pool, getDummy } = require("./db");

const { fastifyPort } = require("./constants");

fastify.get('/', async (request, reply) => {
  return 'Hello, world!';
});

fastify.get('/db', async (request, reply) => {
  const client = await pool.connect();
  const { rows } = await getDummy(client)
  client.release();

  return rows;
});

fastify.listen({ port: fastifyPort, host: '0.0.0.0' })
  .then(address => console.log(`Fastify server is listening on ${address}:${fastifyPort}`))
  .catch(err => {
    console.log('Error starting server:', err);
    process.exit(1);
  });
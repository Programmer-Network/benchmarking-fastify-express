#!/bin/bash

# Start PostgreSQL
service postgresql start

# Start Fastify and Express
npm start &

# Wait for the apps to start
sleep 5

# Run benchmark
./benchmark.sh > /results/benchmark_results.txt

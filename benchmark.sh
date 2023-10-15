#!/bin/bash

echo "Benchmarking Fastify"

# Benchmark Fastify for hello world
echo "Benchmarking Fastify: Hello World"
ab -n 5000 -c 100 http://localhost:3000/

# Benchmark Fastify for DB
echo "Benchmarking Fastify: DB Operations"
ab -n 5000 -c 100 http://localhost:3000/db

echo "Benchmarking Express"

# Benchmark Express for hello world
echo "Benchmarking Express: Hello World"
ab -n 5000 -c 100 http://localhost:3001/

# Benchmark Express for DB
echo "Benchmarking Express: DB Operations"
ab -n 5000 -c 100 http://localhost:3001/db

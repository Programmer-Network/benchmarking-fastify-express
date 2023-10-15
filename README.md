# Benchmarking Fastify vs Express

This repository contains a Dockerized environment for benchmarking Fastify and Express.js web frameworks. The focus is on comparing throughput and database operations.

## Table of Contents

- [Benchmarking Fastify vs Express](#benchmarking-fastify-vs-express)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Setup](#setup)
    - [Docker Setup](#docker-setup)
  - [Docker Build and Run](#docker-build-and-run)
  - [Metrics](#metrics)

## Introduction

Fastify and Express are both popular frameworks for building web applications in Node.js, but they have different performance characteristics. This Dockerized setup aims to provide a controlled environment to benchmark these frameworks based on throughput and database I/O.

## Setup

### Docker Setup

- Build the Docker image.

```bash
docker build -t benchmark-fastify-express .
```

- Run the Docker container.

```bash
docker run -p 3000:3000 -p 3001:3001 benchmark-fastify-express
```

## Docker Build and Run

The Docker image uses a multi-stage build to prepare the Node.js applications and then packages them into an Ubuntu image with Apache Bench installed. The Fastify and Express apps are started concurrently, and then the benchmark is executed. The results of the benchmark are saved to a `benchmark_results.txt` file, which is mapped to a `results` directory in your host system.

```bash
docker build -t benchmark-fastify-express .
```

```bash
docker run -p 3000:3000 -p 3001:3001 -v $(pwd)/results:/results benchmark-fastify-express
```

After running the above command, you'll find the benchmark results in the `results` directory in your current working directory.

## Metrics

The following metrics are captured during the benchmarks:

- Throughput (Requests per Second)
- Latency (Average, P99)
- Error Rate
- Memory Usage
- CPU Utilization

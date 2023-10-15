# Stage 1: Build the Fastify and Express apps
FROM node:20.7 as build

WORKDIR /app

# Create the directory for the benchmark results
RUN mkdir -p /results

COPY package.json ./
RUN npm install

# Copy source code
COPY src/ ./src/

# Stage 2: Use a lighter base image and only copy essential files
FROM ubuntu:latest

# Avoid tzdata asking for geographical area
ENV DEBIAN_FRONTEND=noninteractive

# Install Apache Bench, Node.js, and PostgreSQL
RUN apt-get update \
    && apt-get install -y --no-install-recommends apache2-utils postgresql postgresql-contrib \
    && rm -rf /var/lib/apt/lists/*

# Install curl
RUN apt-get update && apt-get install -y curl

# Install curl and xz-utils
RUN apt-get update && apt-get install -y curl xz-utils

# Download Node.js binary and install
RUN curl -fsSLO --compressed "https://nodejs.org/dist/v20.7.0/node-v20.7.0-linux-x64.tar.xz" \
    && tar -xJf "node-v20.7.0-linux-x64.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
    && rm "node-v20.7.0-linux-x64.tar.xz" \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs

# Initialize PostgreSQL
USER postgres
COPY init.sql /init.sql
RUN /etc/init.d/postgresql start && \
    psql --command "CREATE USER myuser WITH SUPERUSER PASSWORD 'mypassword';" && \
    createdb -O myuser mydatabase && \
    psql mydatabase < /init.sql

# Switch back to root user
USER root

# Set working directory
WORKDIR /app

# Copy essential files from the build stage
COPY --from=build /app .

# Add benchmark.sh and make it executable
COPY benchmark.sh .
RUN chmod +x benchmark.sh

# Add startup script
COPY start.sh .
RUN chmod +x start.sh

# Run PostgreSQL, Fastify and Express and then execute the benchmark
CMD ["./start.sh"]

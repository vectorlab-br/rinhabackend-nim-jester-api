# Use the official Nim image from Docker Hub
FROM nimlang/nim:latest AS build-env

# Install PostgreSQL client library
RUN apt-get update && apt-get install -y libpq-dev

# Set the working directory
WORKDIR /app

COPY rinhabackend_nim_jester.nimble rinhabackend_nim_jester.nimble

# Install any Nimble dependencies
RUN nimble install -y -d

# Copy the current directory contents into the container
COPY . .

# Compile the Nim application
RUN nimble compile -d:release src/rinha.nim -o:/app/rinha

EXPOSE 3000

# Run the compiled Nim application
CMD ["sh", "-c", "/app/rinha"]

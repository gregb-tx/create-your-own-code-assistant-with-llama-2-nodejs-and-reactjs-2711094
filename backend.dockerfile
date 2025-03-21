FROM node:21-alpine AS builder

# Set the working directory in the Dcker image
WORKDIR /app

COPY backend/package.json ./

# Install the dependencies in the Docker image
RUN ["npm", "install", "--legacy-peer-deps"]

COPY backend/src ./src

# Build the application
Run npm run build # same the Run buid command above

# Start a new stage to create a smaller final image
FROM node:21-alpine

# Set the working directory in the Dcker image
WORKDIR /app

# Copy the node_modules and built file from the builder stage
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

EXPOSE 3000 # exposes port 3000

# Entry point command
CMD ["npm", "start"]


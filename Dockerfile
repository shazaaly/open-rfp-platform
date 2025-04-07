# Use the official Node.js image as the base (using a specific Node version)
FROM node:20.15.1-slim

# Set the working directory inside the container
WORKDIR /home/node/app


# Copy the .env file into the container
COPY ./.env ./.env
COPY ./package.json ./package.json
COPY ./package-lock.json ./package-lock.json

# Install dependencies, making use of cached layers if possible
RUN npm install

# Copy the rest of the application code after dependencies to reduce unnecessary rebuilds
COPY . .

# Build the NestJS application
RUN npm run build

# Expose port 3000 for the application to listen on
EXPOSE 3000

# Command to run the app in production mode
CMD ["npm", "run", "start:dev"]

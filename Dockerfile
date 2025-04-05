# Use official Node.js image as base
FROM node:18

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy the application code
COPY . .

# Expose the required port
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]

# Stage 1: Build the Angular application
FROM node:18.13-alpine as build

WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm ci 

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Serve the application using Nginx
FROM nginx:alpine


# Copy the built files from the previous stage
COPY --from=build /app/dist/angular-conduit /usr/share/nginx/html

RUN ls -la /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

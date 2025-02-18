# Stage 1: Build the Angular application
FROM node:18.13-alpine as build

WORKDIR /app

# Set a default build configuration (production)
ARG CONFIGURATION=production

# Copy dependency files and install dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Copy the rest of the application code
COPY . .

# Build the application using the angegebenen Konfiguration
RUN npm run build -- --configuration=$CONFIGURATION

# Stage 2: Serve the application using Nginx
FROM nginx:alpine

# Kopiere den Build-Output von der vorherigen Stage in den Nginx-Webordner
COPY --from=build /app/dist/angular-conduit /usr/share/nginx/html

# Optional: Überprüfe den Inhalt des Nginx-Webordners (nur zum Debuggen)
RUN ls -la /usr/share/nginx/html

# Expose Port 80
EXPOSE 80

# Starte Nginx
CMD ["nginx", "-g", "daemon off;"]

# Stage 1: Build the Angular application
FROM node:20-alpine AS build

WORKDIR /app

# Kopiere package.json und package-lock.json und installiere alle Abhängigkeiten
COPY package.json package-lock.json ./
RUN npm ci

# Kopiere den gesamten Quellcode
COPY . .

# Setze die Build-Konfiguration (Standard: production)
ARG CONFIGURATION=production
RUN npm run build -- --configuration=$CONFIGURATION

# Stage 2: Serve the application using Nginx
FROM nginx:alpine

# Kopiere den gebauten Angular-Code in das Nginx-Image
COPY --from=build /app/dist/angular-conduit /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

# Stage 1: Build the Angular application
FROM node:20-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

ARG CONFIGURATION=production
RUN npm run build

# Stage 2: Serve the application using Nginx
FROM nginx:alpine

COPY --from=build /app/dist/angular-conduit /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

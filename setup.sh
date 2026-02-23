#!/bin/bash
# Run this from the ROOT of your project folder (crud-dd-task-mean-app/)
# in Git Bash

echo ">>> Step 1: Replacing tutorial.service.ts..."
cat > frontend/src/app/services/tutorial.service.ts << 'EOF'
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Tutorial } from '../models/tutorial.model';

const baseUrl = '/api/tutorials';

@Injectable({
  providedIn: 'root'
})
export class TutorialService {

  constructor(private http: HttpClient) { }

  getAll(): Observable<Tutorial[]> {
    return this.http.get<Tutorial[]>(baseUrl);
  }

  get(id: any): Observable<Tutorial> {
    return this.http.get<Tutorial>(`${baseUrl}/${id}`);
  }

  create(data: any): Observable<any> {
    return this.http.post(baseUrl, data);
  }

  update(id: any, data: any): Observable<any> {
    return this.http.put(`${baseUrl}/${id}`, data);
  }

  delete(id: any): Observable<any> {
    return this.http.delete(`${baseUrl}/${id}`);
  }

  deleteAll(): Observable<any> {
    return this.http.delete(baseUrl);
  }

  findByTitle(title: any): Observable<Tutorial[]> {
    return this.http.get<Tutorial[]>(`${baseUrl}?title=${title}`);
  }
}
EOF

echo ">>> Step 2: Replacing db.config.js..."
cat > backend/app/config/db.config.js << 'EOF'
module.exports = {
  url: process.env.MONGODB_URI || "mongodb://mongodb:27017/dd_db"
};
EOF

echo ">>> Step 3: Replacing server.js..."
cat > backend/server.js << 'EOF'
const express = require("express");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const db = require("./app/models");
db.mongoose
  .connect(db.url, {
    useNewUrlParser: true,
    useUnifiedTopology: true
  })
  .then(() => {
    console.log("Connected to the database!");
  })
  .catch(err => {
    console.log("Cannot connect to the database!", err);
    process.exit();
  });

app.get("/", (req, res) => {
  res.json({ message: "Welcome to Test application." });
});

require("./app/routes/turorial.routes")(app);

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});
EOF

echo ">>> Step 4: Creating backend/Dockerfile..."
cat > backend/Dockerfile << 'EOF'
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --production

COPY . .

EXPOSE 8080

CMD ["node", "server.js"]
EOF

echo ">>> Step 5: Creating frontend/nginx-frontend.conf..."
cat > frontend/nginx-frontend.conf << 'EOF'
server {
    listen 80;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOF

echo ">>> Step 6: Creating frontend/Dockerfile..."
cat > frontend/Dockerfile << 'EOF'
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build -- --configuration production

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/dist/angular-15-crud /usr/share/nginx/html

COPY nginx-frontend.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
EOF

echo ">>> Step 7: Creating nginx.conf in project root..."
cat > nginx.conf << 'EOF'
events {}

http {
    server {
        listen 80;

        location /api/ {
            proxy_pass http://backend:8080/api/;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

        location / {
            proxy_pass http://frontend:80/;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }
    }
}
EOF

echo ">>> Step 8: Creating docker-compose.yml..."
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:

  mongodb:
    image: mongo:6
    container_name: mongodb
    restart: always
    volumes:
      - mongo-data:/data/db
    networks:
      - mean-network

  backend:
    image: YOUR_DOCKERHUB_USERNAME/mean-backend:latest
    container_name: backend
    restart: always
    depends_on:
      - mongodb
    networks:
      - mean-network

  frontend:
    image: YOUR_DOCKERHUB_USERNAME/mean-frontend:latest
    container_name: frontend
    restart: always
    networks:
      - mean-network

  nginx:
    image: nginx:alpine
    container_name: nginx
    restart: always
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - frontend
      - backend
    networks:
      - mean-network

volumes:
  mongo-data:

networks:
  mean-network:
    driver: bridge
EOF

echo ">>> Step 9: Creating .github/workflows/deploy.yml..."
mkdir -p .github/workflows
cat > .github/workflows/deploy.yml << 'EOF'
name: CI/CD Pipeline

on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build and push Backend image
        uses: docker/build-push-action@v5
        with:
          context: ./backend
          file: ./backend/Dockerfile
          push: true
          tags: ${{ secrets.DOCKER_USERNAME }}/mean-backend:latest

      - name: Build and push Frontend image
        uses: docker/build-push-action@v5
        with:
          context: ./frontend
          file: ./frontend/Dockerfile
          push: true
          tags: ${{ secrets.DOCKER_USERNAME }}/mean-frontend:latest

      - name: Deploy to VM via SSH
        uses: appleboy/ssh-action@v1.0.0
        with:
          host: ${{ secrets.VM_HOST }}
          username: ${{ secrets.VM_USER }}
          key: ${{ secrets.VM_SSH_KEY }}
          script: |
            cd ~/mean-app
            docker compose pull
            docker compose up -d
            docker image prune -f
EOF

echo ">>> Step 10: Git add, commit and push..."
git add .
git commit -m "Add Docker, Nginx, CI/CD config files"
git push origin main

echo ""
echo "✅ ALL DONE! All files created and pushed to GitHub."
echo ""
echo "⚠️  IMPORTANT: Open docker-compose.yml and replace"
echo "   'YOUR_DOCKERHUB_USERNAME' with your actual Docker Hub username!"

# MEAN Stack Application - DevOps Assignment

## Overview

Full-stack MEAN (MongoDB, Express, Angular, Node.js) application deployed on AWS EC2 with Docker, Docker Compose, and GitHub Actions CI/CD.

**Live Application:** http://43.205.212.86

---

## What's Included

✅ Backend containerized and deployed
✅ Frontend containerized and deployed  
✅ MongoDB database running
✅ Nginx reverse proxy
✅ GitHub Actions CI/CD pipeline
✅ AWS EC2 infrastructure
✅ Docker Compose orchestration

---

## Quick Start
```bash
# Clone the repo
git clone https://github.com/pavannani99/mean-crud-app.git
cd mean-crud-app

# Deploy on EC2
docker-compose up -d
docker-compose ps
```

---

## Access the Application

- **Frontend:** http://43.205.212.86
- **API:** http://43.205.212.86/api/tutorials

---

## Technology Stack

- **Frontend:** Angular 15
- **Backend:** Node.js/Express
- **Database:** MongoDB 6
- **Proxy:** Nginx
- **Containers:** Docker & Docker Compose
- **CI/CD:** GitHub Actions
- **Cloud:** AWS EC2

---

## Files

- `docker-compose.yml` - Service orchestration
- `backend/Dockerfile` - Backend container
- `frontend/Dockerfile` - Frontend container
- `.github/workflows/deploy.yml` - CI/CD pipeline
- `nginx-main.conf` - Reverse proxy config

---

## Screenshots

See `docs/screenshots/` folder for deployment proof.

---

## CI/CD Pipeline

Push to `main` → Auto build, push, and deploy to EC2.

**Status:** ✅ Active

---

## Infrastructure

- **Instance:** AWS EC2 t3.micro
- **OS:** Ubuntu 24.04 LTS
- **Region:** ap-south-1
- **IP:** 43.205.212.86

---

## Repository

https://github.com/pavannani99/mean-crud-app

---

**Status:** ✅ Complete

# MEAN Stack Application - DevOps Assignment

## ?? Project Overview

A full-stack MEAN (MongoDB, Express, Angular, Node.js) application deployed on AWS EC2 with Docker, Docker Compose, and GitHub Actions CI/CD pipeline.

**Live Application:** http://43.205.212.86

---

## ? Assignment Completion Status

### Completed Tasks:

1. **? Repository Setup**
   - GitHub Repository: https://github.com/pavannani99/mean-crud-app
   - All code pushed and version controlled

2. **? Containerization**
   - Backend Dockerfile created
   - Frontend Dockerfile created
   - Both images built and pushed to Docker Hub
   - Backend Image: `pavannani99/mean-backend:latest`
   - Frontend Image: `pavannani99/mean-frontend:latest`

3. ** Cloud Deployment**
   - AWS EC2 Instance: Ubuntu 24.04 LTS
   - Instance IP: 43.205.212.86
   - Instance Type: t3.micro (Free Tier)
   - Region: ap-south-1 (Asia Pacific - Mumbai)

4. ** Database Setup**
   - MongoDB 6 deployed via Docker image
   - Data persistence with volumes
   - Authentication configured
   - Database: mean-db

5. ** CI/CD Pipeline**
   - GitHub Actions workflow configured
   - Auto-builds Docker images on push
   - Auto-pushes to Docker Hub
   - Auto-deploys to EC2
   - Status: 4 successful pipeline runs

6. ** Nginx Reverse Proxy**
   - Nginx Alpine container running
   - Routes `/api/*` to backend
   - Routes `/` to frontend
   - Port 80 exposed and accessible

---

##  Architecture
```

         AWS EC2 (43.205.212.86)                 

     
    Nginx (port 80) - Reverse Proxy            
     /api/*  Backend (8080)              
     /      Frontend (3000)              
     
       
   Backend             Frontend            
│  │ (Node.js)        │  │ (Angular 15)     │   │
│  │ (port 8080)  ✅  │  │ (port 80)    ✅  │   │
│  └──────────────────┘  └──────────────────┘   │
│          │                                     │
│  ┌──────────────────────────────────┐          │
│  │ MongoDB (port 27017)         ✅  │          │
│  │ Data Volume: mongo-data          │          │
│  └──────────────────────────────────┘          │
└─────────────────────────────────────────────────┘
```

---

## 🚀 Quick Start

### Prerequisites
- AWS Account
- Docker installed
- Git installed

### Deploy on Your Own EC2

1. **SSH into EC2:**
```bash
   ssh -i your-key.pem ubuntu@your-ec2-ip
```

2. **Clone and Deploy:**
```bash
   git clone https://github.com/pavannani99/mean-crud-app.git
   cd mean-crud-app
   docker-compose up -d
   docker-compose ps
```

3. **Access Application:**
```
   http://your-ec2-ip
```

---

## 🧪 Test the Application

### API Endpoints
```bash
# Get all tutorials
curl http://43.205.212.86/api/tutorials

# Response: [] (empty array)
```

### Frontend
Visit: http://43.205.212.86

Features:
- View all tutorials
- Add new tutorial
- Edit tutorial
- Delete tutorial
- Search functionality

---

## 📁 Key Files

| File | Purpose |
|------|---------|
| `docker-compose.yml` | Orchestrates 4 services |
| `backend/Dockerfile` | Backend container |
| `frontend/Dockerfile` | Frontend container |
| `.github/workflows/deploy.yml` | GitHub Actions CI/CD |
| `nginx-main.conf` | Nginx reverse proxy |

---

## 🔄 CI/CD Pipeline

**Trigger:** Git push to main branch

**Steps:**
1. Build backend Docker image
2. Build frontend Docker image
3. Push both to Docker Hub
4. SSH into EC2
5. Pull latest images
6. Restart docker-compose
7. Verify deployment

**Status:** ✅ Active and working

View runs: https://github.com/pavannani99/mean-crud-app/actions

---

## 🐳 Docker Images

**Backend:**
- Image: `pavannani99/mean-backend:latest`
- Digest: sha256:43983e18a80fb6d3615a33afc465f2d48abee659cf03b4482e4f58d668f43b67
- Status: ✅ Pushed

**Frontend:**
- Image: `pavannani99/mean-frontend:latest`
- Digest: sha256:19fc347f9850bb4945ba95676d70e1b7ab7b6be960e7c09c997ba97b2d8f8c6f
- Status: ✅ Pushed

---

## ☁️ AWS Infrastructure

- **Instance Type:** t3.micro (Free Tier)
- **AMI:** Ubuntu 24.04 LTS
- **Region:** ap-south-1 (Asia Pacific - Mumbai)
- **Public IP:** 43.205.212.86
- **Status:** ✅ Running

---

## 📊 Container Status

All 4 containers running:
```
✅ Nginx (port 80)
✅ Backend API (port 8080)
✅ Frontend (port 80)
✅ MongoDB (port 27017)
```

---

## 🔧 Commands

### View Logs
```bash
docker-compose logs
```

### Restart Services
```bash
docker-compose restart
```

### Rebuild and Deploy
```bash
docker-compose pull
docker-compose down
docker-compose up -d
```

---

## ✨ Summary

**Project Status:** ✅ COMPLETE

All requirements delivered:
- ✅ Containerization (Docker)
- ✅ Orchestration (Docker Compose)
- ✅ Cloud Deployment (AWS EC2)
- ✅ Database (MongoDB)
- ✅ CI/CD Pipeline (GitHub Actions)
- ✅ Reverse Proxy (Nginx)
- ✅ Application Running Live
- ✅ Documentation

**Live Demo:** http://43.205.212.86
**Repository:** https://github.com/pavannani99/mean-crud-app

---

**Assignment Submitted:** 24th February 2026
**Status:** Ready for evaluation ✅

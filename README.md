# 🚀 CI/CD Pipeline using Jenkins, Docker, GitHub Webhooks, and AWS EC2

This project demonstrates a **complete CI/CD pipeline** that automatically builds and deploys a **NestJS application** using **Jenkins**, **Docker**, **GitHub Webhooks**, and **AWS EC2**.
Whenever new code is pushed to the GitHub repository, Jenkins automatically triggers the pipeline, builds a Docker image, deploys the application, and sends an email notification.

---

# 📌 Project Overview

The goal of this project is to automate the **build, test, and deployment process** using modern DevOps tools.

This pipeline performs the following tasks automatically:

1. Detects code changes in GitHub
2. Triggers Jenkins pipeline using Webhooks
3. Builds a Docker image from the application
4. Stops and removes the previous running container
5. Deploys a new container on AWS EC2
6. Sends an email notification after deployment

---

# 🧰 Technologies Used

| Tool               | Purpose                       |
| ------------------ | ----------------------------- |
| Jenkins            | CI/CD automation server       |
| Docker             | Containerization              |
| GitHub             | Source code repository        |
| GitHub Webhooks    | Trigger Jenkins automatically |
| AWS EC2            | Cloud server for deployment   |
| Email Notification | Deployment alerts             |

---

# 🏗️ Architecture

```
Developer
   │
   │ Push Code
   ▼
GitHub Repository
   │
   │ Webhook Trigger
   ▼
Jenkins Server (AWS EC2)
   │
   │ Build Docker Image
   ▼
Docker Container
   │
   │ Deploy Application
   ▼
NestJS Application Running on EC2
   │
   ▼
Email Notification Sent
```

---

# ⚙️ CI/CD Pipeline Workflow

## 1️⃣ Code Push to GitHub

The developer pushes code to the **main branch** of the GitHub repository.

```
git add .
git commit -m "update"
git push origin main
```

---

## 2️⃣ GitHub Webhook Trigger

A webhook is configured in GitHub that sends an HTTP request to Jenkins whenever code changes occur.

Webhook URL example:

```
http://<EC2-IP>:8080/github-webhook/
```

This automatically triggers the Jenkins pipeline.

---

## 3️⃣ Jenkins Pipeline Starts

Jenkins pulls the latest code from the repository and starts the CI/CD pipeline defined in the **Jenkinsfile**.

Pipeline stages include:

* Clone repository
* Build Docker image
* Stop previous container
* Run new container
* Send email notification

---

# 🐳 Docker Usage

Docker is used to containerize the NestJS application.

### Dockerfile Example

```
FROM node:18

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm","run","start:prod"]
```

### Docker Build Command

```
docker build -t nestjs-image .
```

This command builds a Docker image for the application.

---

# ☁️ AWS EC2 Setup

The Jenkins server runs on an **AWS EC2 instance**.

Steps performed:

1. Launch EC2 instance
2. Install Docker
3. Install Jenkins
4. Open required ports

### Required Security Group Ports

| Port | Purpose            |
| ---- | ------------------ |
| 22   | SSH access         |
| 8080 | Jenkins dashboard  |
| 3000 | Application access |

Example application URL:

```
http://<EC2-IP>:3000
```

---

# 🔔 Email Notification

After successful deployment, Jenkins sends an email notification to inform that the application has been deployed.

Example notification message:

```
Subject: Deployment Notification

The NestJS application has been successfully deployed.

Access the application:
http://<EC2-IP>:3000
```

This ensures the developer is immediately informed after deployment.

---

# 📜 Jenkins Pipeline (Jenkinsfile)

```
pipeline {

   environment {
     CONTAINER_NAME = "nestjs-app"
     IMAGE_NAME = "nestjs-image"
     EMAIL = "example@gmail.com"
     PORT = "3000"
   }

   stages {

     stage('Clone Repo'){
        steps{
          git branch: 'main', url: 'YOUR_GITHUB_REPO_URL'
        }
     }

     stage('Build Docker Image'){
        steps{
          sh "docker build -t ${IMAGE_NAME} ."
        }
     }

     stage('Stop and Remove Previous Container'){
        steps{
          sh '''
          docker stop ${CONTAINER_NAME} || true
          docker rm ${CONTAINER_NAME} || true
          '''
        }
     }

     stage('Run Docker Container'){
        steps{
          sh '''
          docker run -d -p ${PORT}:${PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}
          '''
        }
     }

     stage('Send Email Notification'){
        steps{
          emailext(
            subject: "Deployment Notification",
            body: "Application deployed successfully. http://<EC2-IP>:3000",
            to: "${EMAIL}"
          )
        }
     }

   }
}
```

---

# 📂 Project Structure

```
project
│
├── Dockerfile
├── Jenkinsfile
├── package.json
├── src
│
└── README.md
```

---

# 🎯 Key Features

✔ Automated CI/CD pipeline
✔ Dockerized NestJS application
✔ GitHub Webhook trigger
✔ Automatic deployment on AWS EC2
✔ Email notification after deployment
✔ Zero manual deployment effort

---

# 🚀 How to Run the Project

### 1️⃣ Clone repository

```
git clone <repo-url>
cd project
```

### 2️⃣ Build Docker Image

```
docker build -t nestjs-image .
```

### 3️⃣ Run Docker Container

```
docker run -d -p 3000:3000 nestjs-image
```

### 4️⃣ Access Application

```
http://localhost:3000
```

---

# 📚 Learning Outcomes

Through this project, you will understand:

* CI/CD pipeline implementation
* Docker containerization
* Jenkins automation
* GitHub webhook integration
* Cloud deployment using AWS EC2
* Automated notifications

---

# 👨‍💻 Author

**Saurav Kumar**

DevOps / Cloud Enthusiast
B.Tech Computer Science Student

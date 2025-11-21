pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "awswork2025/mern-app:latest"
        KUBECONFIG = "C:\\Users\\LE0 JOHNS\\.kube\\config"
    }

    stages {
        stage('Checkout') {
            steps { 
                git branch: 'main', 
                    url: 'https://github.com/imaggartechnologiesaws-create/mern-app.git', 
                    credentialsId: 'github-creds'
            }
        }

        stage('Build Docker Image') {
            steps { 
                bat "docker build -t %DOCKER_IMAGE% ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds', 
                    usernameVariable: 'DOCKER_USER', 
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat 'docker login -u %DOCKER_USER% -p %DOCKER_PASS%'
                }
            }
        }

        stage('Push Docker Image') {
            steps { 
                bat "docker push %DOCKER_IMAGE%"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Use the kubeconfig environment variable
                bat 'kubectl apply -f k8s\\deployment.yaml'
                bat 'kubectl apply -f k8s\\service.yaml'
            }
        }
    }
}

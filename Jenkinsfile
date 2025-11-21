pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "Imaggar/mern-app:latest"
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
                // Uses Jenkins credentials to login securely
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
                bat "kubectl apply -f k8s\\deployment.yaml"
                bat "kubectl apply -f k8s\\service.yaml"
            }
        }
    }
}

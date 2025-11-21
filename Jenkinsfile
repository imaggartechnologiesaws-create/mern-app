pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "yourdockerhubusername/mern-app:latest"
    }

    stages {
        stage('Checkout') {
            steps { git branch: 'main', url: 'https://github.com/yourusername/your-repo.git' }
        }
        stage('Build Docker Image') {
            steps { sh "docker build -t ${DOCKER_IMAGE} ." }
        }
        stage('Push Docker Image') {
            steps { 
                sh "docker login -u yourdockerhubusername -p yourdockerhubpassword"
                sh "docker push ${DOCKER_IMAGE}" 
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh "kubectl apply -f k8s/deployment.yaml"
                sh "kubectl apply -f k8s/service.yaml"
            }
        }
    }
}

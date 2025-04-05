pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-app:latest"
        CONTAINER_NAME = "my-app-container"
        DOCKER_HUB_USER = "swapnahd" // Your Docker Hub username
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/dimpleswapna/my-app-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        // ... rest of your pipeline
    }

    post {
        success {
            echo 'Deployment Successful! 🎉'
        }
        failure {
            echo 'Deployment Failed ❌'
        }
    }
}

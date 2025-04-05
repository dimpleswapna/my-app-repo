pipeline {
    agent any

    environment {
        DOCKER_USERNAME = 'swapnahd'  // Your Docker Hub username
        DOCKER_PASSWORD = credentials('docker-hub-credentials')  // Jenkins Credentials ID for your Docker Hub Token
    }

    stages {
        stage('Login to Docker Hub') {
            steps {
                script {
                    // Docker login to Docker Hub using the credentials from Jenkins
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t swpanahd/my-app:latest .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    sh 'docker push swpanahd/my-app:latest'
                }
            }
        }
    }
}

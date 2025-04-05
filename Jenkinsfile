pipeline {
    agent any

    environment {
        // Docker Hub Credentials
        DOCKER_USERNAME = 'swapnahd'  // your Docker Hub username
        DOCKER_PASSWORD = credentials('dckr_pat_40h3CCBI9j-A0tfZquw6EXeLqo0')  // Jenkins Credentials ID for your Docker Hub Personal Access Token (PAT)
    }

    stages {
        stage('Login to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh 'docker build -t swpanahd/my-app:latest .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Push Docker image to Docker Hub
                    sh 'docker push swpanahd/my-app:latest'
                }
            }
        }

        stage('Post Actions') {
            steps {
                echo 'Deployment successful!'
            }
        }
    }
}

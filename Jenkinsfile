pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'swapnahd/my-app:latest'
    }

    stages {
        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'docker-hub-credentials', variable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u swapnahd --password-stdin'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push $DOCKER_IMAGE'
            }
        }
    }

    post {
        success {
            echo 'Docker Image Pushed Successfully! 🎉'
        }
        failure {
            echo 'Docker Image Push Failed ❌'
        }
    }
}

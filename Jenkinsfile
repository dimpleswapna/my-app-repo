pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-app:latest"
        CONTAINER_NAME = "my-app-container"
        DOCKER_HUB_USER = "swapnahd" // Change this!
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 't' // Change this!git 'https://github.com/my-app-repo/my-app.git'

            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Stop & Remove Existing Container') {
            steps {
                sh '''
                docker stop $CONTAINER_NAME || true
                docker rm $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run New Container') {
            steps {
                sh 'docker run -d -p 3000:3000 --name $CONTAINER_NAME $IMAGE_NAME'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: 'git '']) {
                    sh '''
                    docker tag $IMAGE_NAME $DOCKER_HUB_USER/$IMAGE_NAME
                    docker push $DOCKER_HUB_USER/$IMAGE_NAME
                    '''
                }
            }
        }
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

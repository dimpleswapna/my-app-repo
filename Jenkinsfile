pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-app:latest"
        CONTAINER_NAME = "my-app-container"
        DOCKER_HUB_USER = "swapnahd"
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Make sure you're on the correct branch (master)
                git branch: 'master', url: 'https://github.com/dimpleswapna/my-app-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('app') { // ✅ Change 'app' to the actual subdirectory name
                    sh '''
                        echo "Building Docker image from: $(pwd)"
                        ls -l
                        docker build -t $IMAGE_NAME .
                    '''
                }
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
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
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

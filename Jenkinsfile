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
                // This will check out the repository into a folder named "my-app-repo" by default.
                git branch: 'master', url: 'https://github.com/dimpleswapna/my-app-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Change directory to the checked out repo where package.json is located.
                dir('my-app-repo') {
                    sh '''
                        echo "=== [DEBUG] Current Directory ==="
                        pwd
                        echo "=== [DEBUG] Files in current directory ==="
                        ls -l
                        echo "=== [DEBUG] Checking for required files ==="
                        [ -f Dockerfile ] && echo "✅ Dockerfile found" || echo "❌ Dockerfile missing"
                        [ -f package.json ] && echo "✅ package.json found" || echo "❌ package.json missing"
                        echo "=== [DEBUG] Building Docker Image ==="
                        docker build -t $IMAGE_NAME .
                    '''
                }
            }
        }

        stage('Stop & Remove Existing Container') {
            steps {
                sh '''
                    echo "Stopping existing container if any..."
                    docker stop $CONTAINER_NAME || true
                    docker rm $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run New Container') {
            steps {
                sh '''
                    echo "Running new container..."
                    docker run -d -p 3000:3000 --name $CONTAINER_NAME $IMAGE_NAME
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh '''
                        echo "Tagging image for Docker Hub..."
                        docker tag $IMAGE_NAME $DOCKER_HUB_USER/$IMAGE_NAME
                        echo "Pushing image to Docker Hub..."
                        docker push $DOCKER_HUB_USER/$IMAGE_NAME
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed'
        }
    }
}

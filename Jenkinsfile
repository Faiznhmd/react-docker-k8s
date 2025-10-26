pipeline {
    agent any
    environment {
        IMAGE_NAME = "faizan23/react-docker-k8s"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Faiznhmd/react-docker-k8s'
            }
        }

        stage('Build Docker image') {
            steps {
                bat 'docker build -t %IMAGE_NAME%:TAG .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-token', variable: 'DOCKER_TOKEN')]) {
                    bat '''
                    echo $DOCKER_TOKEN | docker login -u faizan23 --password-stdin
                    docker push $IMAGE_NAME:$TAG
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build and push successful!"
        }
        failure {
            echo "❌ Build failed!"
        }
    }
}

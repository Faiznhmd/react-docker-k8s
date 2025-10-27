pipeline {
    // Keep 'agent any' for the initial checkout stage
    agent any

    environment {
        IMAGE_NAME = "faizan23/react-docker-k8s"
        TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                // Initial checkout runs on the standard agent
                git branch: 'main', url: 'https://github.com/Faiznhmd/react-docker-k8s'
            }
        }

        stage('Build and Push') {
            // *** THE CRITICAL CHANGE IS HERE ***
            // We switch the agent to a Docker image with the Docker client installed.
            agent {
                docker {
                    // Use a standard Docker client image.
                    // This relies on the Jenkins agent having the host's /var/run/docker.sock mounted (Option A)
                    // OR the Jenkins agent being run in --privileged mode (Option B).
                image 'docker:latest'
                    args '-u root' // Sometimes necessary for permissions inside the container
                }
            }
            steps {
                // 1. Build Docker image
                sh 'docker build -t $IMAGE_NAME:$TAG .'
                
                // 2. Push to DockerHub
                withCredentials([string(credentialsId: 'dockerhub-token', variable: 'DOCKER_TOKEN')]) {
                    sh '''
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




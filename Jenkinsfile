
pipeline {
    agent any
    tools {
        jdk 'jdk17'
        maven 'maven3.9'
    }

    stages {
        stage("Git Checkout") {
            steps {
                git branch: 'master', changelog: false, poll: false, url: 'https://github.com/Prakash170-svg/I-Txn-pay.git'
            }
        }

        stage("Compile") {
            steps {
                sh "mvn clean compile"
            }
        }

        stage("Test Cases") {
            steps {
                sh "mvn test"
            }
        }

        stage("Sonarqube Scanner") {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'Sonar-token') {
                        sh 'mvn sonar:sonar'
                    }
                }
            }
        }

        stage("Build") {
            steps {
                sh "mvn clean install"
            }
        }

        stage("Docker Deploy") {
            steps {
                script {
                    sh '''
                        echo "Stopping old container if running..."
                        docker stop loginwebseven190 || true
                        docker rm -f loginwebseven190 || true

                        echo "Starting new container..."
                        docker run -d --restart always --name=loginwebseven190 -p 8084:8080 prakash170/loginwebappseven:latest
                    '''
                }
            }
        }

        stage("TRIVY") {
            steps {
                sh "trivy image prakash170/loginwebappseven:latest > trivyimage.txt"
            }
        }
    }
}

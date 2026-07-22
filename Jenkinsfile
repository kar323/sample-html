pipeline {

    agent any

    tools {
        maven 'Maven'
    }

    environment {

        IMAGE_NAME = "yourdockerhub/sample-html"

    }

    stages {

        stage('Checkout') {

            steps {
                git 'https://github.com/username/sample-html.git'
            }

        }

        stage('Build') {

            steps {

                sh 'mvn clean package'

            }

        }

        stage('SonarQube Analysis') {

            steps {

                withSonarQubeEnv('SonarQube') {

                    sh 'mvn sonar:sonar'

                }

            }

        }

        stage('Upload to Nexus') {

            steps {

                sh 'mvn deploy'

            }

        }

        stage('Docker Build') {

            steps {

                sh 'docker build -t $IMAGE_NAME .'

            }

        }

        stage('Docker Login') {

            steps {

                withCredentials([usernamePassword(credentialsId: 'dockerhub',

                        usernameVariable: 'USER',

                        passwordVariable: 'PASS')]) {

                    sh 'echo $PASS | docker login -u $USER --password-stdin'

                }

            }

        }

        stage('Docker Push') {

            steps {

                sh 'docker push $IMAGE_NAME'

            }

        }

    }

}
pipeline {

    agent any

    tools {
        maven 'Maven'
    }

    environment {

        IMAGE_NAME = "kar233/sample-html"

    }

    stages {

        
        stage('Build') {

            steps {

                bat 'mvn clean package'

            }

        }

        stage('SonarQube Analysis') {

            steps {

                withSonarQubeEnv('SonarQube') {

                    bat 'mvn sonar:sonar -Dsonar.projectKey=sample-html'

                }

            }

        }

        stage('Upload to Nexus') {

            steps {

                bat 'mvn deploy'

            }

        }

        stage('Docker Build') {

            steps {

                bat 'docker build -t $IMAGE_NAME .'

            }

        }

        stage('Docker Login') {

            steps {

                withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-credentials',

                        usernameVariable: 'USER',

                        passwordVariable: 'PASS')]) {

                    bat 'docker login -u %USER% -p %PASS%'

                }

            }

        }

        stage('Docker Push') {

            steps {

                bat 'docker push %IMAGE_NAME%'

            }

        }

    }

}
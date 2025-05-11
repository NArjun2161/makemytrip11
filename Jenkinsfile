pipeline {
    agent any

    stages {
        stage('version Check') {
            steps {
                sh '''
                git -v
                mvn -v 
                java --version
                '''
            }
        }
        

        stage('Compile') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }
    }
}

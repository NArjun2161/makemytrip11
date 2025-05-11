pipeline {
    agent any

    tools {
        maven 'Maven 3.8.6' // Use the Maven version installed in Jenkins (name must match Jenkins config)
        jdk 'JDK 17'        // Optional: if using a specific JDK
    }

    stages {
        stage('Clean') {
            steps {
                sh 'mvn clean'
            }
        }

        stage('Compile') {
            steps {
                sh 'mvn compile'
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

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
    }

    post {
        success {
            echo 'Build and tests passed.'
        }
        failure {
            echo 'Build failed.'
        }
    }
}

pipeline {
    agent any

    stages {
        stage('Version Check') {
            steps {
                sh '''
                git --version
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

        stage('Run Artifact on Port 9090') {
            steps {
                sh '''
                JAR_FILE=$(ls target/*.jar | head -n 1)
                nohup java -jar "$JAR_FILE" --server.port=9090 > app.log 2>&1 &
                echo $! > pid.txt
                '''
            }
        }
    }
}

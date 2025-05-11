pipeline {
    agent any

    environment {
        M2_HOME = '/usr/share/maven'                         // Maven home
        SONARQUBE_ENV = 'MySonarQubeServer'                  // SonarQube server name from Jenkins config
        DOCKER_IMAGE = 'arjun1421/makemytrip11'              // Docker image name
        DOCKER_TAG = 'latest'                                // Docker tag
    }

    stages {
        stage('Checking Versions of Tools') {
            steps {
                sh '''
                    git --version
                    mvn -v
                    java --version
                '''
            }
        }

        stage('Print All Env Vars') {
            steps {
                sh 'printenv'
            }
        }

        stage('Checkout') {
            steps {
                git url: 'https://github.com/NArjun2161/makemytrip11.git'
            }
        }

        stage('Build and Test') {
            steps {
                sh 'mvn clean verify'
            }
        }

        stage('Generate JaCoCo Report') {
            steps {
                sh 'mvn jacoco:report'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${SONARQUBE_ENV}") {
                    withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
                        script {
                            def sonarScanner = tool name: 'SonarScanner', type: 'hudson.plugins.sonar.SonarScannerInstallation'
                            sh """
                                ${sonarScanner}/bin/sonar-scanner \
                                  -Dsonar.projectKey=newProject \
                                  -Dsonar.sources=src \
                                  -Dsonar.java.binaries=target/classes \
                                  -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml \
                                  -Dsonar.host.url=http://192.168.217.155:9000 \
                                  -Dsonar.login=${SONAR_TOKEN}
                            """
                        }
                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Package') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Publish Test Results') {
            steps {
                junit '**/target/surefire-reports/*.xml'
            }
        }

        stage('Archive Build Artifacts') {
            steps {
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }

        stage('Deploy (Local Run)') {
            steps {
                script {
                    def jarFile = "${env.WORKSPACE}/target/makemytrip-0.0.1-SNAPSHOT.jar"
                    sh 'pkill -f "makemytrip.*.jar" || true'
                    sh """
                        nohup java -jar ${jarFile} --server.port=9090 > app.log 2>&1 & 
                        echo "App started on port 9090"
                    """
                }
            }
        }

        stage('Complete Pipeline') {
            steps {
                echo '✅ Arjun Pipeline executed successfully!'
            }
        }
    }

    post {
        success {
            echo '🎉 Pipeline completed successfully.'
        }
        failure {
            echo '❌ Pipeline failed. Please check the logs.'
        }
    }
}

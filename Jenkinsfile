pipeline{
	agent any
	stages{
		steps ('compile'){
			sh 'mvn clean compile'
		}
		steps ('test'){
			sh 'mvn clean test'
		}

		steps ('package'){
			sh 'mvn clean package'
		}

	}
}
pipeline {

  environment {
    registry = "10.0.0.5:5000/explog"
    dockerImage = "explog"
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/thegodsson/K8S.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( "http://10.0.0.5:5000', 'myregistry_login'" ) {
            dockerImage.push()
          }
        }
      }
    }

    stage('Deploy App') {
      steps {
        script {
          kubernetesDeploy(configs: "stack_explog.yaml.yaml", kubeconfigId: "mykubeconfig")
        }
      }
    }

  }

}

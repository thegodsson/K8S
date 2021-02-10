def buildNum = env.BUILD_NUMBER 
def branchName= env.BRANCH_NAME
def imageName='10.0.0.5:5000/explog'
print buildNum
print branchName
print imageName

pipeline {

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/thegodsson/K8S.git'
      }
    }

    stage('Build and Push Image') {
      steps{
        script {
          docker.withRegistry('http://10.0.0.5:5000', 'myregistry_login') {
             def customImage = docker.build("$imageName:${branchName}-${buildNum}")
               customImage.push()
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

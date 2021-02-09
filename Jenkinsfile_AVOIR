def buildNum = env.BUILD_NUMBER 
def branchName= env.BRANCH_NAME


pipeline {

environment {
   def imageName='10.0.0.5:5000/explog'
   print buildNum
   print branchName
   print imageName
  }


  agent { label 'kubepod' }

  stages {

    stage('Checkout Source') {
      steps {
        git url:'https://github.com/thegodsson/testjenkins1.git', branch:'main'
      }
    }

    stage('Build Image') {
    docker.withRegistry('http://10.0.0.5:5000', 'myregistry_login') {
       def customImage = docker.build("$imageName:${branchName}-${buildNum}")
         customImage.push()
      }
    }


   stage('AFFICHAGE DE LIMAGE'){
        def der_image = "$imageName:${branchName}-${buildNum}"
        }

    stage('Deploy App') {
      steps {
        script {
          kubernetesDeploy(configs: "stack_explog.yaml", kubeconfigId: "mykubeconfig")
        }
      }
    }

  }

}

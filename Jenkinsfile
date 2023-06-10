pipeline {

agent {
node {
label 'workstation'
}
}
parameters {
choice(name: 'env', choices: ['dev', 'prod'], description: 'Pick environment')
}
stages {
 stage('Terraform INIT'){
 steps {
  sh 'terraform init -backend-config=env-${env}/state.tfvars'
 }
 }
 stage('Terraform APPLY'){
  steps {
   sh 'terraform apply -var-file=env-${env}/main.tfvars -auto-approve'
  }
  }
}
post {
  always {
     cleanWs()
    }
  }

}
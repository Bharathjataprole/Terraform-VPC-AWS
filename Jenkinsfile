pipeline {

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = "AKIAQ3EGRFLAOQ2G2WWJ"
        AWS_SECRET_ACCESS_KEY = "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"
    }

   agent  any
    stages {
        stage('init') {
            steps {
                sh '''
                cd ${JENKINS_WORKSPACE}/Terraform-VPC-AWS
                terraform init
                terraform plan
                terraform apply
                '''
        
        }
    }

  }

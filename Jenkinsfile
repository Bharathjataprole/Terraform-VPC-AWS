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
        stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/Bharathjataprole/Terraform-VPC-AWS.git"
                        }
                    }
                }
            }

        stage('init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('apply') {
            steps {
                sh 'terraform apply'
            }
        }
    }

  }

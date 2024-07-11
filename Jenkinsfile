pipeline {
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = "AKIAQ3EGRFLAOQ2G2WWJ"
        AWS_SECRET_ACCESS_KEY = "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"
        AWS_DEFAULT_REGION = "us-east-1"
    }
   agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Bharathjataprole/Terraform-VPC-AWS.git'
            }
        }
            
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Plan') {
            steps {
                sh 'terraform plan -out tfplan'
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Apply') {
            steps {
                sh 'terraform apply'
                
    }
}
    }
}

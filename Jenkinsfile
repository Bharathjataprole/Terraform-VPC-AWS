pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }

    stages {
        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -out=tfplan -input=false'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }
    }

    post {
        always {
            // Clean up Terraform files
            cleanWs()
        }
    }
}

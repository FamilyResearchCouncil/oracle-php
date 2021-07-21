#!/usr/bin/env groovy
withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
    properties([
        parameters([
            string(defaultValue: "${DOCKER_USERNAME}", name: 'DOCKER_USERNAME'),
            string(defaultValue: "${DOCKER_PASSWORD}", name: 'DOCKER_PASSWORD')
        ])
    ])
}

node('master') {
    stage('build') {
        checkout scm

        sh "docker build ./7.4 -t oracle-php:7.4 -t ${params.DOCKER_USERNAME}/oracle-php:7.4"
        sh "docker build ./8.0 -t oracle-php -t oracle-php:8.0 -t ${params.DOCKER_USERNAME}/oracle-php:8.0"
    }

    if( env.BRANCH_NAME == 'master' ){

        stage('push') {
            docker.withRegistry('https://docker.io', 'dockerhub'){
                sh "docker push ${params.DOCKER_USERNAME}/oracle-php:7.4"
                sh "docker push ${params.DOCKER_USERNAME}/oracle-php:8.0"
            }

            sh "docker logout"
        }
    }
}

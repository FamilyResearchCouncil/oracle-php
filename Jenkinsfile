#!/usr/bin/env groovy
withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
    properties([
        parameters([
            string(defaultValue: "${DOCKER_USERNAME}", name: 'DOCKER_USERNAME'),
        ])
    ])
}

node('master') {
    checkout scm

    stage('build 7.4') {
        docker.build("oracle-php:7.4", './7.4')
    }
    stage('build 8.0'){
        def image = docker.build("oracle-php:8.0", './8.0')
    }

    if( env.BRANCH_NAME == 'master' ){
        stage('push') {
            docker.withRegistry('https://docker.io', 'dockerhub'){
                docker.image('oracle-php:7.4').push("${params.DOCKER_USERNAME}/oracle-php:7.4")
                docker.image('oracle-php:8.0').push("${params.DOCKER_USERNAME}/oracle-php:8.0")
            }

        }
    }
}

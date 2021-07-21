#!/usr/bin/env groovy
node('master') {
    stage('dockerhub-login') {
        checkout scm
        // pull in oracle creds for dev database access
        withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
        }

    }

    stage('build') {
        withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh 'docker build ./7.4 -t oracle-php -t oracle-php:7.4 -t $DOCKER_USERNAME/oracle-php:7.4'
            sh 'docker build ./8.0 -t oracle-php -t oracle-php:7.4 -t $DOCKER_USERNAME/oracle-php:8.0'
        }
    }

    if( env.BRANCH_NAME == 'master' ){

        stage('push') {
            withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                sh 'docker push $DOCKER_USERNAME/oracle-php:7.4'
                sh 'docker push $DOCKER_USERNAME/oracle-php:8.0'
            }
        }
    }
}

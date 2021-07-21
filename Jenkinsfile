#!/usr/bin/env groovy
node('master') {
    checkout scm

    stage('build 7.4') {
        docker.build("familyresearchcouncil/oracle-php:7.4", './7.4')
    }

    stage('build 8.0'){
        docker.build("familyresearchcouncil/oracle-php:8.0", './8.0')
    }

    if( env.BRANCH_NAME == 'master' ){
        stage('push') {
            docker.image('familyresearchcouncil/oracle-php:7.4').push()
            docker.image('familyresearchcouncil/oracle-php:8.0').push()
        }
    }
}

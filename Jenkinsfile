#!/usr/bin/env groovy
node('master') {
    checkout scm
    withRegistry('', 'dockerhub'){

        stage('7.4') {
            def image = docker.build("familyresearchcouncil/oracle-php", './7.4')
            if( env.BRANCH_NAME == 'master' ){
                image.push('7.4')
            }
        }

        stage('8.0'){
            def image = docker.build("familyresearchcouncil/oracle-php", './8.0')
            if( env.BRANCH_NAME == 'master' ){
                image.push('8.0')
            }
        }

    }
}

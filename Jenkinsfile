#!/usr/bin/env groovy
node('master') {
    checkout scm
    docker.withRegistry('', 'dockerhub'){
        stage('build'){
            steps {
                parallel (
                    "7.4" : {
                        def image = docker.build("familyresearchcouncil/oracle-php", './7.4')
                        if( env.BRANCH_NAME == 'master' ){
                            image.push('7.4')
                        }
                    },
                    "8.0" : {
                        def image = docker.build("familyresearchcouncil/oracle-php", './8.0')
                        if( env.BRANCH_NAME == 'master' ){
                            image.push()
                            image.push('8.0')
                        }
                    }
                )
            }
        }
    }
}

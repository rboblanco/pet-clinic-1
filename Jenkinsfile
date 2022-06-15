pipeline {
    agent any 
    environment {
       DOCKER = tool 'docker' 
       DOCKER_EXEC = '$DOCKER/docker'
       SCA = '/Users/clagosu/Documents/dependency-check/bin/dependency-check.sh'
    }
    stages {
      
      stage('SCM') {
         steps {
            checkout scm // clonacion de codigo en nodo
         }
      }
        
      stage('BUILD') {
         steps {
            echo '************** BUILD **************'
            sh 'set +x; chmod 777 gradlew'
            sh './gradlew clean build'
          //archiveArtifacts artifacts: "build/libs/testing-web-*.jar"
         }
      }
        
      stage('SAST') {
         steps {
            withCredentials([string(credentialsId: 'sonarcloud', variable: 'SONARPAT')]) {
                 echo '************** SAST SONARCLOUD **************'
                 sh('set +x; ./gradlew sonarqube -Dsonar.login=$SONARPAT -Dsonar.branch.name=feature-jenkins')
            }
         }
      }
        
      stage('SCA') {
        steps {
            echo '************** SCA DEPENDENCY CHECK **************'
            sh "$SCA --project 'spring-clinic' --scan '${WORKSPACE}/build/libs/spring-petclinic-2.6.0.jar'"
            echo '************** SBOM CYCLONEDX **************'
            sh "./gradlew cyclonedxBom -info"
        }
     }
        
      stage('Build Image') {
         steps {
            figlet 'IMAGE'
          //sh '${DOCKER EXEC} build .'
            //sh "$DOCKER_EXEC images"
          //sh "$DOCKER_EXEC push clagosu/spring-clinic:$currentBuild.number"
            }
        }
        
        stage('DAST') {
        steps {
            figlet 'DAST OWASP ZAP'
            //sh "${DOCKER_EXEC} run --rm -v ${WORKSPACE}:/zap/wrk/:rw -t owasp/zap2docker-stable zap-baseline.py -t https://www.hackthissite.org/ -r DAST_Report.html"
        }
     }
        
   }
}


pipeline {
   
   environment {
     CONTAINER_NAME = "nestjs-app"
     IMAGE_NAME = "nestjs-image"
     EMAIL = "sonukumarteg245@gmail.com"
     PROT = "3000"
   }

   stages {
     stage('Clone Repo'){
      steps{
        git branch: 'main', url: 'https://github.com/Saurav6200907210/CI-CD-using-jenkins-github-webhook-AWS-ec2-docker.git'
      }
     }
     stage('Build Docker Image') {
       steps {
         sh "docker build -t ${IMAGE_NAME} . "
       }
     }
     stage('Stop and Remove Previous Container') {
       steps {
         sh '''
              docker stop ${CONTAINER_NAME} || true
              docker rm ${CONTAINER_NAME} || true
         '''
       }
     }
     stage('Docker Container Run') {
       steps {
         sh '''
              docker run -d -p ${PROT}:${PROT} --name ${CONTAINER_NAME} ${IMAGE_NAME}
         '''
       }
     }
          stage('send email notification') {
       steps {
         emailtext{
          subject = "Deployment Notification",
          body = "The NestJS application has been successfully deployed  the server.
          http://13.235.104.54:${PROT}/"
          to = "${EMAIL}"
         }
       }
     }
   }
}
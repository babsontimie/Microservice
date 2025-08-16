// pipeline {
//     agent any

//     stages {
//         stage('Build & Tag Docker Image') {
//             steps {
//                 script {
//                     withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
//                         sh "docker build -t oktbabs/adservice:latest ."
//                     }
//                 }
//             }
//         }
        
//         stage('Push Docker Image') {
//             steps {
//                 script {
//                     withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
//                         sh "docker push oktbabs/adservice:latest "
//                     }
//                 }
//             }
//         }
//     }
// }


pipeline {
  agent any

  environment {
    REGISTRY = "docker.io/oktbabs"
    IMAGE_TAG = "${env.BUILD_NUMBER}"
    GIT_REPO = "https://github.com/babsontimie/ecommerce-gitops.git"
    APP_NAME = "ecommerce"
    CHART_PATH = "helmchart/ecommerce"
  }

  stages {
    stage('Build & Push Image') {
      steps {
        sh """
          docker build -t $REGISTRY/adservice:$IMAGE_TAG ./services/adservice
          docker push $REGISTRY/adservice:$IMAGE_TAG
        """
      }
    }

    stage('Update Helm Values') {
      steps {
        sh """
          git clone $GIT_REPO ecommerce-gitops
          cd ecommerce-gitops/$CHART_PATH
          yq -i '.image.tag = "IMAGE_TAG"' values.yaml
          git config user.email "oktbabs@gmail.com"
          git config user.name "teeadmin"
          git commit -am "Update image tag to $IMAGE_TAG"
          git push origin main
        """
      }
    }
  }
}


pipeline {
   agent {
        docker {
            image 'anadsonpassos/quarentenarubywd'
        }
    }

   stages {
      stage('Build') {
         steps {
            echo 'Building or Resolve Dependencies!'
            sh 'bundle install'
         }
      }
      stage('Test') {
            steps {
                echo 'Running regression tests'
                sh 'bundle exec cucumber -p dailus -p ci -t @regressao'
            }
        }
        stage('UAT') {
            steps {
                echo 'Wait for User Acceptance'
                input(message: 'Go to production?', ok: 'Yes')
            }
        }
        stage('Prod') {
            steps {
                echo 'webApp is Ready :)'
            }
        }
   }
}

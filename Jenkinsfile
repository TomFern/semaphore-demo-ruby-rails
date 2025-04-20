pipeline {

    agent none

    environment {
        HOME = "/tmp/build"
      }

    stages {

        stage('Bundle') {
            agent {
                docker { image 'registry.semaphoreci.com/ruby:2.7' }
            }

            cache(caches: [
                    arbitraryFileCache(path: 'vendor', cacheValidityDecidingFile: 'Gemfile.lock')
            ])

            steps {
                sh 'mkdir -p $HOME'
                sh 'bundle install'
            }
        }

        stage('Linters') {
            agent {
                docker { image 'registry.semaphoreci.com/ruby:2.7' }
            }

            cache(caches: [
                    arbitraryFileCache(path: 'vendor', cacheValidityDecidingFile: 'Gemfile.lock')
            ])

            steps {
                sh 'bundle exec rubocop'
                sh 'bundle exec brakeman'
            }
        }


    }

}


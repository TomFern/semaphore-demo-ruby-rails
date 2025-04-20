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


            steps {
                cache(caches: [
                        arbitraryFileCache(path: 'vendor', cacheValidityDecidingFile: 'Gemfile.lock')
                ])
                sh 'mkdir -p $HOME'
                sh 'bundle install'
            }
        }

        stage('Linters') {
            agent {
                docker { image 'registry.semaphoreci.com/ruby:2.7' }
            }


            steps {
                cache(caches: [
                        arbitraryFileCache(path: 'vendor', cacheValidityDecidingFile: 'Gemfile.lock')
                ])
                sh 'bundle exec rubocop'
                sh 'bundle exec brakeman'
            }
        }


    }

}


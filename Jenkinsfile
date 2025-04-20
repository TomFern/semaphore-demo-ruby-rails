pipeline {
  agent {
      docker { image 'registry.semaphoreci.com/ruby:2.7-node-browsers' }
  }

  environment {
      HOME = "/tmp/build"
  }

  stages {
    stage('Install gems') {
      steps {
        cache(caches: [
          arbitraryFileCache(
            path: 'vendor',
            cacheName: 'gem-cache',
            cacheValidityDecidingFile: 'Gemfile.lock'
          )
        ]) {
          sh 'mkdir -p $HOME'
          sh 'bundle install'
        }
      }
    }

    stage('Linters') {
      steps {
          sh 'mkdir -p $HOME'
          sh 'bundle exec rubocop'
          sh 'bundle exec brakeman'
      }
    }
    stage('Unit tests') {
      parallel {
        stage('Model tests') {
          steps {
              sh 'mkdir -p $HOME'
              sh 'bundle exec rake db:setup'
              sh 'bundle exec rspec spec/models'
          }
        }
        stage('Controller tests') {
          steps {
              sh 'mkdir -p $HOME'
              sh 'bundle exec rake db:setup'
              sh 'bundle exec rspec spec/controllers'
          }
        }
      }
    }

  stages {
    stage('Integration tests') {
      steps {
          sh 'mkdir -p $HOME'
          sh 'bundle exec rake db:setup'
          sh 'bundle exec rspec spec/features'
        }
      }
    }
  }
}


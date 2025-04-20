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
  }
}


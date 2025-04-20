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
            path: 'vendor/cache',
            cacheName: 'gem-cache',
            cacheValidityDecidingFile: 'Gemfile.lock'
          ),
          arbitraryFileCache(
            path: 'vendor/bundle',
            cacheName: 'bundle-cache',
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
        cache(caches: [
          arbitraryFileCache(
            path: 'vendor/cache',
            cacheName: 'gem-cache',
            cacheValidityDecidingFile: 'Gemfile.lock'
          ),
          arbitraryFileCache(
            path: 'vendor/bundle',
            cacheName: 'bundle-cache',
            cacheValidityDecidingFile: 'Gemfile.lock'
          )
        ]) {
          sh 'mkdir -p $HOME'
          sh 'bundle exec rubocop'
          sh 'bundle exec brakeman'
        }
      }
    }
  }
}


pipeline {
            agent {
                docker { image 'registry.semaphoreci.com/ruby:2.7' }
            }

  stages {
    stage('Restore cache') {
      steps {
        // restore both the raw gems and the installed bundle
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
        ])
      }
    }

    stage('Install gems') {
      steps {
        sh '''
          bundle install
        '''
      }
    }

    stage('Save cache') {
      steps {
        // save both caches again under the same keys
        cache(caches: [
          arbitraryFileCache(path: 'vendor/cache', cacheName: 'gem-cache'),
          arbitraryFileCache(path: 'vendor/bundle', cacheName: 'bundle-cache')
        ])
      }
    }

    stage('Test') {
      steps {
        sh 'bundle exec rake test'
      }
    }
  }
}


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

        stage('Setup') {
            steps {
                // Use the stash/unstash plugin to cache the vendor directory
                cache(path: 'vendor/bundle', key: "${env.JOB_NAME}-${hashFiles('Gemfile.lock')}") {
                    // sh 'apt-get update && apt-get install -y build-essential git sqlite3 libsqlite3-dev'
                    // sh 'bundle config set --local path "vendor/bundle"'
                    sh 'bundle install'
                }
            }
        }
        //     steps {
        //         cache(path
        //         caches: [
        //                 arbitraryFileCache(path: 'vendor', cacheValidityDecidingFile: 'Gemfile.lock')
        //         ])
        //         sh 'mkdir -p $HOME'
        //         sh 'bundle install'
        //     }
        // }

        stage('Linters') {
            agent {
                docker { image 'registry.semaphoreci.com/ruby:2.7' }
            }


            steps {
                sh 'bundle exec rubocop'
                sh 'bundle exec brakeman'
            }
        }


    }

}


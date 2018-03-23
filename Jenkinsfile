projectId = "jenkins-pipeline-playground"
support.initializeCache(projectId)

pipeline {
  agent {
    dockerfile {
      filename "Dockerfile"
      additionalBuildArgs support.ciDockerFileBuildArgs()
      args "${support.ciDockerFileRunArgs(projectId)}"
    }
  }

  options {
    ansiColor("xterm")
    buildDiscarder(logRotator(numToKeepStr: "10", daysToKeepStr: "3"))
  }

  stages {
    stage("Setup") {
      environment {
        MY_ENV_VAR = 'something'
      }

      steps {
        sh "bash ./printenv.sh"
        sh "TRACE=true ./cache.sh restore"
      }
    }

    stage("Test") {
      steps {
        sh "ls -ls /tmp"
        sh "echo hello > /tmp/\$(date +'%Y%m%d%H%M%S')"
        sh "ls -ls /tmp"
      }
    }
  }

  post {
    always {
      script {
        sh "./cache.sh store"
        support.restoreWorkspacePermissions()
      }
    }
  }
}

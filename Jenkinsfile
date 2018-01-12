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
  }

  stages {
    stage("Setup") {
      steps {
        sh "./cache.sh restore"
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

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
    stage("Test") {
      steps {
        sh "ruby hello.rb"
      }
    }
  }

  post {
    always {
      script {
        support.restoreWorkspacePermissions()
      }
    }
  }
}

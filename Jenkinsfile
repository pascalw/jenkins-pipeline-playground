projectId = "jenkins-pipeline-playground"
support.initializeCache(projectId)

cacheTar = "/cache/cache-${JOB_BASE_NAME}.tar"

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
        sh "[ -e ${cacheTar} ] && (cd /tmp/ && rm -f ./* && tar xf ${cacheTar}) || true"
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
        sh "tar cf ${cacheTar} -C /tmp/ ."
        support.restoreWorkspacePermissions()
      }
    }
  }
}

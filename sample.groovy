pipelines = ["pipeline-1", "pipeline-2"]

pipelines.each { pipeline ->
    println "Creating pipeline ${pipeline}"
    create_pipeline(pipeline)
}

def create_pipeline(String name) {
    pipelineJob(name) {
        definition {
            cps {
                sandbox(true)
                script("""
pipeline {
    agent any
    stages {
        stage("Test1") {
            steps {
                sh "echo 'helo from ${name}'"
                sh "whoami"
                sh "ls -lah"
            }
        }
        stage("Test2") {
            steps {
                sh "echo testing 1"
            }
        }
    }
}

""")
            }
        }
    }
}
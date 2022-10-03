FROM jenkins/jenkins:lts-jdk11

# copy the list of plugins we want to install
#COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
#RUN cat /usr/share/jenkins/ref/plugins.txt
#RUN curl -k -I https://updates.jenkins.io:443

# run the install-plugins script to install the plugins
RUN jenkins-plugin-cli \
    --plugins \
    configuration-as-code \
    matrix-auth \
    git \
    workflow-aggregator \
    blueocean \
    workflow-job \
    workflow-cps \
    job-dsl \
    pipeline-utility-steps

# disable the setup wizard as we will set up jenkins as code :)
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# copy the seedjob file into the image
COPY sample.groovy /usr/local/sample.groovy

# copy the config-as-code yaml file into the image
COPY jenkins-casc.yaml /usr/local/jenkins-casc.yaml

# tell the jenkins config-as-code plugin where to find the yaml file
ENV CASC_JENKINS_CONFIG /usr/local/jenkins-casc.yaml
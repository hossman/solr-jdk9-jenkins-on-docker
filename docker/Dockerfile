# -*- mode: Shell-script -*-

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM    openjdk:9-jdk

# hack to work around weird crypto packaging issue in openjdk-9..
# https://github.com/docker-library/openjdk/issues/101
ENV JAVA_CONF_DIR=$JAVA_HOME/conf
RUN bash -c '([[ ! -d $JAVA_SECURITY_DIR ]] && ln -s $JAVA_HOME/lib $JAVA_HOME/conf) || (echo "Found java conf dir, package has been fixed, remove this hack"; exit -1)'



ENV JENKINS_GID=7000
ENV JENKINS_UID=7000

RUN groupadd --gid $JENKINS_GID jenkins && \
  adduser --quiet --gecos "" --disabled-password --uid $JENKINS_UID --gid $JENKINS_GID jenkins

# add ant
RUN export DEBIAN_FRONTEND=noninteractive TERM=linux && \
  apt-get update && \
  apt-get -y install ant unzip && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LANGUAGE en_US:en
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

USER jenkins
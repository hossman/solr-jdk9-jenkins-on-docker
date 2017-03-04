#!/bin/bash

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


# Run on the host machine (typically by jenkins) to trigger docker to run "run-inside-docker.sh"

set -e
set -x

mkdir -p workspace  # This dir has to be writable by the in-container jenkins user
# TODO: if we pass $(id -u) & $(id -g) into our 'docker build' as args, we can skip this
chmod a+w workspace

cp run-inside-docker.sh workspace/

docker run \
  -v $PWD/workspace:/home/jenkins \
  -u jenkins -w /home/jenkins \
  hossman/solr-jdk9-builder:latest bash run-inside-docker.sh


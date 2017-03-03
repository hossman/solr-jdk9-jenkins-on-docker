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


# Run on the host machine (typically by jenkins) to ensure the workspace is up to date
# and trigger docker to run "run-inside-docker.sh"

set -e
set -x

mkdir -p workspace
if [ ! -d workspace/lucene-solr ]; then
  (cd workspace && git clone https://git-wip-us.apache.org/repos/asf/lucene-solr.git)
fi
(cd workspace/lucene-solr && git clean -fx)

cp run-inside-docker.sh workspace/

# nocommit: is there a more secure way to do this?
# can we tie the UID/GID inside docker to a UID/GID of the (effective) user running this script?
chmod -R a+w workspace || true # "|| true" because our jenkins user will already own some files after the first build

docker run \
  -v $PWD/workspace:/home/jenkins \
  -u jenkins -w /home/jenkins \
  hossman/solr-jdk9-builder:latest bash run-inside-docker.sh


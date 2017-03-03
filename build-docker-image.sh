#!/bin/bash


# Run on the host machine (typically by jenkins) to ensure the docker image is up to date
# with the most current version of the JDK

set -e
set -x

(cd docker && docker build -t hossman/solr-jdk9-builder:latest .)

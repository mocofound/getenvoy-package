#!/bin/bash

# Copyright 2019 Tetrate
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

export DEBIAN_FRONTEND=noninteractive

apt-get -y update

apt-get install -y --no-install-recommends curl wget make git python python-pip python-setuptools python3 python3-pip \
  unzip bc libtool ninja-build automake zip time gdb strace tshark tcpdump patch xz-utils rsync ssh-client \
  software-properties-common apt-transport-https ca-certificates rpm

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update && apt-get -y install docker-ce docker-ce-cli containerd.io

apt-get clean

# bazelisk
VERSION=1.5.0
SHA256=605c4b417654a09febc7e15c6b802195fdd1c4fe8d876145fb15f10d4fa27b5b
curl --location --output /usr/local/bin/bazel https://github.com/bazelbuild/bazelisk/releases/download/v${VERSION}/bazelisk-linux-amd64 \
  && echo "$SHA256  /usr/local/bin/bazel" | sha256sum --check \
  && chmod +x /usr/local/bin/bazel

# Copyright 2019 The Volcano Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


FROM nginx:latest

# Install requirements for static services(hugo)

RUN mkdir -p /usr/local/website
COPY . /usr/local/website/
RUN apt-get update && \
    apt-get install wget -y && \
    wget -P /tmp/ https://obs.cn-north-1.myhuaweicloud.com:443/obs-community-bucket/hugo_0.41.tar.gz && \
    tar -zxvf /tmp/hugo_0.41.tar.gz -C /tmp && \
    cp /tmp/hugo /usr/local/bin/ && \
    cd /usr/local/website && \
    hugo && \
    cp -r public/* /usr/share/nginx/html && \
    sed -i "s/user  nginx;/user root root;/g" /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]

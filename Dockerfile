FROM ubuntu:14.04
MAINTAINER Jason Worley jason@jasonincode.com

# Install Nginx.
RUN echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main" > /etc/apt/sources.list.d/nginx-stable-trusty.list
RUN echo "deb-src http://ppa.launchpad.net/nginx/stable/ubuntu trusty main" >> /etc/apt/sources.list.d/nginx-stable-trusty.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C
RUN apt-get update
RUN apt-get install --only-upgrade bash
RUN apt-get install -y  wget nginx

RUN wget http://nodejs.org/dist/v0.10.33/node-v0.10.33-linux-x64.tar.gz
RUN mkdir -p ~/.node/ && tar -C ~/.node/ -xzvf node-v0.10.33-linux-x64.tar.gz --strip-components=1
RUN rm node-v0.10.33-linux-x64.tar.gz && ln -s ~/.node/bin/node /usr/bin/node && ln -s ~/.node/bin/npm /usr/bin/npm

RUN npm install -g dockermon

RUN wget -O /usr/bin/shoreman https://github.com/hecticjeff/shoreman/raw/master/shoreman.sh && chmod u+x /usr/bin/shoreman

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN sed -i 's/# server_names_hash_bucket/server_names_hash_bucket/g' /etc/nginx/nginx.conf

RUN mkdir /app
WORKDIR /app
ADD . /app

EXPOSE 80
ENV DOCKER_HOST /tmp/docker.sock

CMD ["shoreman"]

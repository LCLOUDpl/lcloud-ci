FROM amazonlinux:2018.03-with-sources
LABEL maintainer="Tom Skibinski <tomasz.skibinski@lcloud.pl>"

ARG SLS_VERSION
ENV LANG=en_US.UTF-8 \
    SLS_VERSION=${SLS_VERSION:-1.36.1}

RUN yum update -y \
    && yum install -y \
        curl \
        wget \
    \
    && curl --silent --location https://rpm.nodesource.com/setup_8.x | bash - \
    && yum install -y \
        gcc \
        git \
        jq \
        nodejs \
        openssl-devel \
        python27-devel \
        python27-pip \
        python36 \
        python36-devel \
        python36-pip \
        ruby24 \
        unzip \
        which \
        zip \
        zlib-devel \
   && ln -s -T /usr/bin/pip-3.6 /usr/bin/pip3 \
   && yum clean all \
   \
   && pip3 install -U \
        awscli \
        aws-sam-cli \
   \
   && npm install -g \
        npm \
        serverless@$SLS_VERSION \
   \
   && gem install cfn-nag


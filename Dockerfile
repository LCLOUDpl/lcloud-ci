#FROM amazonlinux:2018.03-with-sources
FROM amazonlinux:2018.03
LABEL maintainer="Tom Skibinski <tomasz.skibinski@lcloud.pl>"

ARG SLS_VERSION
ENV LANG=en_US.UTF-8 \
    SLS_VERSION=${SLS_VERSION:-1.83.0}

RUN yum update -y \
    && yum install -y \
        curl \
        wget \
        yum-utils \
    \
    && curl --silent --location https://rpm.nodesource.com/setup_12.x | bash - \
    && yum install -y \
        docker \
        gcc \
        libtool \
        autoconf \
        git \
        jq \
        nodejs \
        openssl-devel \
        python27-devel \
        python27-pip \
        python36 \
        python36-devel \
        python36-pip \
        python38 \
        python38-devel \
        python38-pip \
        ruby24 \
        ruby24-devel \
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
        cfn-flip \
        cfn-lint \
        cfn-tools \
   \
   && npm install -g \
        serverless@$SLS_VERSION \
   \
   && gem install cfn-nag --version "0.6.23"

# Display versions
RUN python --version \
    && python3 --version \
    && aws --version \
    && sam --version \
    && node --version \
    && sls --version \
    && cfn_nag --version \
    && cfn-lint --version 

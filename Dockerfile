FROM amazonlinux:2018.03
LABEL maintainer="Tom Skibinski <tomasz.skibinski@lcloud.pl>"

ARG SLS_VERSION
ENV LANG=en_US.UTF-8 \
    SLS_VERSION=${SLS_VERSION:-2.44.0}

RUN yum update -y \
    && yum install -y \
        curl \
        yum-utils \
    \
    && curl -sL https://rpm.nodesource.com/setup_14.x | bash - \
    && curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo \
    && yum install -y \
        autoconf \
        docker \
        gcc \
        git \
        jq \
        libtool \
        nodejs \
        openssl-devel \
        python27-devel \
        python27-pip \
        python38 \
        python38-devel \
        python38-pip \
        ruby24 \
        ruby24-devel \
        sudo \
        unzip \
        wget \
        which \
        yarn \
        zip \
        zlib-devel \
   && yum clean all \
   \
   && ln -s -T /usr/bin/pip-3.8 /usr/bin/pip3 \
   && pip3 install -U \
        awscli==1.19.87 \
        aws-sam-cli==1.24.0 \
        cfn-flip==1.2.3 \
        cfn-lint==0.50.0 \
        cfn-tools==0.1.6 \
        urllib3==1.25.11 \
   \
   && npm install -g \
        serverless@$SLS_VERSION \
   \
   && gem install cfn-nag --version "0.6.23" \
   \
   && curl -sL https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash -

# Display versions
RUN python --version \
    && python3 --version \
    && python3 --version \
    && aws --version \
    && sam --version \
    && node --version \
    && sls --version \
    && cfn_nag --version \
    && cfn-lint --version \
    && tflint --version

FROM technomatix/php:7.2-cli-jessie

ENV \
    SONARCLI_VERSION=3.3.0.1492 \
    SONAR_GPG="CFCA4A29D26468DE"

RUN set -xe && \
    apt-get -qq update && \

    # Install Tools
    apt-get -qq install --assume-yes jq unzip gpg && \

    # Install ShellCheck
    curl --insecure -OL https://storage.googleapis.com/shellcheck/shellcheck-stable.linux.x86_64.tar.xz && \
    tar -xvf shellcheck-stable.linux.x86_64.tar.xz && \
    mv shellcheck-stable/shellcheck /usr/local/bin/shellcheck && \
    rm -fr shellcheck-stable shellcheck-stable.linux.x86_64.tar.xz && \

    # Install xDebug
    pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    echo "xdebug.remote_enable=on" | tee -a /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.remote_connect_back=on" | tee -a /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \

    # Install Bats
    git clone --depth 1 https://github.com/sstephenson/bats.git /tmp/bats && \
    cd /tmp/bats && \
    ./install.sh /usr/local && \

    # Install shfmt
    curl --fail --location https://github.com/mvdan/sh/releases/download/v2.6.3/shfmt_v2.6.3_linux_amd64 > /usr/local/bin/shfmt && \
    chmod +x /usr/local/bin/shfmt && \

    # Install Codeception
    composer global require --optimize-autoloader codeception/codeception && \

    # Install Sonar Scanner
    curl --output sonar-scanner-cli.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONARCLI_VERSION}-linux.zip && \
    curl --output sonar-scanner-cli.zip.asc https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONARCLI_VERSION}-linux.zip.asc && \
    gpg --status-fd 1 --verify sonar-scanner-cli.zip.asc sonar-scanner-cli.zip | grep ${SONAR_GPG} && \
    unzip sonar-scanner-cli.zip && \
    mv sonar-scanner-${SONARCLI_VERSION}-linux /opt/sonar-scanner && \

    # Clean
    composer clearcache && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.gnupg

ENV PATH="/opt/sonar-scanner/bin:${PATH}"

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF

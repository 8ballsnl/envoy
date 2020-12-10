FROM php:7.4-alpine
ENV PATH="${PATH}:/root/.composer/vendor/bin"
RUN mkdir -p ~/.ssh;
RUN apk add --no-cache openssh-client bash git rsync
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN composer global require laravel/envoy --no-plugins --no-scripts && composer clearcache

COPY init-ssh /usr/local/bin/init-ssh
RUN chmod +x /usr/local/bin/init-ssh && ln -s /usr/local/bin/init-ssh /init-ssh
ENTRYPOINT ["/bin/bash", "-c"]

FROM php:8.0-alpine
ENV PATH="${PATH}:/root/.composer/vendor/bin"
RUN mkdir -p ~/.ssh;
RUN apk add --no-cache openssh-client bash git rsync
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN composer global require laravel/envoy --no-plugins --no-scripts && composer clearcache

COPY init-ssh /usr/local/bin/init-ssh
RUN chmod +x /usr/local/bin/init-ssh && ln -s /usr/local/bin/init-ssh /init-ssh
RUN echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
ENTRYPOINT ["/bin/bash", "-c"]

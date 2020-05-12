FROM php:7.4-alpine
ENV PATH="${PATH}:/root/.composer/vendor/bin"
RUN apk add --no-cache openssh-client bash && mkdir -p ~/.ssh
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer global require laravel/envoy --no-plugins --no-scripts && composer clearcache

ENTRYPOINT ["/bin/bash", "-c"]

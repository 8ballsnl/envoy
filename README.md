# Deployment
Deployment helpers

## Features
* Laravel Envoy
* git

## Usage

Go to Gitlab > Project > Settings > Variables, and create a variable SSH_PRIVATE_KEY:
```
-----BEGIN RSA PRIVATE KEY-----
...
-----END RSA PRIVATE KEY-----
```

### Examples
#### GitLab CI / Laravel Envoy
```
image: robjuz/envoy

stages:
  - deploy

deploy_to_production:
  stage: deploy
  only:
    - master
  script: 
    - source /init-ssh
    - envoy run production
```

#### GitLab CI / Git
```
image: robjuz/envoy

stages:
  - deploy

deploy_to_production:
  stage: deploy
  only:
    - master
  script: 
    - source /init-ssh
    - git config --global user.email "${GITLAB_USER_EMAIL}"
    - git config --global user.name "${GITLAB_USER_NAME}"
    - git clone my_repo
    - co my_repo
    - git push origin master
```
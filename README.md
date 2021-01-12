# Deployment
Deployment helpers

## Features
* Laravel Envoy
* git
* rsync

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
    - eval $(ssh-agent)
    - ssh-add <(echo "$SSH_PRIVATE_KEY")
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
    - git config --global user.email "${GITLAB_USER_EMAIL}"
    - git config --global user.name "${GITLAB_USER_NAME}"
    - eval $(ssh-agent)
    - ssh-add <(echo "$SSH_PRIVATE_KEY")
    - git clone my_repo
    - co my_repo
    - git push origin master
```

#### GitLab CI / rsync + ssh

create project variables```DEPLOY_PATH``` in form ```user@host:/deploy_directory```

```
image: robjuz/envoy

stages:
  - deploy

deploy_to_production:
  stage: deploy
  only:
    - master
  script: 
    - eval $(ssh-agent)
    - ssh-add <(echo "$SSH_PRIVATE_KEY")
    - rsync -rav --omit-dir-times --no-o --no-g --no-perms -e ssh ./dist $DEPLOY_PATH
```

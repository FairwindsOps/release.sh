# release.sh
Release scripts for our repositories

### Adding Release.sh Support to Your Repository

* Add a [`GITHUB_ACCESS_TOKEN`](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) environment variable to the CircleCI build.

* Add environment variables mapping CircleCI variables to release variables

```
GITHUB_ORGANIZATION: $CIRCLE_PROJECT_USERNAME
GITHUB_REPOSITORY: $CIRCLE_PROJECT_REPONAME
```

* Add a deployment block to create the release

```
release:
  tag: /v.*/
  owner: reactiveops
  commands:
    - git fetch --tags
    - curl -O https://raw.githubusercontent.com/reactiveops/release.sh/v0.0.1/release.sh
    - /bin/bash release.sh

```

A full example would look like

```
machine:
  environment:
    GITHUB_ORGANIZATION: $CIRCLE_PROJECT_USERNAME
    GITHUB_REPOSITORY: $CIRCLE_PROJECT_REPONAME

deployment:
  release:
    tag: /v.*/
    owner: YOU!
    commands:
      - git fetch --tags
      - curl -O https://raw.githubusercontent.com/reactiveops/release.sh/v0.0.2/release
      - /bin/bash release
```


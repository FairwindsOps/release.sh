# release.sh
Release scripts for our repositories

### Adding Release.sh Support to Your Repository

* Add a [`GITHUB_ACCESS_TOKEN`](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) environment variable to the CircleCI build.

* Add environment variables mapping CircleCI variables to release variables

```
GITHUB_ORGANIZATION: $CIRCLE_PROJECT_USERNAME
GITHUB_REPOSITORY: $CIRCLE_PROJECT_REPONAME
```

* Add a this task to your Circle2.0 job block to create the release

```
release:
  - run:
      name: create release
      command: |
        git fetch --tags
        curl -O https://raw.githubusercontent.com/reactiveops/release.sh/v0.0.2/release
        /bin/bash release

```

An complete job would look like. This could be added to the `jobs:` section of your `.circleci/config.yml`

```
release:
  docker:
    - image: circleci/python:2
  environment:
    GITHUB_ORGANIZATION: $CIRCLE_PROJECT_USERNAME
    GITHUB_REPOSITORY: $CIRCLE_PROJECT_REPONAME
  steps:
    - checkout
    - run:
        name: create release
        command: |
          git fetch --tags
          curl -O https://raw.githubusercontent.com/reactiveops/release.sh/v0.0.2/release
          /bin/bash release
```

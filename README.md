# release.sh
Script to automatically create a `release` in your github repo from an annotated tag.

## Add Release.sh Support to Your Repository

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

A complete job would look like. This could be added to the `jobs:` section of your `.circleci/config.yml`

```
jobs:
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
workflows:
  version: 2
  release:
    jobs:
      - release:
          filters:
            tags:
              only: /.*/ #Run release step for any branch (or update pattern to match the tag)
            branches:
              ignore: /.*/ #Ignore all branches, never create release for a branch

```


## Kick off a release
* `git tag -a <tag>`
* Write annotation in editor
* `git push origin <tag>`

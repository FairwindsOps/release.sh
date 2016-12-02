#!/bin/bash

main() {
  declare desc="Creates a release for the last created tag on github"
  TAG_NAME="$(git describe --exact-match --candidates=0)"

  if [[ $? -ne 0 ]]; then
    echo "You must create an annotated tag for this commit with 'git tag -a <tagname>'"
    exit 1
  fi

  echo "Found tag: ${TAG_NAME}"

  SUBJECT="$(git show -s --format=%s)"
  MESSAGE="$(git show -s --format=%B | tail -n +2 )"

  DESCRIPTION="$MESSAGE"

  echo "Release name: ${SUBJECT}"
  echo "Release description: ${DESCRIPTION}"

  REQUEST_BODY="$(printf '{"tag_name": "%s", "name": "%s", "body": "%s", "draft": false, "prerelease": false}' "$TAG_NAME" "$SUBJECT" "$DESCRIPTION")"

  echo "$REQUEST_BODY"

  curl --data "${REQUEST_BODY}" "https://api.github.com/repos/${GITHUB_ORGANIZATION}/${GITHUB_REPOSITORY}/releases?access_token=${GITHUB_ACCESS_TOKEN}"
}

main "$@"

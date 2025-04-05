#!/bin/bash

# Stop on error
set -e

# Ensure we are on the latest version of the repo
git fetch --tags

# Get the latest tag, fallback to "v0.0.0" if no tags exist
LATEST_TAG=$(git tag --sort=-v:refname | head -n 1)
LATEST_TAG=${LATEST_TAG:-"v0.0.0"}

# Remove 'v' prefix
VERSION=${LATEST_TAG#v}

# Determine next version type (default: patch)
BUMP_TYPE=${1:-patch}

# Increment version
NEW_VERSION=$(npx semver "$VERSION" -i "$BUMP_TYPE")

# Check if the tag already exists
if git rev-parse "v$NEW_VERSION" >/dev/null 2>&1; then
    echo "Tag v$NEW_VERSION already exists. Skipping tagging."
    echo "v$NEW_VERSION"
    exit 0
fi

#0.0.6

# Update version file
echo "v$NEW_VERSION" > VERSION

# Commit and create tag
git add VERSION
git commit -m "Bumped version to v$NEW_VERSION"
git tag "v$NEW_VERSION"
git push origin "v$NEW_VERSION"

# Output only the new version
echo "v$NEW_VERSION"

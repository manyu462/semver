#!/bin/bash

# Stop on error
set -e

# Ensure we are on the latest version of the repo
git fetch --tags

# Get the latest tag, fallback to "v0.0.0" if no tags exist
LATEST_TAG=$(git tag --sort=-v:refname | tail -n 1)
LATEST_TAG=${LATEST_TAG:-"v0.0.0"}

# Remove 'v' prefix for version comparison
VERSION=${LATEST_TAG#v}

# Determine next version type (default: patch)
BUMP_TYPE=${1:-patch}

# Increment version using semver
NEW_VERSION=$(npx semver "$VERSION" -i "$BUMP_TYPE")

# Update the version file
echo "v$NEW_VERSION" > VERSION

# Commit the changes
git add VERSION
git commit -m "Bumped version to v$NEW_VERSION"

# Create and push the new tag
git tag "v$NEW_VERSION"
git push origin "v$NEW_VERSION"

# Output ONLY the new version (without extra text)
echo "v$NEW_VERSION"

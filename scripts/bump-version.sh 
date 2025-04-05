#!/bin/bash

# Ensure script stops on error
set -e

# Get latest tag, default to 0.0.0 if no tags exist
LATEST_TAG=$(git tag --sort=-v:refname | head -n 1)
LATEST_TAG=${LATEST_TAG:-"v0.0.0"}

# Remove 'v' prefix for version comparison
VERSION=${LATEST_TAG#v}

# Determine next version type (default: patch)
BUMP_TYPE=${1:-patch}

# Increment version using semver
NEW_VERSION=$(npx semver "$VERSION" -i "$BUMP_TYPE")

# Create and push the new tag
# git config --global user.name "github-actions[bot]"
# git config --global user.email "github-actions[bot]@users.noreply.github.com"
git tag "v$NEW_VERSION"
git push origin "v$NEW_VERSION"

# Output the new version
echo "Bumped version to v$NEW_VERSION"
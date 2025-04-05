#!/bin/bash

# Stop on error
set -e

# Ensure we are on the latest version of the repo
git fetch --tags

# Get the latest tag, fallback to "v0.0.0" if no tags exist
LATEST_TAG=$(git tag --sort=-v:refname | tail -n 1)
LATEST_TAG=${LATEST_TAG:-"v0.0.0"}

# Remove 'v' prefix for versioning
VERSION=${LATEST_TAG#v}

# Determine bump type (default: patch)
BUMP_TYPE=${1:-patch}

# Generate new version using semver
NEW_VERSION=$(npx semver "$VERSION" -i "$BUMP_TYPE")

# Ensure VERSION file exists
echo "$NEW_VERSION" > VERSION

# Commit changes
echo "🚀 Creating new version v$NEW_VERSION from $LATEST_TAG"
git add VERSION
echo "🚀 Bumping version to v$NEW_VERSION"
git commit -m "Bumped version to v$NEW_VERSION"

echo "🚀 Created tag v$NEW_VERSION"

# Create and push the tag
git tag "v$NEW_VERSION"
git push origin master --tags  # Ensure all tags are pushed

# Output the new version
echo "✅ Bumped version to v$NEW_VERSION"

echo "v$NEW_VERSION"



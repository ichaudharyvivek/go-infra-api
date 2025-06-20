#!/bin/bash

# Read the commit message
commit_message=$(cat "$1")

# Define allowed prefixes
allowed_prefixes=("feat" "fix" "docs" "style" "refactor" "perf" "test" "chore" "build" "ci" "revert" "bug" "hotfix" "release")

# Build regex pattern from allowed prefixes
prefix_pattern=$(IFS="|"; echo "${allowed_prefixes[*]}")

# Regex explanation:
# ^(prefix)(\(scope\))?: → prefix or prefix(scope)
# : → colon
# \s → exactly one space
# .+ → actual message
if [[ $commit_message =~ ^(${prefix_pattern})(\([a-zA-Z0-9_-]+\))?:\ .+ ]]; then
  echo "✅ Commit message format is valid"
  exit 0
fi

echo "❌ Invalid commit message format"
echo "Use: <prefix>: <message> or <prefix>(scope): <message>"
echo "Prefix eg.: feat, fix, chore etc.."
exit 1

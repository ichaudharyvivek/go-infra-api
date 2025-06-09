#!/bin/bash

# Read the commit message
commit_message=$(cat $1)

# Define allowed prefixes
allowed_prefixes=("feat" "fix" "docs" "style" "refactor" "perf" "test" "chore" "build" "ci" "revert" "bug" "hotfix" "release")

# Check if commit message starts with allowed prefix
for prefix in "${allowed_prefixes[@]}"; do
	if [[ $commit_message =~ ^$prefix:.+ ]]; then
		echo "✅ Commit message format is valid"
		exit 0
	fi
done

echo "❌ Invalid commit message format"
echo "Use: <prefix>: <commit_message>"
echo "Prefix eg.: feat, fix, chore etc.."
exit 1

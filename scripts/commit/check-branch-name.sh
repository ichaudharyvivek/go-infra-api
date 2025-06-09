#!/bin/bash

# Get current branch name
branch=$(git rev-parse --abbrev-ref HEAD)

# Define allowed branch patterns
allowed_patterns=(
	"^main$" "^dev$" "^master$"
	"^release/.*" "^hotfix/.*"
	"^feature/.*" "^bugfix/.*" "^fix/.*"
	"^chore/.*" "^docs/.*" "^test/.*"
	"^refactor/.*" "^style/.*" "^perf/.*" "^ci/.*"
)

# Check if branch matches any allowed pattern
for pattern in "${allowed_patterns[@]}"; do
	if [[ $branch =~ $pattern ]]; then
		echo "✅ Branch name is valid: $branch"
		exit 0
	fi
done

echo "❌ Invalid branch name: $branch"
echo "Use: feature/*, bugfix/*, chore/*, etc."
exit 1

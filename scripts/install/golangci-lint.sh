#!/bin/bash
# This script downloads golangci-lint tool

# Set version to install (can be updated as needed)
GOLANGCI_LINT_VERSION="v1.59.1"

# Check if golangci-lint is already installed
if command -v golangci-lint >/dev/null 2>&1; then
    echo "✅ golangci-lint is already installed"
    exit 0
fi

echo "📦 Installing golangci-lint ${GOLANGCI_LINT_VERSION}..."

# Detect OS and ARCH
OS="$(uname -s)"
ARCH="$(uname -m)"

# Normalize ARCH
case "$ARCH" in
x86_64) ARCH="amd64" ;;
arm64 | aarch64) ARCH="arm64" ;;
*)
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

# OS-specific installation
case "$OS" in
Darwin)
    echo "🍎 Detected macOS - using Homebrew"
    if ! command -v brew >/dev/null 2>&1; then
        echo "❌ Homebrew not found. Please install Homebrew first: https://brew.sh"
        exit 1
    fi
    brew install golangci-lint
    ;;

Linux)
    echo "🐧 Detected Linux - downloading binary directly"
    URL="https://github.com/golangci/golangci-lint/releases/download/${GOLANGCI_LINT_VERSION}/golangci-lint-${GOLANGCI_LINT_VERSION}-linux-${ARCH}.tar.gz"

    curl -sSfL "$URL" -o golangci-lint.tar.gz
    tar -xzf golangci-lint.tar.gz
    sudo mv golangci-lint-${GOLANGCI_LINT_VERSION}-linux-${ARCH}/golangci-lint /usr/local/bin/
    rm -rf golangci-lint.tar.gz golangci-lint-${GOLANGCI_LINT_VERSION}-linux-${ARCH}
    ;;

*)
    echo "❌ Unsupported operating system: $OS"
    exit 1
    ;;
esac

#!/bin/bash
# This script downloads lefthook tool

# Check if lefthook is already installed
if command -v lefthook >/dev/null 2>&1; then
    echo "✅ lefthook is already installed"
    exit 0
fi

echo "📦 Installing lefthook..."

# Detect OS
OS="$(uname -s)"

case "$OS" in
Darwin)
    echo "🍎 Detected macOS - using Homebrew"
    if ! command -v brew >/dev/null 2>&1; then
        echo "❌ Homebrew not found. Please install Homebrew first: https://brew.sh"
        exit 1
    fi
    brew install lefthook
    ;;

Linux)
    echo "🐧 Detected Linux - using package manager"
    if command -v apt >/dev/null 2>&1; then
        curl -1sLf 'https://dl.cloudsmith.io/public/evilmartians/lefthook/setup.deb.sh' | sudo -E bash
        sudo apt install lefthook
    elif command -v yum >/dev/null 2>&1; then
        curl -1sLf 'https://dl.cloudsmith.io/public/evilmartians/lefthook/setup.rpm.sh' | sudo -E bash
        sudo yum install lefthook
    else
        echo "❌ Unsupported Linux distribution"
        echo "Please install manually: https://github.com/evilmartians/lefthook#installation"
        exit 1
    fi
    ;;

*)
    echo "❌ Unsupported operating system: $OS"
    echo "Please install manually: https://github.com/evilmartians/lefthook#installation"
    exit 1
    ;;
esac

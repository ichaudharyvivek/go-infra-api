#!/bin/bash
# This script downloads the Task binary (https://taskfile.dev)

# Set version to install
TASK_VERSION="v3.37.2"

# Check if task is already installed
if command -v task >/dev/null 2>&1; then
    echo "✅ task is already installed"
    exit 0
fi

echo "📦 Installing task ${TASK_VERSION}..."

# Detect OS and ARCH
OS="$(uname -s)"
ARCH="$(uname -m)"

# Normalize OS
case "$OS" in
Linux) OS="linux" ;;
Darwin) OS="darwin" ;;
*)
    echo "❌ Unsupported operating system: $OS"
    exit 1
    ;;
esac

# Normalize ARCH
case "$ARCH" in
x86_64) ARCH="amd64" ;;
arm64 | aarch64) ARCH="arm64" ;;
*)
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

# Construct download URL
URL="https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_${OS}_${ARCH}.tar.gz"

# Download and install
curl -sSfL "$URL" -o task.tar.gz
tar -xzf task.tar.gz task
chmod +x task
sudo mv task /usr/local/bin/
rm -f task.tar.gz

echo "✅ task ${TASK_VERSION} installed successfully!"

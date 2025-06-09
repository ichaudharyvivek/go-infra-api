.PHONY: setup
setup:
	@echo "-- Setting up development environment --"

	@chmod +x scripts/install/lefthook.sh
	@./scripts/install/lefthook.sh

	@chmod +x scripts/install/golangci-lint.sh
	@./scripts/install/golangci-lint.sh

	@chmod +x scripts/commit/*.sh
	@lefthook install

	@echo "-- Setup complete! --"

.PHONY: build
build:
	go build -o bin/api ./cmd/api
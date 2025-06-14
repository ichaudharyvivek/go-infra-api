# ------------------------------------------------
# Build stage
# ------------------------------------------------
FROM golang:1.24-alpine AS builder

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache git ca-certificates tzdata

# Cache dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy full source
COPY . .

# Build statically linked binary
RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o main .

# ------------------------------------------------
# Development stage
# ------------------------------------------------
FROM golang:1.24-alpine AS development

WORKDIR /app

# Install dev tools
RUN apk add --no-cache git ca-certificates tzdata \
  && go install github.com/air-verse/air@latest

COPY go.mod go.sum ./
RUN go mod download

COPY . .

EXPOSE 8080

CMD ["air", "-c", ".air.toml"]

# ------------------------------------------------
# Production stage
# ------------------------------------------------
FROM alpine:latest AS production

# Install runtime dependencies
RUN apk add --no-cache ca-certificates tzdata

WORKDIR /

# Copy timezone and certs
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Copy binary
COPY --from=builder /app/main /main

EXPOSE 8080

ENTRYPOINT ["/main"]

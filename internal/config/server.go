package config

import (
	"time"

	"github.com/joeshaw/envdecode"
)

type ConfServer struct {
	Port         int           `env:"SERVER_PORT" default:"3000"`
	TimeoutRead  time.Duration `env:"SERVER_TIMEOUT_READ" default:"5s"`
	TimeoutWrite time.Duration `env:"SERVER_TIMEOUT_WRITE" default:"10s"`
	TimeoutIdle  time.Duration `env:"SERVER_TIMEOUT_IDLE" default:"120s"`
	Debug        bool          `env:"SERVER_DEBUG" default:"false"`
}

func NewConfServer() *ConfServer {
	var cfg ConfServer
	if err := envdecode.StrictDecode(&cfg); err != nil {
		panic("Failed to load server config: " + err.Error())
	}

	return &cfg
}

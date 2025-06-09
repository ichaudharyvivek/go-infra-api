package main

import (
	"fmt"
	"log"
	"net/http"
	"saas-api/internal/config"
	"saas-api/internal/router"
)

func main() {
	c := config.New()
	r := router.NewRouter()
	s := &http.Server{
		Addr:         fmt.Sprintf(":%d", c.Server.Port),
		Handler:      r,
		ReadTimeout:  c.Server.TimeoutRead,
		WriteTimeout: c.Server.TimeoutWrite,
		IdleTimeout:  c.Server.TimeoutIdle,
	}

	log.Println("Starting server at port" + s.Addr)
	if err := s.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		log.Fatal("Server startup failed!!")
	}
}

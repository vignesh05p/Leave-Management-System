package main

import (
	"log"
	"os"

	"leave-management/config"
	"leave-management/routes"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {
	// Load env
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	// Connect DB
	config.ConnectDB()

	// Init Gin
	r := gin.Default()

	// Register Routes
	routes.RegisterRoutes(r)

	// Start server
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	r.Run(":" + port)
}

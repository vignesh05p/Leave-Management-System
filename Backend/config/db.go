package config

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/joho/godotenv"
)

var DB *pgxpool.Pool

func ConnectDB() {
	// Load environment variables
	_ = godotenv.Load()

	dbURL := os.Getenv("DB_URL")
	if dbURL == "" {
		log.Fatal("❌ DB_URL is not set in environment")
	}

	// Parse DB config
	cfg, err := pgxpool.ParseConfig(dbURL)
	if err != nil {
		log.Fatal("❌ Unable to parse database config:", err)
	}

	// ✅ BeforeConnect hook (no PreferSimpleProtocol in pgx v5)
	cfg.BeforeConnect = func(ctx context.Context, cc *pgx.ConnConfig) error {
		// No PreferSimpleProtocol in pgx v5
		return nil
	}

	// Create connection pool
	DB, err = pgxpool.NewWithConfig(context.Background(), cfg)
	if err != nil {
		log.Fatal("❌ Unable to create DB pool:", err)
	}

	// Test connection
	err = DB.Ping(context.Background())
	if err != nil {
		log.Fatal("❌ Database ping failed:", err)
	}

	fmt.Println("✅ Connected to Database!")
}

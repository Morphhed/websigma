package main

import (
	"database/sql"
	"log"

	_ "github.com/lib/pq"
	"github.com/skibidi/sigma/api"
	db "github.com/skibidi/sigma/db/sqlc"
	"github.com/skibidi/sigma/util"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("ga bisa munculin config", err)
	}
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("ga bisa nyambung ke DB", err)
	}

	store := db.NewStore(conn)
	server, err := api.NewServer(config, store)
	if err != nil {
		log.Fatal("cant create server")
	}

	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("server Ga bisa start blog", err)
	}
}

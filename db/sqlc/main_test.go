package sqlc

import (
	"database/sql"
	"os"
	"testing"
	"log"
	
	_ "github.com/lib/pq"
)

var testQueries *Queries
var conn *sql.DB
var (
	Dbsource = "postgresql://admin:admin@localhost:5432/booking?sslmode=disable"
	Dbdrive  = "postgres"
	
)

func TestMain(t *testing.M) {
  var err error 
	conn, err = sql.Open(Dbdrive, Dbsource)
	if err != nil {
		log.Fatal("Cannot connect database: ", err)

	}

	testQueries = New(conn)

	os.Exit(t.Run())
}

package main

import (
	"context"
	"encoding/csv"
	"errors"
	"fmt"
	"io"
	"os"
	"path"
	"time"

	"github.com/jackc/pgx/v4"
)

func main() {
	conn, err := newConn()
	if err != nil {
		fmt.Println("newDB", err)
		return
	}

	defer func() {
		_ = conn.Close(context.Background())
		fmt.Println("closed")
	}()

	now := time.Now()

	if err := insertsUsers(conn); err != nil {
		fmt.Println("failed", err)
		return
	}

	fmt.Println("total", time.Since(now))
}

func insertsUsers(conn *pgx.Conn) error {
	f, err := os.Open(path.Join("..", "airport"))
	if err != nil {
		return fmt.Errorf("os.Open %w", err)
	}

	cr := csv.NewReader(f)

	if err := conn.BeginTxFunc(context.Background(), pgx.TxOptions{}, func(tx pgx.Tx) error {
		for {
			record, err := cr.Read()
			if errors.Is(err, io.EOF) {
				break
			}

			if err != nil {
				return fmt.Errorf("cr.Read %w", err)
			}
			// 			`INSERT INTO airports(
			// iata_code,
			// icao_code,
			// name,
			// elevation,
			// city,
			// country,
			// state,
			// lat,
			// lon,
			// timezone
			// ) VALUES
			// (  $1 , $2 , $3 , $4, $5, $6, $7, $8, $9, $10
			// )`
			_, err = conn.Exec(context.Background(), "INSERT INTO airports(id,iata_code,icao_code,name,country,state,city,elevation,lat,lon,timezone) VALUES($1, $2, $3,$4,$5,$6,$7,$8,$9,$10,$11)", record[0], record[1], record[2], record[3], record[4], record[5], record[6], record[7], record[8], record[9], record[10])
			if err != nil {
				return fmt.Errorf("conn.Exec %w", err)
			}
		}

		return nil
	}); err != nil {
		return fmt.Errorf("conn.BeginTxFunc %w", err)
	}

	return nil
}

func newConn() (*pgx.Conn, error) {
	// dsn := url.URL{
	// 	Scheme: "postgres",
	// 	Host:   "localhost:5432",
	// 	User:   url.UserPassword("user", "password"),
	// 	Path:   "dbname",
	// }
	//
	// q := dsn.Query()
	// q.Add("sslmode", "disable")
	//
	// dsn.RawQuery = q.Encode()
	//
	conn, err := pgx.Connect(context.Background(), "postgresql://admin:admin@localhost:5432/flight?sslmode=disable")
	if err != nil {
		return nil, fmt.Errorf("pgx.Connect%w", err)
	}

	return conn, nil
}

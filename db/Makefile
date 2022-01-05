clean:
	rm -f pb/*.go
gen:
	protoc --proto_path=proto proto/*.proto  --go_out=:. --go-grpc_out=:.
test:
	go test -cover ./...
createdb:
	createdb --username=admin --owner=admin booking
dropdb:
	dropdb booking
migrateup:
	migrate -path migration -database "postgresql://admin:admin@localhost:5432/booking?sslmode=disable" -verbose up
migratedown:
	migrate -path migration -database "postgresql://admin:admin@localhost:5432/booking?sslmode=disable" -verbose down
sqlc:
	sqlc generate

.PHONY: clean gen test createdb dropdb migrateup migratedown sqlc
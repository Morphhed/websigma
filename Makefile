.PHONY: postgres createdb dropdb migratedown sqlc test server mock migrateupuser migratedownuser migrateup

postgres:
	docker run --name sigmasigma -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres

createdb:
	docker exec -it sigmasigma createdb --username=root --owner=root sigma
	migrate -path ./db/migration -database "postgresql://root:secret@localhost:5432/sigma?sslmode=disable" -verbose up

dropdb:
	docker exec -it sigmasigma dropdb --username=root sigma

migratedown:
	migrate -path ./db/migration -database "postgresql://root:secret@localhost:5432/sigma?sslmode=disable" -verbose down

migratedownuser:
	migrate -path ./db/migration -database "postgresql://root:secret@localhost:5432/sigma?sslmode=disable" -verbose down 1

migrateup:
	migrate -path ./db/migration -database "postgresql://root:secret@localhost:5432/sigma?sslmode=disable" -verbose up

migrateupuser:
	migrate -path ./db/migration -database "postgresql://root:secret@localhost:5432/sigma?sslmode=disable" -verbose up 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/skibidi/sigma/db/sqlc Store

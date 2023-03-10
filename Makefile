postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=hojin -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

deletedb:
	docker exec -it postgres12 dropdb simple_bank

migrateup:
	migrate --path db/migration -database "postgresql://root:hojin@localhost:5432/simple_bank?sslmode=disable" -verbose up 

migratedown:
	migrate --path db/migration -database "postgresql://root:hojin@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -timeout 30s -v -cover ./...

.PHONY: postgres createdb deletedb migrateup migratedown sqlc
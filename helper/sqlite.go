package helper

import (
	"database/sql"

	// sqlite3 driver
	_ "github.com/mattn/go-sqlite3"
)

// SQLite3 db
var SQLite3 *sql.DB

func init() {
	/* init sqlite3 */
	var err error
	SQLite3, err = sql.Open("sqlite3", "./config.db")
	if err != nil {
		panic(err)
	}
	SQLite3.SetMaxOpenConns(10)

	sqlStmt := `
	create table if not exists config_tasks (
		id TEXT NOT NULL UNIQUE,
		PRIMARY KEY(id)
	);`

	_, err = SQLite3.Exec(sqlStmt)
	if err != nil {
		panic(err)
	}

}

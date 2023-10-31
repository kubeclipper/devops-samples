package main

import (
	"fmt"
	"hello-go/handler"
	"net/http"
)

func main() {
	http.HandleFunc("/", handler.Hello)

	port := 8080
	addr := fmt.Sprintf(":%d", port)

	fmt.Printf("Server is running on port %d...\n", port)
	err := http.ListenAndServe(addr, nil)
	if err != nil {
		fmt.Println(err)
	}
}

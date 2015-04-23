package main

import (
    "fmt"
    "net/http"
    "strings"
    "log"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, r.RemoteAddr[:strings.Index(r.RemoteAddr, ":")])
}

func main() {
    http.HandleFunc("/", handler)
    log.Fatal(http.ListenAndServe(":80", nil))
}

package main

import (
    "fmt"
    "io/ioutil"
    "net/http"
    // "net/url"
)

func main() {
    resp, err := http.Get("https://api.github.com/repos/conao3/playground/releases/latest")

    if err != nil {
        fmt.Println(err)
        return
    }

    defer resp.Body.Close()

    execute(resp)
}

func execute(response *http.Response) {
    body, err := ioutil.ReadAll(response.Body)
    if err != nil {
        fmt.Println(err)
        return
    }
    fmt.Println(string(body))
}

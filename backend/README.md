# Go backend

Simple Go backend that broadcasts incoming messages to all connected clients using Websockets. Also, persists the last 1000 messages in Redis and exposes a json API to retrieve it.

Strongly inspired by [Gorilla websocket example](https://github.com/gorilla/websocket/tree/master/examples/chat)

## Environment Variables

You must setup these env vars to correctly build and run the backend:

- `ALLOWED_ORIGIN`: allows requests from this origin. Ex: `http://localhost:3000`
- `REDIS_ADDR`: connection string to Redis. Ex: `localhost:6379`

## Build

Inside `backend` directory:

```bash
go get ./...
go build .
```

## Usage

```bash
./backend --help

Usage of ./backend:
  -addr string
    http service address (default ":8080")
```

## Run

```bash
ALLOWED_ORIGIN='http://localhost:3000' REDIS_ADDR=localhost:6379 ./backend
```

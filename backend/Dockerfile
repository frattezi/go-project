
FROM golang:alpine

RUN apk update && apk add --no-cache git ca-certificates && update-ca-certificates

WORKDIR /
COPY . .
RUN go get -d . && go build .

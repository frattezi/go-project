# SRC https://medium.com/@chemidy/create-the-smallest-and-secured-golang-docker-image-based-on-scratch-4752223b7324

############################
# This multi-stage-image looks great
############################

FROM golang:alpine AS builder

# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git
WORKDIR $GOPATH/src/backend/
COPY . .

# Fetch dependencies.
RUN go get -d -v

# Build the binary.
RUN go build -o /go/bin/hello

############################
# Copy the binaries and go!
############################
FROM scratch

# Copy our static executable.
COPY --from=builder /go/bin/hello /go/bin/hello


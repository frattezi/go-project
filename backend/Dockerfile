FROM golang:alpine

ENV ALLOWED_ORIGIN=http://localhost:3000
ENV REDIS_ADDR=redis:6379

RUN apk update && apk add --no-cache git ca-certificates && update-ca-certificates

RUN mkdir /backend
WORKDIR /backend

COPY . .
RUN go get -d . && go build .

CMD [ "/backend/backend" ]
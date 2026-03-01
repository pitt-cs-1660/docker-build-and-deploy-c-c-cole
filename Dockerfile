FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod .
COPY main.go .
COPY templates ./templates 

RUN CGO_ENABLED=0 go build -o app .

FROM scratch

WORKDIR /app

COPY --from=builder /app/app /app/app
COPY --from=builder /app/templates /app/templates

EXPOSE 8080

CMD ["/app/app"]
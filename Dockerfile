FROM golang as builder

RUN go get -d -v github.com/gopherjs/gopherjs.github.io/playground

WORKDIR /go/src/github.com/gopherjs/gopherjs.github.io/playground

RUN CGO_ENABLED=0 GOOS=linux go generate .

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR gopherjs

ENV PATH=$PATH:/gopherjs

EXPOSE 8080

COPY --from=builder /go/src/github.com/gopherjs/gopherjs.github.io/playground    .

ENTRYPOINT [ "gopherjs serve" ] 

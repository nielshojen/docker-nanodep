FROM golang:alpine as builder

RUN apk add --no-cache make git
RUN git clone https://github.com/micromdm/nanodep.git /go/src/github.com/micromdm/nanodep

WORKDIR /go/src/github.com/micromdm/nanodep

ENV CGO_ENABLED=0 \
	GOARCH=amd64 \
	GOOS=linux

RUN make

FROM alpine

VOLUME "/db"

RUN apk --update add ca-certificates
COPY --from=builder /go/src/github.com/micromdm/nanodep/depserver-linux-amd64 /usr/local/bin/depserver
COPY --from=builder /go/src/github.com/micromdm/nanodep/depsyncer-linux-amd64 /usr/local/bin/depsyncer
RUN chmod a+x /usr/local/bin/depserver
RUN chmod a+x /usr/local/bin/depsyncer

COPY docker-entrypoint.d /docker-entrypoint.d
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.d/*.sh
RUN chmod a+x /docker-entrypoint.sh

EXPOSE 9001

ENTRYPOINT ["/docker-entrypoint.sh"]
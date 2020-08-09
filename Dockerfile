############################
# STEP 1 build executable binary
############################
FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git postgresql-client
RUN go get github.com/kr/s3/s3cp
ADD backup.sh /backup.sh
RUN chmod +x /backup.sh
CMD ["/backup.sh"]


FROM alpine as builder

WORKDIR /

RUN apk update
RUN apk add git
RUN apk add hugo
RUN git clone https://github.com/chazapis/hy548
RUN cd hy548; git submodule init; git submodule update;
RUN cd /hy548/html/; hugo -D

FROM nginx:1.23.3-alpine

COPY --from=builder /hy548/html/public/index.html /usr/share/nginx/html/


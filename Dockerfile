FROM alpine:latest AS build
WORKDIR /app

RUN apk update && \
        apk upgrade && \
        apk add --no-cache alpine-sdk linux-headers git zlib-dev openssl-dev gperf cmake

RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git

RUN rm -rf /app/telegram-bot-api/build && \
        mkdir /app/telegram-bot-api/build && \
        cd /app/telegram-bot-api/build && \
        cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/app/telegram-bot-api .. && \
        cmake --build /app/telegram-bot-api/build/ --target install

FROM alpine:latest AS runtime
WORKDIR /app

ARG API_ID
ARG API_HASH
ENV API_ID=${API_ID}
ENV API_HASH=${API_HASH}

RUN echo ${API_ID}
RUN echo ${API_HASH}

RUN apk update && \
        apk upgrade && \
        apk add --no-cache alpine-sdk linux-headers git zlib-dev openssl-dev gperf cmake

COPY --from=build /app/telegram-bot-api/bin/telegram-bot-api /app/telegram-bot-api

EXPOSE 8081

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/app/telegram-bot-api --api-id=$API_ID --api-hash=$API_HASH --local"]

FROM alpine:3.20

RUN apk update && apk upgrade && \
    apk add --no-cache git openssh git-lfs git-subtree uuidgen

RUN git lfs install

COPY setup-ssh.sh /setup-ssh.sh
COPY mirror.sh /mirror.sh
COPY cleanup.sh /cleanup.sh

ENTRYPOINT ["/mirror.sh"]

FROM alpine:3.17

ARG TARGETARCH=amd64
ARG VERSION=1.38.4

RUN \
  apk add --no-cache iptables iproute2 ca-certificates bash \
  && apk add --no-cache curl tar nano htop \
  && curl -sL "https://pkgs.tailscale.com/stable/tailscale_${VERSION}_${TARGETARCH}.tgz" \
  | tar -zxf - -C /usr/local/bin --strip=1 tailscale_${VERSION}_${TARGETARCH}/tailscaled tailscale_${VERSION}_${TARGETARCH}/tailscale

COPY entrypoint /usr/local/bin/entrypoint

ENTRYPOINT ["/usr/local/bin/entrypoint"]

FROM alpine:3.14

ENV workers 10

# Install dante-server, sockd user will be created
RUN apk add --no-cache curl linux-pam dumb-init dante-server
# Default configuration
COPY sockd.conf /etc/

EXPOSE 1080

HEALTHCHECK --retries=1 --start-period=1m --timeout=5s CMD curl -f https://ipinfo.io || exit 1

ENTRYPOINT ["dumb-init"]
CMD ["sh", "-c", "sockd -N ${workers}"]

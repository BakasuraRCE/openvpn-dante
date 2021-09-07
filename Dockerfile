FROM alpine:3.14

ENV workers 10

# Install Dante
RUN apk add --no-cache curl linux-pam dumb-init dante
# Add an unprivileged user.
RUN adduser -S -D -u 8062 -H sockd
# Default configuration
COPY sockd.conf /etc/

EXPOSE 1080

HEALTHCHECK --start-period=1m --timeout=5s CMD curl -f https://ipinfo.io || exit 1

ENTRYPOINT ["dumb-init"]
CMD ["sh", "-c", "sockd -N ${workers}"]

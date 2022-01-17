FROM dperson/openvpn-client

# Install dante-server, sockd user will be created
RUN apk add --no-cache curl linux-pam dumb-init dante-server
# Default configuration
COPY sockd.conf /etc/
ADD bootstrap.sh /

EXPOSE 1080

HEALTHCHECK --retries=3 --start-period=1m --timeout=5s CMD curl -x socks5h://localhost:1080 -f https://api.ipify.org || exit 1

RUN chmod +x /bootstrap.sh

ENTRYPOINT ["dumb-init"]
CMD ["/bootstrap.sh"]
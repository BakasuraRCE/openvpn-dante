Supported tags and respective `Dockerfile` links
================================================

  * [`latest` (Dockerfile)](https://github.com/BakasuraRCE/docker-dante/blob/master/Dockerfile) [![](https://images.microbadger.com/badges/image/bakasura/dante2.svg)](https://microbadger.com/images/bakasura/dante2 "Get your own image badge on microbadger.com")


What is Dante
-------------

[**Dante**](http://www.inet.no/dante/index.html) consists of a SOCKS server and a SOCKS client, implementing RFC 1928 and related standards. It can in most cases be made transparent to clients, providing functionality somewhat similar to what could be described as a non-transparent Layer 4 router. For customers interested in controlling and monitoring access in or out of their network, the Dante SOCKS server can provide several benefits, including security and TCP/IP termination (no direct contact between hosts inside and outside of the customer network), resource control (bandwidth, sessions), logging (host information, data transferred), and authentication.


Usage example
-------------

    $ docker run -e workers=20 -d -p 1080:1080 bakasura/dante2

Change its configuration by mounting a custom `/etc/sockd.conf`
(see [sample config files](http://www.inet.no/dante/doc/latest/config/server.html)).


### Change number of threads listening

Use the environment variable `workers` to set the number of threads listening for connections(by default are 10)


### Client-side set up

Set your browser or application to use SOCKS v4 or v5 proxy `localhost` on port 1080,
like for example:

    $ curl --proxy socks5://localhost:1080 https://example.com

... or set to use PAC script like:

    function FindProxyForURL(url, host) {
      return "SOCKS localhost:1080";
    }


### Requiring authentication

The default config in this image allows everyone to use the proxy. You can add a simple authentication (which will send data unencrypted) by setting up a `Dockerfile` like:

    FROM bakasura/dante2

    # TODO: Replace 'john' and 'MyPassword' by any username/password you want.
    RUN printf 'MyPassword\nMyPassword\n' | adduser john

Uncomment line in `sockd.conf`:

    socksmethod: username

Then use SOCKS v5, for example:

    $ curl --proxy socks5://john:MyPassword@localhost:1080 https://example.com

Note: SOCKS v4 will be blocked.

WARNING: Many browsers do **not** support SOCKS authentication (e.g. see this [Chrome bug](https://bugs.chromium.org/p/chromium/issues/detail?id=256785)).


Feedbacks
---------

Suggestions are welcome on our [GitHub issue tracker](https://github.com/BakasuraRCE/docker-dante/issues).

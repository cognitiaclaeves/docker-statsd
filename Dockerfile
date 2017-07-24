# Originally taken from Johannes Mitlmeier's dockerfile [jojomi/stats]
# with the addition of version locking etsy/statsd releases
FROM debian:latest

MAINTAINER Oded Messer <odedm@iguaz.io>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get --yes update && \
    apt-get --yes dist-upgrade

RUN apt-get --yes install gnupg curl && \
    curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
    apt-get --yes install nodejs && \
    apt-get --yes purge curl


# apt-get --yes install nodejs=0.10.48-1nodesource1~jessie1 && \

ADD https://github.com/etsy/statsd/archive/v0.8.0.tar.gz /tmp/statsd.tar.gz

# This may be different for docker-ce:
# RUN mkdir -p /src/statsd && tar -xzvf /tmp/statsd.tar.gz --strip-components=1 -C /src/statsd && \
#    rm -rf /tmp/statsd.tar.gz

RUN mkdir /src && mv /tmp/statsd.tar.gz/statsd-0.8.0/ /src/statsd && rm -rf /tmp/statsd.tar.gz

COPY config.js /etc/statsd/config.js

EXPOSE 8125/udp
EXPOSE 8126

RUN apt-get --yes install inetutils-ping telnet curl

CMD ["node", "/src/statsd/stats.js", "/etc/statsd/config.js"]

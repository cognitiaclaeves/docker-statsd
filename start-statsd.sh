sudo docker run -it --rm --name statsd -p 8126:8126 -p 8125:8125/udp -v`pwd`/config.js:/etc/statsd/config.js:z --link carbon:carbon omesser-statsd:4-dbg

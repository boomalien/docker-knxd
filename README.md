# docker-knxd
multi arch docker container with knxd

you need to start the contsiner with --net=host otherwise the knxd process is not able to connect to an knx tunneling interface.
Moreover you have to mount a config file to /config/knxd.ini
Example: -v /my_path/knxd.ini:/config/knxd.ini 

exposed ports:
- 6720 tcp
- 3671 udp

### run command
docker run -d \
  --name knxd \
  --net=host \
  -v /smartHome/applications/knxd/knxd.ini:/config/knxd.ini \
  boomalien/docker-knxd
  

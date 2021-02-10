# docker-knxd
multi arch docker container with knxd

## run command
docker run --name docker-knxd --net=host -d -v /smartHome/applications/knxd/knxd.ini:/config/knxd.ini boomalien/docker-knxd

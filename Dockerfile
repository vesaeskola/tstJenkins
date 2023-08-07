# Dockerfile for creating docker image for node.js server
# Creates Yocto Project build environment and builds RCPSW SW image
#
# In short, the above Dockerfile instructs Docker to do the following:
#
#  - Use the node:7-onbuild image as the base for our image
#  - Set a label with the maintainer (not required, but good practice)
#  - Set a health check for the container (for Docker to be able to tell if the server is actually up or not)
#  - Tell Docker which port our server runs on
#
#  Additionally, our image inherits the following actions from the official node onbuild image:
#
#  - Copy all files in the current directory to /usr/src/app inside the image
#  - Run npm install to install any dependencies for app (if we had any)
#  - Specify npm start as the command Docker runs when the container starts
#
#
# Usage:
#
# 1) Create image:
#    $ docker build -t hello_web_server:1.0 --build-arg GITUSERNAME="Vesa Eskola" --build-arg GITUSEREMAIL="vesa.m.eskola@gmail.com" --build-arg USERNAME="veskola" --tag hello_web_server .
#
# 2) Generate and run container:
#  - Open port 8000 for container
#  - bind folders: /home/vesaeskola/work2, ${SSH_AUTH_SOCK} (/run/user/1000/keyring/ssh)
#  - set environment variables: SSH_AUTH_SOCK=/ssh.socket
#
#    $ docker run -it --rm -p 8000:8000 -v /home/vesaeskola/work2:/work2 -v ${SSH_AUTH_SOCK}:/ssh.socket -e SSH_AUTH_SOCK=/ssh.socket hello_web_server
#
# 3) Test web server:
#    $ curl http://127.0.0.1:8000
#
# Source: https://tutorials.releaseworksacademy.com/learn/building-your-first-docker-image-with-jenkins-2-guide-for-developers
#


# use a node base image
FROM node:7-onbuild

# set maintainer
LABEL maintainer "vesa.m.eskola@gmail.com"

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:8000 || exit 1

# tell docker what port to expose
EXPOSE 8000

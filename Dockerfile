# Jammy is 22.04
FROM ubuntu:jammy

LABEL maintainer="Steve Chin <schin8@bu.edu>"

RUN apt-get update && \
    apt-get install -y sudo curl git-core gnupg \
    locales zsh wget nano jq &&\
    locale-gen en_US.UTF-8 && \
    adduser --quiet --disabled-password \
    --shell /bin/zsh --home /home/devuser \ 
    --gecos "User" devuser && \
    echo "devuser:p@ssword1" | \
    chpasswd &&  usermod -aG sudo devuser
USER devuser
ENV TERM xterm
WORKDIR /home/devuser
CMD ["zsh"]
    
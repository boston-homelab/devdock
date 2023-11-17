# Jammy is 22.04
FROM ubuntu:jammy

# These are only available during build
# Set environment variables with --build-arg during Build, default values provided
ARG user=pi
ARG password=raspberry

# These are available during build and when the container is running.  
ENV env_username=$user

LABEL maintainer="Steve Chin <schin8@bu.edu>"

RUN apt-get update && \
    apt-get install -y sudo curl git-core gnupg \
    locales zsh wget nano jq && \
    locale-gen en_US.UTF-8 && \ 
    adduser --quiet --disabled-password \
    --shell /bin/zsh --home /home/${user} \ 
    --gecos "User" ${user} && \ 
    echo "${user}:${password}" | \
    chpasswd &&  usermod -aG sudo ${user}
    
USER ${user}
ENV TERM xterm
WORKDIR /home/${user}
CMD ["zsh"]
    
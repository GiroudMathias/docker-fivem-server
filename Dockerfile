FROM ubuntu

MAINTAINER ich777

RUN apt-get update
RUN apt-get -y install wget xz-utils unzip screen

ENV DATA_DIR="/serverdata"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_CONFIG="template"
ENV SRV_ADR="https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/"
ENV MANUAL_UPDATES=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV SERVER_KEY="template"
ENV START_VARS="template"

RUN mkdir $DATA_DIR
RUN mkdir $SERVER_DIR
RUN useradd -d $SERVER_DIR -s /bin/bash --uid $UID --gid $GID fivem
RUN chown -R fivem $DATA_DIR

RUN ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/
RUN chown -R fivem /opt/scripts

USER fivem

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]

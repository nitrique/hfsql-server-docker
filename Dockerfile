FROM debian:jessie-slim

ENV HFSQL_VERSION 22.0.036.c

# import public key "PCSOFT <network@pcsoft.fr>"
RUN apt-key adv --keyserver hkp://pgp.mit.edu/ --recv-keys 3a2b08fb11ba9bca

RUN echo "deb http://package.windev.com/fr/debian/ debian main" > /etc/apt/sources.list.d/pcsoft.list

RUN apt-get update && apt-get install --no-install-recommends -y libqt4-gui hfsql="${HFSQL_VERSION}" && rm -rf /var/lib/apt/lists/* && apt-get autoremove -y

VOLUME /var/lib/hfsql
EXPOSE 4900
EXPOSE 4999

USER hfsql

CMD ["/opt/hfsql/manta64","--no-daemon"]

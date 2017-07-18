FROM debian:jessie-slim

ENV HFSQL_VERSION 22.0.063.e
ENV ACCESS_PORT 4900
ENV MANTA_PORT 4999
ENV DEBUG_PORT 27281

# import public key "PCSOFT <network@pcsoft.fr>"
RUN apt-key adv --keyserver hkp://pgp.mit.edu/ --recv-keys 3a2b08fb11ba9bca

# Installation
RUN echo "deb http://package.windev.com/fr/debian/ debian main" > /etc/apt/sources.list.d/pcsoft.list
RUN apt-get update && apt-get install --no-install-recommends -y libqt4-gui hfsql="${HFSQL_VERSION}" && rm -rf /var/lib/apt/lists/* && apt-get autoremove -y

# Customization of HSQL server
RUN echo "MoreThan2Go=1" >> /opt/hfsql/HFConf.ini
RUN echo "AccessPort=${ACCESS_PORT}" >> /opt/hfsql/HFConf.ini
RUN echo "WLDebugPort=${DEBUG_PORT}" >> /opt/hfsql/HFConf.ini
RUN echo "[AUTOANALYSE]" >> /opt/hfsql/HFConf.ini
RUN echo "Enabled=1" >> /opt/hfsql/HFConf.ini

VOLUME /var/lib/hfsql

USER hfsql
EXPOSE ${ACCESS_PORT}
EXPOSE ${MANTA_PORT}
EXPOSE ${DEBUG_PORT}

CMD ["/opt/hfsql/manta64","--no-daemon"]

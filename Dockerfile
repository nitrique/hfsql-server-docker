FROM debian:jessie

ENV HFSQL_VERSION 22.0.036.c
ENV WINDEV_RELEASE WD220PACKDVD037g2
ENV WINDEV_PACK wx22_37g

# import public key "PCSOFT <network@pcsoft.fr>"
RUN apt-key adv --keyserver hkp://pgp.mit.edu/ --recv-keys 3a2b08fb11ba9bca

RUN echo "deb http://package.windev.com/fr/debian/ debian main" > /etc/apt/sources.list.d/pcsoft.list

RUN apt-get update && apt-get install --no-install-recommends -y sudo unzip wget libiodbc2-dev iodbc libqt4-gui hfsql="${HFSQL_VERSION}" && rm -rf /var/lib/apt/lists/* && apt-get autoremove -y

# Install ODBC
RUN mkdir /opt/wdhfo (wxpackodbclinux64)
WORKDIR /tmp
RUN wget https://www.pcsoft.fr/st/telec/22/telechargement.php?PACK="${WINDEV_PACK}"/fr/"${WINDEV_RELEASE}".exe
RUN unzip ./"${WINDEV_RELEASE}".exe "INSTALL/ODBC/wxpackodbclinux64.zip"
RUN unzip wxpackodbclinux64.zip -d /opt/wdhfo
WORKDIR /opt/wdhfo
RUN ./install.sh

# Cleaning
RUN rm -Rf /tmp/*

VOLUME /var/lib/hfsql

EXPOSE 4900
EXPOSE 4999

USER hfsql

CMD ["/opt/hfsql/manta64","--no-daemon"]

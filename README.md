# hfsql-server-docker

HFSQL is a database engine included in the following development environments : WINDEV, WINDEV Mobile and WEBDEV. 
The version of HFSQL included is *22.0.052.b*.

# Launching

`docker run -dti -p 4900:4900 -p 4999:4999 -p 27281:27281 -v /data/db:/var/lib/hfsql -v /data/backup:/usr/local/HFSQL/backup/ --name HFSQL sdiraimondo/hfsql-server-docker`

Default login `Admin` with blank password

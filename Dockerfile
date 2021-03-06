FROM phusion/baseimage:0.9.15
ENV DEBIAN_FRONTEND=noninteractive

#add this for mustache templates in config files
ADD https://raw.githubusercontent.com/tests-always-included/mo/master/mo /usr/bin/
RUN chmod +x /usr/bin/mo
RUN apt-get update;

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' >> /etc/apt/sources.list.d/pgdg.list
RUN sudo apt-get update
RUN apt-get install -y wget
RUN apt-get install -y rsyslog
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
RUN sudo apt-get update

RUN apt-get update && apt-get install -y postgresql-9.4 postgresql-contrib-9.4 postgis postgresql-9.4-postgis-2.1 git-core default-jdk maven

ADD pg_hba.conf /etc/postgresql/9.4/main/pg_hba.conf 
ADD postgresql.conf /etc/postgresql/9.4/main/postgresql.conf

RUN mkdir -p /data

VOLUME ["/data"]

ADD start_postgres.sh /etc/my_init.d/start_postgres.sh

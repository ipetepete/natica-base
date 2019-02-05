FROM python:3.6.6-jessie

RUN apt update
RUN apt install -y \
   postgresql-client \
   libc-dev \
   build-essential \
   git \
   rsync

RUN apt install -y nginx supervisor


# setup all the configfiles
COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./config/supervisord.conf /etc/supervisord.conf
COPY ./config/nginx-app.conf /etc/nginx/sites-available/default
COPY ./config/supervisor-app.conf /etc/supervisor/conf.d/
COPY ./config/search-schema.json /etc/mars/search-schema.json
COPY ./config/uwsgi.ini /config/
COPY ./config/uwsgi_params /config/

COPY ./config/create-nfs-group.sh /config

RUN sh /config/create-nfs-group.sh

# Concat the ca-bundle with the system one
COPY ./config/__dm_noao_edu.ca-bundle /config
#RUN cat /config/__dm_noao_edu.ca-bundle >> /etc/ssl/certs/ca-certificates.crt

#COPY ./bash_profile /root/.bashrc

RUN mkdir /mars
WORKDIR /mars
COPY ./requirements.txt /mars
RUN pip3 install uwsgi
RUN pip3 install -r requirements.txt
#RUN source scl_source enable rh-python35 && pip3 install -r requirements.txt
#RUN scl enable rh-python35 bash
#RUN pip3 install -r requirements.txt
#ENV PYTHONPATH /mars/marssite/marssite

RUN adduser --disabled-password --gecos "" devops


EXPOSE 80 8000
CMD ['supervisord', '-n', '-c', '/etc/supervisor/conf.d/supervisor-app.conf']

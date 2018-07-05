FROM ipetepete/centos7-python3:latest


RUN yum install -y \
   epel-release \
   openssl-devel \
   postgresql-devel \
   gcc-c++ \
   rsync

RUN yum install -y nginx


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

RUN mkdir /mars
WORKDIR /mars
COPY ./requirements.txt /mars
RUN source scl_source enable rh-python35 && pip3 install -r requirements.txt
#RUN scl enable rh-python35 bash
#RUN pip3 install -r requirements.txt
ENV PYTHONPATH /mars/marssite/marssite

EXPOSE 80 8000
CMD ['supervisord', '-n', '-c', '/etc/supervisor/conf.d/supervisor-app.conf']

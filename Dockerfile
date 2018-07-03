FROM ipetepete/centos7-python3

RUN yum install -y \
   python-dev \
   libldap2-dev \
   libsasl2-dev \
   libssl-dev \
   supervisor \
   rsync \
   nginx

 RUN pip3 install uwsgi

 # setup all the configfiles
 COPY /config/nginx.conf /etc/nginx/nginx.conf
 COPY /config/supervisord.conf /etc/supervisord.conf
 COPY /config/nginx-app.conf /etc/nginx/sites-available/default
 COPY /config/supervisor-app.conf /etc/supervisor/conf.d/

 COPY /config/uwsgi.ini /config/
 COPY /config/uwsgi_params /config/

 COPY /config/create-nfs-group.sh /config

 RUN sh /config/create-nfs-group.sh

 RUN mkdir /mars
 WORKDIR /tmp
 COPY ./mars/requirements.txt /tmp/
 RUN pip install -r requirements.txt
 WORKDIR /mars
 COPY ./mars/marssite/dal/search-schema.json /etc/mars/search-schema.json
 ENV PYTHONPATH /mars/marssite/marssite

 EXPOSE 80 8000
 CMD ['supervisord', '-n', '-c', '/etc/supervisor/conf.d/supervisor-app.conf']

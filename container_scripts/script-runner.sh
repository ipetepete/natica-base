#!/usr/bin/env bash
## setup some env vars
export PYTHONPATH=$PYTHONPATH:/mars/marssite/marssite
export DJANGO_SETTINGS_MODULE=marssite.settings

### Runs scripts inside the vm
# these will live under /scripts on the vm
# working dir is /mars

# look for run once scripts
# name scripts once[..].sh
for i in $(ls /scripts | grep "once*"); do
    #sh /scripts/$i
    #fname=${i#once}
    #mv /scripts/$i /scripts/done.bak
    echo "hi ${i}"
done


cd marssite
#python3 ./manage.py collectstatic
if [ "$ENVIRONMENT" == "dev" ] || [ "$ENVIRONMENT" == "demo" ]; then
  python3 ./manage.py runserver 0.0.0.0:8000
else
  supervisord -n -c /etc/supervisor/supervisord.conf
fi

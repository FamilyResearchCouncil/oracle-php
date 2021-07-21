#!/usr/bin/env bash
source /var/www/html/.env

if [ "$(whoami)" == "root" ]; then
    chown www-data: /var/www/html/storage/logs -R
fi

# handle commads to run in a container
if [ $# -gt 0 ]; then
    echo "($(whoami)) Executing Command:" "$@"

    if [ "$(whoami)" == "root" ]; then
        exec gosu www-data "$@"
    else
        exec "$@"
    fi

    exit; # all done....
fi

# otherwise, run the container as a service

echo "***********************************************"
echo "* Starting $CONTAINER_ROLE container!"
echo "***********************************************"
echo "*"
echo "* Optimizing Application"
setfacl -d -m g:www-data:rw /var/www/html/storage/logs
/usr/bin/php /var/www/html/artisan optimize


# set up the app container
if [ "$CONTAINER_ROLE" == 'app' ];then
    chown 1000:1000 storage -R

    echo "*"
    echo "* Linking storage"
    su -s /bin/sh www-data -c "/usr/bin/php artisan storage:link"

    echo "*"
    echo "* Running Migrations"
    su -s /bin/sh www-data -c "/usr/bin/php artisan migrate --force"

    echo "*"
    echo "* Setting up Passport"
    su -s /bin/sh www-data -c "/usr/bin/php artisan passport:keys"
fi


echo "*"
echo "* Starting ${CONTAINER_ROLE}..."
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisor-$CONTAINER_ROLE.conf

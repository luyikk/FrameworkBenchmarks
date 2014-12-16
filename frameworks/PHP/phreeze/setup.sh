#!/bin/bash

sed -i 's|localhost:3306|'"${DBHOST}"':3306|g' index.php
sed -i 's|.*/FrameworkBenchmarks/phreeze|"'"${TROOT}"'|g' deploy/phreeze
sed -i 's|Directory .*/FrameworkBenchmarks/phreeze|Directory '"${TROOT}"'|g' deploy/phreeze
sed -i 's|root .*/FrameworkBenchmarks/phreeze|root '"${TROOT}"'|g' deploy/nginx.conf
sed -i 's|/usr/local/nginx/|'"${IROOT}"'/nginx/|g' deploy/nginx.conf

export PATH="$PHP_HOME/bin:$PHP_HOME/sbin:$PATH"

$PHP_FPM --fpm-config $FWROOT/config/php-fpm.conf -g $TROOT/deploy/php-fpm.pid
$NGINX_HOME/sbin/nginx -c $TROOT/deploy/nginx.conf
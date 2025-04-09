#!/bin/sh
# launcher.sh - Start php-cgi with custom params for Tomcat integration

# Use Remi's PHP 8.3 path
PHP_CGI="/opt/remi/php83/root/usr/bin/php-cgi"

# Socket or port binding (adjust as needed)
PHP_CGI_PORT="127.0.0.1:9668"

# Optional: custom PHP directives
PHP_INI_DIR="/opt/remi/php83/root/etc"
SESSION_PATH="/home/ec2-user/development/software/apache-tomcat-9.0.73/temp"

# Launch php-cgi with required options
"$PHP_CGI" \
    -b "$PHP_CGI_PORT" \
    -d session.save_path="$SESSION_PATH" \
    -d display_errors=Off \
    -d log_errors=On \
    -d error_reporting=E_ALL \
    -d allow_url_include=On \
    1>&2 &

PID=$!

# Trap shutdown signals and clean up
trap "kill $PID; exit 0" INT TERM

# Wait for input to keep process alive
read _

# Clean up PHP CGI when done
kill $PID


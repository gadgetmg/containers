#!/bin/bash

configFile="/var/www/html/.env"

# Write configuration file
cat > $configFile <<EOF
dbHost="$EZXSS_DBHOST"
dbUser="$EZXSS_DBUSER"
dbPassword="$EZXSS_DBPASSWORD"
dbName="$EZXSS_DBNAME"
dbPort=$EZXSS_DBPORT
debug=$EZXSS_DEBUG
httpmode=$EZXSS_HTTPMODE
signupEnabled=$EZXSS_SIGNUPENABLED
EOF

# Chain to the standard entrypoint from the upstream image
docker-php-entrypoint apache2-foreground

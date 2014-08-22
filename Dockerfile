from ubuntu:14.04
env DEBIAN_FRONTEND noninteractive

# locales
#env LC_ALL C.UTF-8

# helper
run apt-get update && apt-get install -y curl
# git vim less gzip bzip2 unzip byobu jq

# apache
run apt-get update && apt-get install -y apache2 && \
  a2enmod proxy_http && \
  rm /etc/apache2/sites-enabled/000-default.conf && \
  mkdir -p /var/lock/apache2

env APACHE_RUN_USER www-data
env APACHE_RUN_GROUP www-data
env APACHE_PID_FILE /var/run/apache2.pid
env APACHE_RUN_DIR /var/run/apache2
env APACHE_LOCK_DIR /var/lock/apache2
env APACHE_LOG_DIR /var/log/apache2
env LANG C

# kibana
run curl -L https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz | \
  tar -xz --directory /var/www --strip-components 1

# conf
add apache-kibana.conf.env /etc/apache2/sites-enabled/kibana.conf.env
add config.js /var/www/
add envconf /usr/local/bin/
add kibana_run /usr/local/bin/

cmd ["kibana_run"]
expose 80

FROM sirwoongke/php7.0-base
LABEL "maintainer"="sirwoongke"
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /var/www
RUN mkdir xpressengine
WORKDIR /var/www/xpressengine

RUN chgrp -R www-data /var/www/xpressengine
RUN chmod -R 775 /var/www/xpressengine

ADD xe.conf /etc/apache2/sites-available

RUN a2dissite 000-default.conf
RUN a2ensite xe.conf
RUN a2enmod rewrite
RUN service apache2 restart

RUN apt-get install build-essential libssl-dev -y
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
# RUN ["source ~/.bashrc"]
# RUN nvm install 8.10.0
# RUN npm install gulp -g

WORKDIR /var/www/xpressengine

CMD apachectl -DFOREGROUND

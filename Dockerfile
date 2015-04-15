FROM genti/gentoo-stage3
MAINTAINER  Genti Topija <genti.topija@banzai.it>

COPY make.conf etc/portage/make.conf
RUN echo "MAKEOPTS=\"-j$(nproc)\"" > /etc/portage/cpu.conf

RUN echo "dev-lang/php cgi curl fpm gd mysql mysqli pdo zip calendar truetype" >> /etc/portage/package.use/php
RUN echo "app-eselect/eselect-php fpm" >> /etc/portage/package.use/eselect-php

RUN  emerge --sync && emerge -u portage
RUN  emerge  \
	vim app-misc/screen  app-misc/mc zip unzip logrotate htop lshw php nginx \
        gentoolkit portage-utils eix links lynx wget

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
#/usr/sbin/nginx -c /etc/nginx/nginx.conf
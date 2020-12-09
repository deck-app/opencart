FROM php:7.3-apache

ENV OPENCART_VER 3.0.3.6
ENV OPENCART_MD5 41c7e7ec49d389fc4c2204efb40289e6
ENV OPENCART_URL https://github.com/opencart/opencart/releases/download/${OPENCART_VER}/opencart-${OPENCART_VER}.zip
ENV OPENCART_FILE opencart.zip

MAINTAINER Naba Das <nabad600@gmail.com>

RUN a2enmod rewrite headers

RUN apt-get update && \
    apt-get install -y --no-install-recommends git zip libzip-dev

RUN set -xe \
    && apt-get update \
    && apt-get install -y libpng-dev libjpeg-dev libwebp-dev unzip \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr --with-webp-dir=/usr \
    && docker-php-ext-install gd mysqli pdo_mysql zip

WORKDIR /var/www/html

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
EXPOSE 80
CMD ["/bin/bash", "/usr/local/bin/entrypoint.sh"]

# RUN set -xe \
#     && curl -sSL ${OPENCART_URL} -o ${OPENCART_FILE} \
#     && echo "${OPENCART_MD5}  ${OPENCART_FILE}" | md5sum -c \
#     && unzip ${OPENCART_FILE} 'upload/*' -d /var/www/html/ \
#     && mv /var/www/html/upload/* /var/www/html/ \
#     && rm -r /var/www/html/upload/ \
#     && mv config-dist.php config.php \
#     && mv admin/config-dist.php admin/config.php \
#     && rm ${OPENCART_FILE} \
# 	&& sed -i 's/MYSQL40//g' install/model/install/install.php \
#     && chown -R www-data:www-data /var/www

FROM php:fpm-bullseye
ENV ACCEPT_EULA=Y
RUN apt-get update && apt-get install -y gnupg2
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg
RUN curl https://packages.microsoft.com/config/debian/12/prod.list | tee /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update 
RUN ACCEPT_EULA=Y apt-get -y --no-install-recommends install msodbcsql18 unixodbc-dev 
RUN docker-php-ext-install mysqli
RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv
RUN docker-php-ext-enable mysqli sqlsrv pdo_sqlsrv

# sudo docker build . -f /mnt/code/custom-php-fpm/Dockerfile -t 10.0.16.64:5000/custom-php-fpm:latest | docker image prune --filter="dangling=true" | docker push 10.0.16.64:5000/custom-php-fpm:latest
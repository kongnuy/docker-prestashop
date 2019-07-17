## docker-prestashop
Ce repository contient un fichier dockerfile qui permet de créer un image prestashop à partir de ubuntu 18.04.

## C'est quoi Docker?
Docker est un logiciel libre permettant facilement de lancer des applications dans des conteneurs logiciels.

## C'est quoi PrestaShop?
PrestaShop est une application Web open source permettant de créer une boutique en ligne dans le but de réaliser du commerce électronique.

## Que fait chaque du fichier Dockerfile?

    FROM ubuntu:18.04
&nbsp;
Permet de spécifier l'image à partir duquel notre image prestashop sera construite. Ici on utilisera `ubuntu` version `18.04`.

    ENV DEBIAN_FRONTEND=noninteractive 
    ENV PS_VERSION=1.7.4.2
&nbsp;
On déclare 02 variables d'environnement. `DEBIAN_FRONTEND=noninteractive` nous permet de désactiver les interactions avec l'utilisateur lors de l'exécution des commandes; `PS_VERSION=1.7.4.2` nous permet de spécifier la version prestashop que l'on désire utiliser.

    RUN apt-get update -y \
    && apt-get install apache2 -y \
    && apt-get update -y 
 &nbsp;
 Ici on met à jour la liste des paquets et on installe le serveur web `apache HTTP Server`.
 
    RUN apt-get install software-properties-common -y\
    && add-apt-repository ppa:ondrej/php -y \
    && apt-get update -y \
    && apt-get install php7.2 -y \
    && apt-get install php-pear php7.2-curl php7.2-dev php7.2-gd php7.2-mbstring php7.2-zip php7.2-mysql php7.2-xml php7.2-pgsql -y \
    && apt-get update -y && apt-get upgrade -y
&nbsp;
On installe `php 7.2` ainsi que certains modules nécéssaires.

    RUN apt-get install nano -y
 &nbsp;
 Installation de l'éditeur de texte `nano` pour l'édition des fichier en cas de besoin.
 
    RUN mkdir -p /var/www/prestashop
 &nbsp;
 On crée le repertoire racine qui contiendra notre installation `prestashop`.
 
    RUN apt-get install unzip
&nbsp;
Installation de unzip.

    COPY prestashop_${PS_VERSION}.zip /var/www/
&nbsp;
On copie le fichier zip de prestashop dans le dossier `/var/www/` de notre image.

    RUN unzip /var/www/prestashop_${PS_VERSION}.zip -d /var/www/prestashop \
    && rm /var/www/prestashop_${PS_VERSION}.zip
&nbsp;
On dézippe prestashop dans le dossier `/var/www/prestashop/` et on supprime le zip de prestashop.

    COPY run.sh /var/www/prestashop/
&nbsp;
Copie du script de démarage `run.sh` dans le dossier d'installation de prestashop.

    RUN chmod a+x /var/www/prestashop/run.sh \
    && chmod -R a+w /var/www/prestashop
&nbsp;
Ici on donne le droit d'exécution du fichier `run.sh` à tous les utilisateurs et on donne le droit d'écriture de manière récurcive dans le dossier `/var/www/prestashop` à toous les utilisateurs.

    COPY prestashop.conf /etc/apache2/sites-available/
&nbsp;
On copie le fichier `prestashop.conf` dans le dossier `/etc/apache2/sites-available/`

    RUN a2dissite 000-default.conf && a2ensite prestashop.conf
&nbsp;
Désactivation du site par défaut de apache et activation du site `prestashop.conf`.

<<<<<<< HEAD
    RUN a2enmod rewrite
&nbsp;
Activation du `mod_rewrite` de apache
=======
>>>>>>> 45308b7e69abef2da03c7e943b40bab4fd9f4543
    EXPOSE 80
&nbsp;
On ouvre le port `80` dans les conteneurs qui seront créer à partir de cette image.

    ENTRYPOINT ["/var/www/prestashop/run.sh"]
&nbsp;
On définit le point d'entrée lors de l'exécution des conteneurs.

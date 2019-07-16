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

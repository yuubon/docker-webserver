#!/bin/sh

sudo docker run -p 80:80 -p 8022:22  -v ~/public_html/:/var/www/html  -d yuubon/webserver


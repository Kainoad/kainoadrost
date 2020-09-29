FROM debian:buster-slim

RUN \
    apt-get update && \
    apt-get install -y nginx python3 python3-pip certbot python-certbot-nginx cron
WORKDIR /srv/kainoadrost
COPY . .
RUN python3 -m pip install -r requirements.txt
RUN \
    cp systemd/system/kainoadrost.service /etc/systemd/system && \
    cp nginx/sites-available/kainoadrost /etc/nginx/sites-available && \
    ln -s /etc/nginx/sites-available/kainoadrost /etc/nginx/sites-enabled && \
    rm /etc/nginx/sites-enabled/default && \
    cp systemctl3.py /usr/bin/systemctl && \
    chmod +x /usr/bin/systemctl && \
    systemctl start kainoadrost && \
    systemctl enable kainoadrost && \
    systemctl restart nginx && \
    certbot --nginx --non-interactive --agree-tos -m developer2334@gmail.com -d kainoadrost.com -d www.kainoadrost.com && \
    (crontab -l ; echo "1 1 1 * * certbot renew") | crontab -
EXPOSE 80
EXPOSE 443

CMD ["systemctl"]

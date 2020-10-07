FROM debian:buster-slim

EXPOSE 80
EXPOSE 443

WORKDIR /srv/kainoadrost
COPY . .

# Install software
RUN \
    apt-get update && \
    apt-get install -y nginx python3 python3-pip certbot python-certbot-nginx cron && \
    python3 -m pip install -r requirements.txt

# Configure software and files
RUN \
    cp systemd/system/kainoadrost.service /lib/systemd/system && \
    cp nginx/sites-available/kainoadrost /etc/nginx/sites-available && \
    ln -s /etc/nginx/sites-available/kainoadrost /etc/nginx/sites-enabled && \
    rm /etc/nginx/sites-enabled/default && \
    cp systemctl3.py /usr/bin/systemctl && \
    chmod +x /usr/bin/systemctl && \
    mkdir -p /var/log/uwsgi
#     certbot --nginx --non-interactive --agree-tos -m developer2334@gmail.com -d kainoadrost.com -d www.kainoadrost.com && \
#     (crontab -l ; echo "1 1 1 * * certbot renew") | crontab -

# Configure user
RUN \
    useradd -m websrv_user && \
    usermod -aG www-data websrv_user && \
    chown -R websrv_user:websrv_user /var/log/uwsgi && \
    systemctl enable kainoadrost

CMD ["systemctl"]

FROM debian:buster-slim

RUN \
    apt-get update && \
    apt-get install -y nginx python3 python3-pip
WORKDIR /srv/kainoadrost
COPY . .
RUN python3 -m pip install -r requirements.txt
RUN \
    cp systemd/system/kainoadrost.service /etc/systemd/system && \
    cp nginx/sites-available/kainoadrost /etc/nginx/sites-available && \
    ln -s /etc/nginx/sites-available/kainoadrost /etc/nginx/sites-enabled && \
    rm /etc/nginx/sites-enabled/default && \
    cp systemctl3.py /usr/bin/systemctl && \
    systemctl start kainoadrost && \
    systemctl enable kainoadrost && \
    systemctl restart nginx
EXPOSE 80
EXPOSE 443

CMD ["systemctl"]

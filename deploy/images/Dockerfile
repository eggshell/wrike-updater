FROM jfloff/alpine-python:2.7

RUN apk add --update --no-cache bash curl
RUN apk upgrade libcurl
RUN mkdir -p /opt/git/wrike-updater && mkdir -p /var/secrets/google
RUN chmod 0644 /var/secrets/google
COPY . /opt/git/wrike-updater
RUN pip install -r /opt/git/wrike-updater/requirements.txt
RUN crontab -l | { cat; echo "*/10 * * * * cd /opt/git/wrike-updater && bash /opt/git/wrike-updater/run.sh"; } | crontab -
CMD ["/usr/sbin/crond", "-f", "-d", "0"]

FROM jfloff/alpine-python:2.7

RUN mkdir -p /opt/git
COPY . /opt/git/wrike-updater
RUN crontab -l | { cat; echo "* * * * * cd /opt/git/wrike-updater && bash run.sh"; } | crontab -
CMD ["sh", "-c", "crond"]

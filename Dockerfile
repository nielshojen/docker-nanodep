FROM alpine

ENV NANODEP_VERSION="0.2.1"

RUN apk --no-cache add curl
RUN apk --update add ca-certificates
RUN curl -L https://github.com/micromdm/nanodep/releases/download/v${NANODEP_VERSION}/nanodep-linux-amd64-v${NANODEP_VERSION}.zip -o /nanodep.zip
RUN unzip /nanodep.zip
RUN rm /nanodep.zip
RUN mv /nanodep-linux-amd64-v${NANODEP_VERSION}/depserver-linux-amd64 /usr/local/bin/depserver
RUN mv /nanodep-linux-amd64-v${NANODEP_VERSION}/depsyncer-linux-amd64 /usr/local/bin/depsyncer
RUN chmod a+x /usr/local/bin/depserver
RUN chmod a+x /usr/local/bin/depsyncer
RUN apk del curl

COPY run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 9001

CMD ["/run.sh"]

FROM alpine
RUN apk add --update bash openssh sshpass
COPY build.sh /home/build/build.sh
CMD ["bin/sh", "/home/build/build.sh"]

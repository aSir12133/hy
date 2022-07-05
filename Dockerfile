FROM Hy/Hy:latest

RUN apk update && \
    apk add --no-cache curl wget unzip && \
    rm -rf /var/cache/apk/*
    
COPY cert.crt /root/
COPY private.key /root/


ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD /start.sh    

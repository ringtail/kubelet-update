FROM debian:jessie 

RUN apt-get update -y && apt-get install -y libcurl3 libnss3

ADD update.sh /update.sh 
RUN chmod +x update.sh 

ENTRYPOINT ["/update.sh"] 

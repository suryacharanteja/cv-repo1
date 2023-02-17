FROM ubuntu:latest AS BUILD_IMAGE
RUN apt update && apt install git wget unzip -y
RUN mkdir /home/ubuntu/container && cd /homeu/ubuntu/container
RUN git clone https://github.com/suryacharanteja/cv-repo1.git
RUN cd cv-repo1 && tar -czf cv-repo1.tgz * && mv cv-repo1.tgz /root/cv-repo1.tgz


FROM ubuntu:latest
LABEL "writer"="Charan"
LABEL "project"="Resume"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install apache2 git wget -y
COPY --from=BUILD_IMAGE /root/cv-repo1.tgz /var/www/html/
RUN cd /var/www/html/ && tar xzf cv-repo1.tgz
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
VOLUME /var/log/apache2
WORKDIR /var/www/html/
EXPOSE 80

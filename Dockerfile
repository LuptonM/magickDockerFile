FROM rocker/verse:3.5.3
ENV DEBIAN_FRONTEND noninteractive


RUN install2.r --error \
    magick 

RUN install2.r --error \
    ggpubr 

RUN install2.r --error \
    extrafont

RUN echo "deb http://ftp.de.debian.org/debian testing main" >> /etc/apt/sources.list
RUN echo 'APT::Default-Release "stable";' | tee -a /etc/apt/apt.conf.d/00local


RUN apt-get update && apt-get -t testing install  python3.6
RUN apt-get update && apt-get -t testing install  libmagick++-dev python3-pip python-setuptools 

RUN mkdir /app

# set the base folder inside the image for Docker to put files in
WORKDIR /app

# copy everything from ellie_twitter_bot to /app
COPY . /app

RUN pip3 install --trusted-host pypi.python.org -r /app/requirements.txt

CMD /app/runner.sh 
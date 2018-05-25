FROM ubuntu:bionic

RUN apt-get update -q && \
    apt-get install -y -q \
        git \
        cmake \
        g++ \
        python \
        python-pip

# Download build and install ecoevolity
RUN git clone https://github.com/phyletica/ecoevolity.git && \
    cd ecoevolity && \
    ./build.sh --prefix /usr/local

# Install pycoevolity via pip
RUN pip install git+git://github.com/phyletica/pycoevolity.git

# Download example data and config file
RUN git clone https://github.com/phyletica/ecoevolity-example-data.git

# Check to see if everything is installed
RUN ecoevolity -h
RUN pyco-sumtimes -h

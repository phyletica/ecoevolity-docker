FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for ecoevolity and pycoevolity
RUN apt-get update -y -q && \
    apt-get install -y -q \
        build-essential \
        bash-completion \
        git \
        cmake \
        python3 \
        python3-pip \
        python3-scipy \
        python3-matplotlib \
        python3-munkres

# Install R for pycoevolity plotting
RUN apt-get install -y -q --no-install-recommends \
        r-base

# Install R packages used by pycoevolity
RUN R -e 'install.packages(c("ggplot2", "ggridges"), repos = "http://cloud.r-project.org/")'

# Download build and install ecoevolity
RUN git clone https://github.com/phyletica/ecoevolity.git && \
    cd ecoevolity && \
    latest_tag="$(git describe --tags "$(git rev-list --tags --max-count=1)")" && \
    git checkout "$latest_tag" && \
    ./build.sh --prefix /usr/local

# Install pycoevolity via pip
RUN python3 -m pip install --break-system-packages git+https://github.com/phyletica/pycoevolity.git

# Download example data and config file
RUN git clone https://github.com/phyletica/ecoevolity-example-data.git
RUN git clone https://github.com/joaks1/phycoeval-example-data.git

# Let's give it a spin
# RUN cd ecoevolity-example-data && \
#     mkdir test && \
#     ecoevolity --relax-missing-sites --relax-triallelic-sites --ignore-data --prefix ./test/ ecoevolity-config.yml && \
#     cd test && \
#     pyco-sumtimes ecoevolity-config-state-run-1.log && \
#     cd .. && \
#     rm -r test

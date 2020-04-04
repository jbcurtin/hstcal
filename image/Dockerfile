from centos:7

RUN yum update -y
RUN yum install htop make gcc gcc-gfortran git -y
RUN mkdir -p /srv/build-tools

RUN mkdir -p /srv/hstcal
COPY ./ /srv/hstcal
# RUN git clone https://github.com/spacetelescope/hstcal.git /srv/hstcal

RUN curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda3-install.sh
RUN bash /tmp/miniconda3-install.sh -b -p /data1/miniconda3

WORKDIR /srv/hstcal
RUN \
    source /data1/miniconda3/bin/activate && \
    conda config --add channels http://ssb.stsci.edu/astroconda && \
    conda create --name hstcal_build_env python=3.6 cfitsio pkg-config requests astropy && \
    conda activate hstcal_build_env && \
    pip install pytest ci-watson && \
    ./configure --release-with-symbols && \
    ./waf build && \
    ./waf install && \
    calacs.e --version

ENV OMP_NUM_THREADS=4
ENV TEST_BIGDATA=https://bytesalad.stsci.edu/artifactory
# The following tests break because ci-watson is > 0.4
# RUN pytest tests --basetemp=tests_output --junitxml results.xml --bigdata -v

COPY ./image/build-tools/repl.sh /srv/build-tools
RUN chmod u+x /srv/build-tools/repl.sh
COPY ./image/build-tools/run-tests.sh /srv/build-tools
RUN chmod u+x /srv/build-tools/run-tests.sh

ENTRYPOINT ["/srv/build-tools/repl.sh"]

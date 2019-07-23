FROM debian:stretch

COPY ./magicsquare /opt/

RUN apt-get -y update && apt-get -y install unzip curl libxext6 libxt-dev \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir runtime-installer && cd runtime-installer \
  && curl -sL http://ssd.mathworks.com/supportfiles/downloads/R2018b/deployment_files/R2018b/installers/glnxa64/MCR_R2018b_glnxa64_installer.zip -o installer.zip \
  && unzip installer.zip \
  && ./install -mode silent -agreeToLicense yes \
  && cd / && rm -rf /runtime-installer && rm -rf /tmp/mathworks_*

RUN chmod a+x /opt/magicsquare

ENV LD_LIBRARY_PATH=/usr/local/MATLAB/MATLAB_Runtime/v95/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v95/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v95/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v95/extern/bin/glnxa64
ENV PATH=/opt:$PATH
ENV MCR_CACHE_VERBOSE=true
ENV MCR_CACHE_ROOT=/tmp

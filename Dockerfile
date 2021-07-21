# Container for building and testing cmake-examples with default cmake v3.5.1
FROM ubuntu:18.04

##################################
#  Basic tools for Ubuntu image  #
##################################
RUN apt-get update && apt-get install -y build-essential \
    sudo \
    clang-3.9 \
    clang-format-3.9 \
    cmake \
    wget \
    git \
    curl \
    gnupg \
    gcc \
    g++ \
    make \
    openssh-server \
    lsb-release \
    google-mock \
    libssl-dev \
    libgtest-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


###################################################
#  Specific dependencies needed for the software  #
###################################################
RUN apt-get update && apt-get install -y build-essential \
    libboost-all-dev \
    libprotobuf-dev \
    liblmdb-dev \
    libffi-dev \
    protobuf-compiler \
    libeigen3-dev \
    libsodium-dev \
    libzmq3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "Building spdlog"
RUN git clone --depth 1 --branch v1.8.0 https://github.com/gabime/spdlog.git \
    && cd spdlog && mkdir build && cd build \
    && cmake -DCMAKE_CXX_FLAGS="-fpic" .. && make -j2 && make install

RUN git clone --branch yaml-cpp-0.6.3 https://github.com/jbeder/yaml-cpp.git \
    && cd yaml-cpp && mkdir build && cd build \
    && cmake -DCMAKE_CXX_FLAGS="-fpic" .. && make -j4 && make install

RUN apt-get update && apt-get install -y libsasl2-dev

RUN  wget https://github.com/mongodb/mongo-c-driver/releases/download/1.17.0/mongo-c-driver-1.17.0.tar.gz \
    && tar xzf mongo-c-driver-1.17.0.tar.gz \
    && cd mongo-c-driver-1.17.0 \
    && mkdir cmake-build \
    && cd cmake-build \
    && cmake -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF -DENABLE_STATIC=ON .. \
    && make -j4 && sudo make install

RUN git clone --branch r3.5.1 https://github.com/mongodb/mongo-cxx-driver.git \
    && cd /mongo-cxx-driver/build && cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS_WITH_STATIC_MONGOC=ON -DBUILD_SHARED_AND_STATIC_LIBS=ON -DCMAKE_BUILD_TYPE=Release .. \
    && make -j4 && sudo make install && sudo ldconfig

ADD scout-navigation /home/

RUN apt install ./home/libs/* \
    && cd /home/tjess-transport/build/ \
    && make install \
    && cd /home/navigation/build \
    && make install

CMD ["/bin/bash"]

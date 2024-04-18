# syntax=docker/dockerfile:1

FROM osrf/ros:noetic-desktop-full

ENV DOCKER_VERSION=26.0.0
ENV DIRPATH=/sync_bag_player
SHELL ["/bin/bash", "-c"]

# Install debian packages
RUN apt update \
&& DEBIAN_FRONTEND=noninteractive apt install -y \
    ros-noetic-catkin \
    python3-catkin-tools \
    python3-pip \
    nano \
    curl \
    net-tools \
    xorg -y \
    && rm -rf /var/lib/apt/lists/*

# Install docker cli
# Note that docker daemon utilizes host's machine
RUN curl -sfL -o docker.tgz "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" && \
    tar -xzf docker.tgz --directory /usr/local/bin docker/docker --strip=1  && \
    rm docker.tgz

# Install python packages
RUN pip install --upgrade pip
RUN pip install \
    lcm \
    readchar

RUN rosdep update

WORKDIR $DIRPATH
RUN mkdir -p $DIRPATH/configs
COPY . src
RUN source /opt/ros/$ROS_DISTRO/setup.bash; cd $DIRPATH; catkin build
RUN printf "source /opt/ros/$ROS_DISTRO/setup.bash\nsource $DIRPATH/devel/setup.bash" >> ~/.bashrc
RUN source ~/.bashrc
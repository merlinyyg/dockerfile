FROM nvcr.io/nvidia/l4t-jetpack:r35.1.0

RUN apt-get update && apt-get install  -y locales
RUN locale-gen en_US en_US.UTF-8 && \
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
export LANG=en_US.UTF-8

RUN apt-get update && apt-get install  -y software-properties-common && add-apt-repository universe

RUN apt-get update && \
apt-get install -y curl && \
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt-get update && apt-get install -y ros-galactic-desktop

RUN apt-get update && apt-get install -y vim

RUN apt-get clean

RUN echo "source /opt/ros/galactic/setup.bash" >> ~/.bashrc

COPY docker-entrypoint.sh /scripts/
ENTRYPOINT ["/scripts/docker-entrypoint.sh"]
CMD ["/bin/bash"]

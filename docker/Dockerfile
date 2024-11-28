# FROM nvidia/cuda:11.6.1-devel-ubuntu20.04
# SHELL ["/bin/bash", "-c"]

# ENV DEBIAN_FRONTEND=noninteractive

# RUN apt-get update && \
#     apt-get install -y \
#         wget \
#         curl \
#         git \
#         vim \
#         python3-pip \
#         lsb-release \
#         gnupg \
#         avahi-autoipd \
#         avahi-daemon \
#         avahi-utils

# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#         git-core \
#         python3-wstool \
#         python3-vcstools 

# RUN mkdir -p /etc/apt/keyrings && \
#     curl -sSf https://librealsense.intel.com/Debian/librealsense.pgp | tee /etc/apt/keyrings/librealsense.pgp > /dev/null && \
#     echo "deb [signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo `lsb_release -cs` main" | tee /etc/apt/sources.list.d/librealsense.list

# RUN apt-get update && \
#     apt-get install -y tmux \
#     librealsense2-dkms \
#     librealsense2-utils \
#     librealsense2-dev \
#     librealsense2-dbg

# RUN apt-get update && \
#     apt-get install -y tmux

# RUN source /root/.bashrc && \
#     pip install matplotlib && \
#     pip install torch==1.12.1+cu116 torchvision==0.13.1+cu116 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu116

# # Copy the helper scripts to the working directory.
# COPY ./docker/scripts/. /root/scripts/
# COPY ./docker/config/. /root/
# RUN chmod -R +x /root/scripts/*

# # Setup the Bash shell environment with '/root/.bashrc'.
# RUN echo "source /root/scripts/initialize-bash-shell.sh" >> /root/.bashrc

# # # Force color prompt in terminal.
# RUN sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /root/.bashrc

# RUN apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# WORKDIR /root

# # Set the same permission for the host and the container
# ENV GROUPNAME=weblab
# ENV USERNAME=weblab
# ENV UID=1000
# ENV GID=1000

# RUN groupadd -g $GID $GROUPNAME && \
#     useradd -m -u $UID -g $GID $USERNAME

# COPY --chown=$UID:$GID . /root/work

# ENTRYPOINT []

# CMD ["/bin/bash"]


# Use CUDA 12.1 as the base image for PyTorch 2.3.0 compatibility
FROM nvidia/cuda:12.1.1-devel-ubuntu20.04
SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

# Install Python 3.10 and manually install pip
RUN apt-get update && \
    apt-get install -y \
        curl \
        software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y \
        python3.10 \
        python3.10-distutils && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 && \
    update-alternatives --set python3 /usr/bin/python3.10 && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Verify Python and pip versions
RUN python3 --version && pip --version

# Install essential tools
RUN apt-get update && \
    apt-get install -y \
        wget \
        git \
        vim \
        lsb-release \
        gnupg \
        avahi-autoipd \
        avahi-daemon \
        avahi-utils

# Install ROS-related tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git-core \
        python3-wstool \
        python3-vcstools 

# Install librealsense2 libraries
RUN mkdir -p /etc/apt/keyrings && \
    curl -sSf https://librealsense.intel.com/Debian/librealsense.pgp | tee /etc/apt/keyrings/librealsense.pgp > /dev/null && \
    echo "deb [signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo `lsb_release -cs` main" | tee /etc/apt/sources.list.d/librealsense.list

RUN apt-get update && \
    apt-get install -y \
        tmux \
        librealsense2-dkms \
        librealsense2-utils \
        librealsense2-dev \
        librealsense2-dbg

# Install additional tools
RUN apt-get update && \
    apt-get install -y tmux

# Install PyTorch and other Python packages
RUN pip install matplotlib && \
    pip install torch==2.3.0 torchvision==0.18.0 torchaudio==2.3.0 --index-url https://download.pytorch.org/whl/cu121

# Copy the helper scripts to the working directory
COPY ./docker/scripts/. /root/scripts/
COPY ./docker/config/. /root/
RUN chmod -R +x /root/scripts/*

# Setup the Bash shell environment with '/root/.bashrc'
RUN echo "source /root/scripts/initialize-bash-shell.sh" >> /root/.bashrc

# Force color prompt in terminal
RUN sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /root/.bashrc

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /root

# Set the same permission for the host and the container
ENV GROUPNAME=weblab
ENV USERNAME=weblab
ENV UID=1000
ENV GID=1000

RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -u $UID -g $GID $USERNAME

COPY --chown=$UID:$GID . /root/work

ENTRYPOINT []

CMD ["/bin/bash"]

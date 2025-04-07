# Using a Debian base image designed for toolbox or development environments.
FROM quay.io/toolbx-images/debian-toolbox:12

# Labels provide additional information about the image.
LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A Citrix-enabled container for cloud-native terminal experiences" \
      maintainer="palomar.research@gmail.com"

# Create a non-root user 'citrix' with UID 1000.
RUN useradd -m -u 1000 citrix

# Update and install necessary packages.
RUN apt-get update && \
    apt-get install -y \
    openssl \
    libsecret-1-0 \
    pulseaudio \
    pulseaudio-utils \
    libcanberra-gtk3-module \
    curl \
    libnss3 && \
    rm -rf /var/lib/apt/lists/*

# Copying the Citrix ICA client .deb file and installing it.
RUN cd /tmp && \
    curl -LO https:$(curl -L https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html |grep icaclient|grep deb|grep amd64|awk -F 'rel="' '{print $2}' | awk -F '"' '{print $1}')

RUN apt-get update && \
    apt-get install -y /tmp/icaclient_24.11.0.85_amd64.deb && \
    rm -rf /var/lib/apt/lists/* /tmp/icaclient_24.11.0.85_amd64.deb

COPY wfica.sh /opt/Citrix/ICAClient/
RUN mkdir -p /home/citrix/.ICAClient && \
    touch /home/citrix/.ICAClient/.eula_accepted && \
    chown -R citrix:citrix /home/citrix/.ICAClient /opt/Citrix/ICAClient/wfica.sh && \
    chmod +x /opt/Citrix/ICAClient/wfica.sh

# Copying .desktop files to a suitable directory, such as /usr/share/applications.
COPY wfica.desktop /usr/share/applications/

# Creating symbolic links for various commands to the 'distrobox-host-exec'.
RUN ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update

# Omitting the ENTRYPOINT as it's not needed for a distrobox environment.

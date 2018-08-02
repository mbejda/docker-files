include(`arch-nvidia.m4')

include(`i-multilib.m4') \
    && pacman -Syu --noconfirm unzip wine-staging winetricks playonlinux wine_gecko wine-mono lib32-libpulse lib32-alsa-plugins lib32-nvidia-utils \
    && pacman -Scc --noconfirm

COPY arch-aur-install /usr/bin
include(`i-builduser.m4') \
    && sudo -u builduser bash -c 'cd ~ && mkdir tmp && cd tmp && arch-aur-install https://aur.archlinux.org/cgit/aur.git/snapshot/dxvk-bin.tar.gz' \
include(`d-builduser.m4')

RUN pacman -Syu --noconfirm libwbclient vulkan-icd-loader lib32-vulkan-icd-loader lib32-libxml2 lib32-mpg123 lib32-lcms2 lib32-giflib lib32-libpng lib32-gnutls lib32-gst-plugins-base lib32-gst-plugins-good

ENTRYPOINT ["playonlinux"]
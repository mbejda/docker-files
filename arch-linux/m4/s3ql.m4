include(`arch.m4')

RUN pacman -Sy --noconfirm python-six python-pip gcc autoconf automake fuse2 pkgconf make pkg-config \
    && pip install dugong pycrypto defusedxml requests apsw llfuse Cython

RUN curl -L https://github.com/s3ql/s3ql/archive/release-2.33.tar.gz | tar xzf - --strip-components=1 -C /tmp \
  && cd /tmp \
  && rm MANIFEST.in \
  && python setup.py build_cython \
  && python setup.py build_ext --inplace \
  && python setup.py install \
  && pacman -Rs --noconfirm gcc autoconf automake pkgconf make \
  && pacman -Scc --noconfirm \
  && rm -rf /tmp/*

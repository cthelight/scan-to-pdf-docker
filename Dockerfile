FROM debian:12-slim

# DEPS taken from sane-scan-pdf documentation
# Plus assorted tools necessary to wrap around sane-scan-pdf
RUN apt-get update && apt-get install --no-install-recommends -y \
  netpbm \
  ghostscript \
  poppler-utils \
  imagemagick \
  unpaper \
  util-linux \
  parallel \
  units \
  bc \
  scanbd \
  sane \
  sane-utils \
  && rm -rf /var/lib/apt/lists/*

# Pull down very helpful scripts (rocketraman/sane-scan-pdf)
# Pinned to specific known-good verison
ADD --chmod=777 'https://github.com/rocketraman/sane-scan-pdf/raw/refs/heads/master/scan' /usr/local/bin/scan
ADD --chmod=777 'https://github.com/rocketraman/sane-scan-pdf/raw/refs/heads/master/scan_perpage' /usr/local/bin/scan_perpage

# Scan output dir (should be mounted volume)
RUN mkdir /scans
VOLUME /scans

# scanbd.conf
COPY scanbd.conf /etc/scanbd/scanbd.conf

# Actual scan script (world executable)
COPY --chmod=777 scan.sh /etc/scanbd/scripts/scan.sh

# Entrypoint script (world executable)
COPY --chmod=777 run.sh /run.sh

# User can override output UID/GID for ease of access
# Default to root:root
ENV OUTPUT_UID=0
ENV OUTPUT_GID=0


CMD /run.sh

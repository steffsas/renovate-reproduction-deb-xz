FROM debian:bookworm-slim

# add backports sources list to apt package manager
RUN printf "deb http://deb.debian.org/debian bookworm-backports main contrib non-free\n" >> /etc/apt/sources.list.d/backports.list

# renovate: suite=bookworm-backports depName=tor
ENV TOR_VERSION="0.4.7-11"

RUN apt-get update && apt-get install -y \
    tor="${TOR_VERSION}" \
    # backports allow us to install latest backport stable versions
    --no-install-recommends -t bookworm-backports
FROM debian:stable
RUN apt-get update && apt-get install -y --no-install-recommends gpg debsigs expect
RUN mkdir -p /root/.gnupg && chown -R root:root /root && chmod 0700 /root /root/.gnupg && mv /usr/bin/gpg /usr/bin/gpg.real
COPY deb/gpg-wrapper.sh /usr/bin/gpg
COPY gpg-sign-header.sh /
COPY deb/gpg-sign.sh /
CMD /gpg-sign.sh

FROM opensuse:42.3
RUN zypper in -y gpg rpmbuild expect
RUN mkdir -p /root/.gnupg && chown -R root:root /root && chmod 0700 /root /root/.gnupg
COPY gpg-sign-header.sh /
COPY rpm/gpg-sign.sh /
CMD /gpg-sign.sh

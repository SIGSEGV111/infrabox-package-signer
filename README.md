# infrabox-package-signer
Docker Containers to sign RPM and DEB packages build within infrabox

This project provides docker containers which are designed to run inside a infrabox build chain.
They will sign all DEB/RPM packages found in their input directory, sign them and move them to the output directory for further processing by downstream containers.

The containers need the following environment variables:
  BUILD_CONTAINER: the name of the parent container
  KEY_NAME: the name of the GPG key to use
  KEY_PASS: the password for the GPG key

The input directory should contain:
  pubring.gpg
  secring.gpg
  trustdb.gpg
  *.rpm
  *.deb

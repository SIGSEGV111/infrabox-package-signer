set -e
set -u
set -o pipefail
set +x

if test -z "$BUILD_CONTAINER"; then
	echo "BUILD_CONTAINER is not set" 1>&2
	exit 1
fi

if test -z "$KEY_NAME"; then
	echo "KEY_NAME is not set" 1>&2
	exit 1
fi

INPUT_DIR="/infrabox/inputs/$BUILD_CONTAINER"
OUTPUT_DIR="/infrabox/output"
WORK_DIR="/tmp/work"

mkdir -p "$INPUT_DIR" "$OUTPUT_DIR" "$WORK_DIR" "$HOME/.gnupg"
cd "$WORK_DIR"

for f in pubring.gpg secring.gpg trustdb.gpg; do
	if test -e "$INPUT_DIR/$f"; then cp -v "$INPUT_DIR/$f" "$HOME/.gnupg/"; fi
done

#

gpg --list-keys
gpg --list-secret-keys

# export public key
gpg --export --armor "$KEY_NAME" > "$OUTPUT_DIR/pubkey.asc"

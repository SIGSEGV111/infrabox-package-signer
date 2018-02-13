#!/bin/bash

source /gpg-sign-header.sh

# import key into RPM
rpm --import "$OUTPUT_DIR/pubkey.asc"

# list imported keys
rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n'

cat >"$HOME/.rpmmacros" << EOF
%_signature gpg
%_gpg_path $HOME/.gnupg
%_gpg_name $KEY_NAME
%_gpgbin $(which gpg)
EOF

# sign all RPMs
for r in "$INPUT_DIR"/*.rpm; do
	n="$(basename "$r")"
	cp "$r" ./

	expect << EOF
spawn rpm --addsign "$n"
expect "Enter pass phrase:"
send -- "$KEY_PASS\r"
expect eof
EOF

	mv "$n" "$OUTPUT_DIR"

	rpm --checksig "$OUTPUT_DIR/$n"
done

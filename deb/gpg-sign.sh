#!/bin/bash

source /gpg-sign-header.sh

# sign all DEBs
for d in "$INPUT_DIR"/*.deb; do
	n="$(basename "$d")"
	cp "$d" ./

	expect << EOF
set timeout 60
spawn debsigs --sign=origin -k "$KEY_NAME" "$n"
expect {
	"Enter passphrase:" {
		send -- "$KEY_PASS\r"
		puts "passphrase requested and sent"
		expect eof
	}
	timeout {puts "took too much time"}
	eof     {puts "did not ask for passphrase"}
}
EOF

	mv "$n" "$OUTPUT_DIR/"
done

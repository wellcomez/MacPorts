SUBDIR= base

all:: base/Makefile

base/Makefile:
	@cd base && ./configure

install::
	@[ -d /Library/Receipts ] && sh ./base/macosx-prereqs.sh || exit 1

include base/Mk/dports.subdir.mk

SUBDIR= base

all:: base/Makefile

base/Makefile:
	@cd base && ./configure

include base/Mk/dports.subdir.mk

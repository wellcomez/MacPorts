/*
 * Copyright (c) 2005 Apple Inc. All rights reserved.
 * Copyright (c) 2005-2006 Paul Guyot <pguyot@kallisys.net>,
 * All rights reserved.
 * Copyright (c) 2006-2013 The MacPorts Project
 *
 * $Id$
 *
 * @APPLE_BSD_LICENSE_HEADER_START@
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1.  Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 * 2.  Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 * 3.  Neither the name of Apple Inc. ("Apple") nor the names of
 *     its contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY APPLE AND ITS CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL APPLE OR ITS CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * @APPLE_BSD_LICENSE_HEADER_END@
 */

#include "darwintrace.h"

#include <errno.h>
#include <fcntl.h>
#include <stdarg.h>
#include <sys/syscall.h>
#include <unistd.h>

/**
 * Wrapper function for \c open(2). Prevents opening files outside the sandbox.
 * Indicates the file does not exist on sandbox violation, or permission denied
 * when attempting to create a file, i.e., when \c O_CREAT is set.
 */
static int _dt_open(const char *path, int flags, ...) {
#define open(x,y,z) syscall(SYS_open, (x), (y), (z))
	__darwintrace_setup();
	int result = 0;

	if (!__darwintrace_is_in_sandbox(path, DT_REPORT | DT_ALLOWDIR | DT_FOLLOWSYMS)) {
		errno = ((flags & O_CREAT) > 0) ? EACCES : ENOENT;
		result = -1;
	} else {
		// Read mode and pass it to the syscall, because we cannot optionally pass
		// parameters to syscalls
		va_list args;
		va_start(args, flags);
		mode_t mode = va_arg(args, int);
		va_end(args);

		result = open(path, flags, mode);
	}
	debug_printf("open(%s) = %d\n", path, result);
	return result;
#undef open
}

DARWINTRACE_INTERPOSE(_dt_open, open);

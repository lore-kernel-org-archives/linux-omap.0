From: Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>
Subject: Problem using gdbserver on ARM target - Strace logs
Date: Mon, 8 May 2006 06:36:46 +0000 (UTC)
Message-ID: <loom.20060508T083423-240@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

We are stuck with problem of gdbserver giving a segmantation fault when
connecting or binding to a socket, when launched on the OMAP P2 730 target
running kernel v2.6.16-omap1. Initially we were working with the gdbserver
binary (dynamically linked) built by us for the downloaded sources. But, the
problem persists even when we use the prebuilt gdbserver binary included in the
'scratchbox' gnu-arm toolchain, which we downloaded from scratchbox.org. 

The problem seems to be relates to presence of shared libs on the target's
rootfs. We have tried many things, like copying the complete /lib tree from the
cross toolchain installation directory to the appropriate lib directory in the
nfs share for rootfs. This only makes the gdbserver launch, after that it gives
the segmentation fault. 

Attached is the strace dump for the gdbserver execution on our target.

Also, Is anyone using  cross toolchain, which has static libraries (.a files)
instead of the shared libraries (.so files). We have downloaded two prebuilt
toolchains but both of them contain the libraries required by gdbserver as
shared objects only- (libc-2.3.2.so, libthread_db-1.0.so, libcrypt-2.3.2.so), we
need static libraries e.g.  libthread_db-1.0.a. Any ideas?

Please help.

Chetan



STRACE LOGS:

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/bin # strace gdbTry 172.21.160.215:6281 ./hello.arm.1.out
execve("/bin/gdbTry", ["gdbTry", "172.21.160.215:6281", "./hello.arm.1.out"], [/
* 8 vars */]) = 0
brk(0)                                  = 0x1c000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0
x40016000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/usr/local/arm/3.3.2/etc/ld.so.cache", O_RDONLY) = -1 ENOENT (No such file
 or directory)
open("/usr/local/arm/3.3.2/lib/v5l/fast-mult/half/libthread_db.so.1", O_RDONLY)
= -1 ENOENT (No such file or directory)
stat64("/usr/local/arm/3.3.2/lib/v5l/fast-mult/half", 0xbedad2a4) = -1 ENOENT (N
o such file or directory)
open("/usr/local/arm/3.3.2/lib/v5l/fast-mult/libthread_db.so.1", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/local/arm/3.3.2/lib/v5l/fast-mult", 0xbedad2a4) = -1 ENOENT (No suc
h file or directory)
open("/usr/local/arm/3.3.2/lib/v5l/half/libthread_db.so.1", O_RDONLY) = -1 ENOEN
T (No such file or directory)
stat64("/usr/local/arm/3.3.2/lib/v5l/half", 0xbedad2a4) = -1 ENOENT (No such fil
e or directory)
open("/usr/local/arm/3.3.2/lib/v5l/libthread_db.so.1", O_RDONLY) = -1 ENOENT (No
 such file or directory)
stat64("/usr/local/arm/3.3.2/lib/v5l", 0xbedad2a4) = -1 ENOENT (No such file or
directory)
open("/usr/local/arm/3.3.2/lib/fast-mult/half/libthread_db.so.1", O_RDONLY) = -1
 ENOENT (No such file or directory)
stat64("/usr/local/arm/3.3.2/lib/fast-mult/half", 0xbedad2a4) = -1 ENOENT (No su
ch file or directory)
open("/usr/local/arm/3.3.2/lib/fast-mult/libthread_db.so.1", O_RDONLY) = -1 ENOE
NT (No such file or directory)
stat64("/usr/local/arm/3.3.2/lib/fast-mult", 0xbedad2a4) = -1 ENOENT (No such fi
le or directory)
open("/usr/local/arm/3.3.2/lib/half/libthread_db.so.1", O_RDONLY) = -1 ENOENT (N
o such file or directory)
stat64("/usr/local/arm/3.3.2/lib/half", 0xbedad2a4) = -1 ENOENT (No such file or
 directory)
open("/usr/local/arm/3.3.2/lib/libthread_db.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\304\23\0"..., 1024) = 102
4
fstat64(3, {st_mode=S_IFREG|0755, st_size=1101460, ...}) = 0
old_mmap(NULL, 49636, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001f000
mprotect(0x40023000, 33252, PROT_NONE)  = 0
old_mmap(0x40027000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0) =
 0x40027000
close(3)                                = 0
open("/usr/local/arm/3.3.2/lib/libc.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0h~\1\0004"..., 1024) = 102
4
fstat64(3, {st_mode=S_IFREG|0755, st_size=26901638, ...}) = 0
old_mmap(NULL, 1212024, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4002c000
mprotect(0x40146000, 56952, PROT_NONE)  = 0
old_mmap(0x4014c000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x11
8000) = 0x4014c000
close(3)                                = 0
mprotect(0x4002c000, 1155072, PROT_READ|PROT_WRITE) = 0
mprotect(0x4002c000, 1155072, PROT_READ|PROT_EXEC) = 0
mprotect(0x4001f000, 16384, PROT_READ|PROT_WRITE) = 0
mprotect(0x4001f000, 16384, PROT_READ|PROT_EXEC) = 0
brk(0)                                  = 0x1c000
brk(0x1d000)                            = 0x1d000
brk(0)                                  = 0x1d000
rt_sigaction(SIGRT_1, {SIG_IGN}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTTOU, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTTIN, {SIG_DFL}, {SIG_DFL}, 8) = 0
fork()                                  = 260
--- SIGCHLD (Child exited) @ 0 (0) ---
write(2, "Process ./hello.arm.1.out create"..., 45Process ./hello.arm.1.out crea
ted; pid = 260
) = 45
rt_sigaction(SIGTTOU, {SIG_IGN}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTTIN, {SIG_IGN}, {SIG_DFL}, 8) = 0
ioctl(2, TIOCSPGRP, [260])              = 0
rt_sigaction(SIGIO, {0xa060, [IO], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [IO], NULL, 8) = 0
wait4(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGTRAP}], WNOHANG, NULL) = 260
ptrace(PTRACE_PEEKUSER, 260, r0, [0])   = 0
ptrace(PTRACE_PEEKUSER, 260, r1, [0xbefb8f70]) = 0
ptrace(PTRACE_PEEKUSER, 260, r2, [0])   = 0
ptrace(PTRACE_PEEKUSER, 260, r3, [0])   = 0
ptrace(PTRACE_PEEKUSER, 260, r4, [0])   = 0
ptrace(PTRACE_PEEKUSER, 260, r5, [0])   = 0
ptrace(PTRACE_PEEKUSER, 260, r6, [0])   = 0
ptrace(PTRACE_PEEKUSER, 260, r7, [0])   = 0
ptrace(PTRACE_PEEKUSER, 260, r8, [0])   = 0
ptrace(PTRACE_PEEKUSER, 260, r9, [0])   = 0
ptrace(PTRACE_PEEKUSER, 260, r10, [0])  = 0
ptrace(PTRACE_PEEKUSER, 260, fp, [0])   = 0
ptrace(PTRACE_PEEKUSER, 260, ip, [0])   = 0
ptrace(PTRACE_PEEKUSER, 260, sp, [0xbefb8eb0]) = 0
ptrace(PTRACE_PEEKUSER, 260, lr, [0])   = 0
ptrace(PTRACE_PEEKUSER, 260, pc, [0x40001690]) = 0
ptrace(PTRACE_PEEKUSER, 260, cpsr, [0x10]) = 0
ptrace(PTRACE_PEEKTEXT, 260, 0x40001690, [0xe1a0000d]) = 0
rt_sigaction(SIGIO, {SIG_IGN}, {0xa060, [IO], SA_RESTART|0x4000000}, 8) = 0
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 3
setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
bind(3, {sa_family=AF_INET, sin_port=htons(6281), sin_addr=inet_addr("0.0.0.0")}
, 16) = 0
listen(3, 1)                            = 0
write(2, "Listening on port 6281\n", 23Listening on port 6281
) = 23
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++
Process 259 detached
Hello World
argc = 1
argv[0] = "./hello.arm.1.out"
argv[1] = "<NULL>"
Hit any key to exit ...

/bin #

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Hello

I am trying bring up gdbserver on my ARM target (OMAP P2 730).

I downloaded a prebuilt toolchain which contains gcc 3.3.2-glibc-2.3.2 + 
binutils-head. We have used this to build   Kernel version 2.6.16-omap1 & 
Busybox-1.0.0.

I have now compiled gdb 6.4 pack, and crosscompiled the gdb with 
--target=arm-linux
For gdbserver in the gbb/gdbserver directory I configured using 
--host=arm-linux 

A make is successful but the dynamically linked ARM executable gives the 
following error when I execute it on the target,

~ # ./gdbserver
-sh: ./gdbserver: No such file or directory

I have noted that the gdbserver executable has been loaded successfully to 
the target yet I am not able to execute it. 

On the host I verified,

# file gdbserver
ELF 32-bit LSB executable, ARM, version 1 (ARM), for GNU/Linux 2.4.3, 
dynamically linked (uses shared libs), not stripped

Any clues as to what is going wrong here ? 

It seems that the gdbserver dynamically linked executable is looking for a 
few shared libraries to be in place in the target's rootfs. I tried 
keeping the required libraries (libc-2.3.2.so, libthread_db-1.0.so, 
libcrypt-2.3.2.so and related symlinks)at path /usr/local/arm/3.3.2/lib on 
the target's rootfs to relsove the issue. This time the gdbserver launches 
but gives a segmentation fault.

Someone suggested that first I should get libthread_db compiled as a 
static library (i.e. libthread_db.a), and then build a statically linked 
gdbserver executable which includes libthread_db.a. 

I have a prebuilt toolchain for which I do not have the source code, and 
libthread_db.a is not present in the toolchain's lib folder, rather 
libthread_db.so is present. Any pointers, where can I get the toolchain's 
source and use it to build static librares?, which will in turn be useful 
in building statically linked gdbserver.

Thanks

Chetan

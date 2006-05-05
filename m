From: Eduardo Gallofin <egallofin@yahoo.com>
Subject: Re: init (busybox) problem on OSK5912
Date: Thu, 4 May 2006 19:39:29 -0700 (PDT)
Message-ID: <20060505023929.13307.qmail@web52310.mail.yahoo.com>
References: <fb249edb0605040943k8a85615w76b5231436d5aec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0605040943k8a85615w76b5231436d5aec@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Just want to give some updates on my case...

I run strace with the "segfaulting" program (./strace
ls -l) and here the trace I see...

/ # /root/./strace ls -l
execve("/bin/ls", ["ls", "-l"], [/* 7 vars */]) = 0
brk(0)                                  = 0x3b000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT
(No such file or directory)
open("/usr/local/arm/3.3.2/etc/ld.so.cache", O_RDONLY)
= -1 ENOENT (No such file or directory)
open("/usr/local/arm/3.3.2/lib/v5l/fast-mult/half/libm.so.6",
O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/local/arm/3.3.2/lib/v5l/fast-mult/half",
0xbeadd2e4) = -1 ENOENT (No such file or directory)
open("/usr/local/arm/3.3.2/lib/v5l/fast-mult/libm.so.6",
O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/local/arm/3.3.2/lib/v5l/fast-mult",
0xbeadd2e4) = -1 ENOENT (No such file or directory)
open("/usr/local/arm/3.3.2/lib/v5l/half/libm.so.6",
O_RDONLY) = 3
read(3,
"\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\270:\0\000"...,
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1909672,
...}) = 0
old_mmap(NULL, 497348, PROT_READ|PROT_EXEC,
MAP_PRIVATE, 3, 0) = 0x4001f000
mprotect(0x40091000, 30404, PROT_NONE)  = 0
old_mmap(0x40097000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 3, 0x70000) = 0x40097000
close(3)                                = 0
open("/usr/local/arm/3.3.2/lib/v5l/half/libc.so.6",
O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/local/arm/3.3.2/lib/v5l/libc.so.6",
O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/local/arm/3.3.2/lib/v5l",
{st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/usr/local/arm/3.3.2/lib/fast-mult/half/libc.so.6",
O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/local/arm/3.3.2/lib/fast-mult/half",
0xbeadd2d8) = -1 ENOENT (No such file or directory)
open("/usr/local/arm/3.3.2/lib/fast-mult/libc.so.6",
O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/local/arm/3.3.2/lib/fast-mult",
0xbeadd2d8) = -1 ENOENT (No such file or directory)
open("/usr/local/arm/3.3.2/lib/half/libc.so.6",
O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/local/arm/3.3.2/lib/half", 0xbeadd2d8) =
-1 ENOENT (No such file or directory)
open("/usr/local/arm/3.3.2/lib/libc.so.6", O_RDONLY) =
3
read(3,
"\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0h~\1\0004"...,
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1194928,
...}) = 0
old_mmap(NULL, 1212024, PROT_READ|PROT_EXEC,
MAP_PRIVATE, 3, 0) = 0x40099000
mprotect(0x401b3000, 56952, PROT_NONE)  = 0
old_mmap(0x401b9000, 24576, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 3, 0x118000) = 0x401b9000
old_mmap(0x401bf000, 7800, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =
0x401bf000
close(3)                                = 0
mprotect(0x40099000, 1155072, PROT_READ|PROT_WRITE) =
0
mprotect(0x40099000, 1155072, PROT_READ|PROT_EXEC) = 0
mprotect(0x4001f000, 466944, PROT_READ|PROT_WRITE) = 0
mprotect(0x4001f000, 466944, PROT_READ|PROT_EXEC) = 0
ioctl(0, TIOCGWINSZ, {ws_row=0, ws_col=0, ws_xpixel=0,
ws_ypixel=0}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 opost
isig icanon echo ...}) = 0
brk(0)                                  = 0x3b000
brk(0x3c000)                            = 0x3c000
brk(0)                                  = 0x3c000
lstat64(".", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
open("/dev/null", O_RDONLY|O_NONBLOCK|O_DIRECTORY) =
-1 ENOENT (No such file or directory)
stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...})
= 0
open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY)
= 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...})
= 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
brk(0)                                  = 0x3c000
brk(0x3d000)                            = 0x3d000
getdents64(3, /* 12 entries */, 4096)   = 288
lstat64("./etc", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
lstat64("./lib", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
lstat64("./tmp", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
lstat64("./sbin", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
lstat64("./dev", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
lstat64("./var", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
lstat64("./bin", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
lstat64("./proc", {st_mode=S_IFDIR|0555, st_size=0,
...}) = 0
lstat64("./usr", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
lstat64("./root", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
getdents64(3, /* 0 entries */, 4096)    = 0
close(3)                                = 0
open("/usr/local/arm/3.3.2/etc/localtime", O_RDONLY) =
-1 ENOENT (No such file or directory)
fstat64(1, {st_mode=S_IFCHR|0644, st_rdev=makedev(4,
64), ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 opost
isig icanon echo ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
socket(PF_FILE, SOCK_STREAM, 0)         = 3
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++
Process 819 detached

... There are cases wherein the program couldn't find
the lib files it's looking for (/etc/ld.so.preload,
/usr/local/arm/3.3.2/etc/ld.so.cache) but I couldn't
find these files in the toolchain either.

... The program is also looking for the other lib
files in the v5l/, v5l/fast_mult/ folders, but
eventually find them in the /lib folder, so I'm not
sure if this might be a problem..

... Any ideas?

Thanks,

Ed

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

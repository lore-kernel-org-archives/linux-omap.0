From: Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>
Subject: Problem using gdbserver on ARM target
Date: Thu, 4 May 2006 17:35:23 +0530
Message-ID: <OF2D51E9C2.3C3CCC6A-ON65257164.00424D70-65257164.00426D5F@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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
To: linux-omap-open-source@linux.omap.com, linux-arm-toolchain@lists.arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

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

***********************  FSS-Unclassified   ***********************

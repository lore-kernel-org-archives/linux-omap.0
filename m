From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: How to build Kernel Modules
Date: Thu, 13 Jul 2006 16:00:01 +0100
Message-ID: <008301c6a68d$041f5680$642aa8c0@Buffy>
References: <20060713083220.9E5768062E@linux.omap.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060713083220.9E5768062E@linux.omap.com>
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

Hi,

I don't know if this is the right place to ask...

I have OMAP 5912OSK with a 2.6.15 kernel cross compiled from SUSE 9.2 using
GCC 3.4.1. That works and I am happy with it. I can build my own tasks and
include them into my RAM disk image.

The next challenge is to build a kernel module. I followed the guidelines in
Peter Salzman's book/FAQ/tutorial and tried to adapt it for cross compiling:

Arm-linux-gcc -c hellomod.c -Wall

This produced hellomod.o but when I tried to insmod it on my target I got an
error:

/ # ls
ascii       etc         lib         proc        sys         var
bin         hello       linuxrc     sbin        tmp
dev         hellomod.o  lost+found  sieve       usr
/ # insmod ./hellomod.o
Using ./hellomod.o
No module found in object
insmod: cannot insert `./hellomod.o': Invalid module format (-1): Exec
format error
/ # _

I suspect I haven't done something right in the build stage for my KO. 

My source code is simple and looks like this:

#define __KERNEL__
#define MODULE

#include "/usr/local/arm/3.4.1/arm-linux/include/linux/module.h"
#include "/usr/local/arm/3.4.1/arm-linux/include/linux/kernel.h"

#include "/usr/local/arm/3.4.1/arm-linux/include/linux/tty.h"

int init_module()
{
	console_print("Hello World from Rico\n");
	return 0;
}

void cleanup_module()
{
	console_print("Goodbye from Rico!\n");
}

Can somebody point me at an FAQ or how to for cross compiling Kernel Modules
please?

TIA,

Richard.

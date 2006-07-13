From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: RE: How to build Kernel Modules
Date: Thu, 13 Jul 2006 16:37:46 +0100
Message-ID: <000401c6a692$4a4c53b0$642aa8c0@Buffy>
References: <EA12F909C0431D458B9D18A176BEE4A506945C52@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A506945C52@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "'Woodruff, Richard'" <r-woodruff2@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Richard,

Thanks. I just had a look and couldn't see the wood for the trees. Do you
have a link or something that I can put into their search engine that will
get me close?

Thanks,

Richard.

-----Original Message-----
From: Woodruff, Richard [mailto:r-woodruff2@ti.com] 
Sent: 13 July 2006 16:24
To: Richard Copeman; linux-omap-open-source@linux.omap.com
Subject: RE: How to build Kernel Modules

Down load the Linux Device Drivers module examples.  It has a nice and
easy to use dummy module.  You can find them on the O'Riley site.

You can just compile and insmod .o like your trying.  There are a few
more steps.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Richard Copeman
> Sent: Thursday, July 13, 2006 8:30 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: How to build Kernel Modules
> 
> Hi,
> 
> I don't know if this is the right place to ask...
> 
> I have OMAP 5912OSK with a 2.6.15 kernel cross compiled from SUSE 9.2
> using
> GCC 3.4.1. That works and I am happy with it. I can build my own tasks
and
> include them into my RAM disk image.
> 
> The next challenge is to build a kernel module. I followed the
guidelines
> in
> Peter Salzman's book/FAQ/tutorial and tried to adapt it for cross
> compiling:
> 
> Arm-linux-gcc -c hellomod.c -Wall
> 
> This produced hellomod.o but when I tried to insmod it on my target I
got
> an
> error:
> 
> / # ls
> ascii       etc         lib         proc        sys         var
> bin         hello       linuxrc     sbin        tmp
> dev         hellomod.o  lost+found  sieve       usr
> / # insmod ./hellomod.o
> Using ./hellomod.o
> No module found in object
> insmod: cannot insert `./hellomod.o': Invalid module format (-1): Exec
> format error
> / # _
> 
> I suspect I haven't done something right in the build stage for my KO.
> 
> My source code is simple and looks like this:
> 
> #define __KERNEL__
> #define MODULE
> 
> #include "/usr/local/arm/3.4.1/arm-linux/include/linux/module.h"
> #include "/usr/local/arm/3.4.1/arm-linux/include/linux/kernel.h"
> 
> #include "/usr/local/arm/3.4.1/arm-linux/include/linux/tty.h"
> 
> int init_module()
> {
> 	console_print("Hello World from Rico\n");
> 	return 0;
> }
> 
> void cleanup_module()
> {
> 	console_print("Goodbye from Rico!\n");
> }
> 
> Can somebody point me at an FAQ or how to for cross compiling Kernel
> Modules
> please?
> 
> TIA,
> 
> Richard.
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source

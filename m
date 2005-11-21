From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: RE: Kernel not working
Date: Mon, 21 Nov 2005 14:25:18 -0000
Message-ID: <006301c5eea7$6619c080$642aa8c0@BUFFY>
References: <20051121105557.5206.qmail@web32901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20051121105557.5206.qmail@web32901.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com, 'Vineet Tuli' <vineet@cybernetra.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Many thanks for the pointers. I have taken a look at the newbie guide. I
have got a 2.6.13.4 kernel built with gcc 3.4.1 as per the instructions in
the guide. I have the kernel image tftpboot loaded onto my OSK board and
things progress a little further (but not much).

I get:

Starting kernel ...

Uncompressing Linux......................................................

And then it all stops. In the newbie guide there was a section about this
and I have added the extra head-omap.o to my Makefile in
arch/arm/boot/compressed and rebuilt but still no improvement. Grepping
through the build logs the object has been included so I'm guessing my mods
worked ;-)

On another point, my board does not allow me to save my Uboot environment.
Typing save gives me:

Saving E"@ironment to Flash...
Un-Protected 1 sectors
Erasing Flash...Can't erase unknown flash type 00000000 - aborted
Erased 1 sectors
Error: start and/or end address not on sector boundary
OMAP5912OSK#

This board is set at factory configuration and has not had Uboot updated
since I unpacked it. Is it likely that my board is not functioning
correctly?

Thanks,

Richard.

-----Original Message-----
From: Komal Shah [mailto:komal_shah802003@yahoo.com] 
Sent: 21 November 2005 10:56
To: Richard Copeman; linux-omap-open-source@linux.omap.com
Subject: Re: Kernel not working

--- Richard Copeman <richard.copeman@lauterbach.co.uk> wrote:

> Hello,
> 
>  
> 
> I'm a newbie, so please forgive me if this has been answered
> elsewhere.
> 
> I have the 2.6.8rc3 kernel source downloaded from linux.omap.com and
> have
> built with GCC 3.3.2. I have not done any tweaking in make xconfig,
> so it
> should be the standard OMAP 5912 OSK kernel. I get the vmlinux output
> which
> I put through objcopy and the appropriate mkimage for my version > of

I don't know if you need to update u-boot or not, but you can update
the kernel from 

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=log;t=7

A README for fetching the kernel tree is provided on 
http://www.muru.com/linux/omap/

You then please enable low-level debugging CONFIG_DEBUG_LL in the
kernel configuration and post the serial-output messages if any.

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com

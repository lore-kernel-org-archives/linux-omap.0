From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 4430SDP boot failure
Date: Thu, 6 Jan 2011 20:51:07 +0000
Message-ID: <20110106205107.GI1198@n2100.arm.linux.org.uk>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk> <20110106180030.GA8249@n2100.arm.linux.org.uk> <20110106182023.GV7771@atomide.com> <20110106195225.GX7771@atomide.com> <20110106203431.GZ7771@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52499 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab1AFUvP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 15:51:15 -0500
Content-Disposition: inline
In-Reply-To: <20110106203431.GZ7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, Jan 06, 2011 at 12:34:32PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [110106 11:52]:
> > --- a/arch/arm/boot/compressed/head.S
> > +++ b/arch/arm/boot/compressed/head.S
> > @@ -71,6 +71,23 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
> >  		mov	\rb, #0x50000000
> >  		add	\rb, \rb, #0x4000 * CONFIG_S3C_LOWLEVEL_UART_PORT
> >  		.endm
> > +#elif defined(CONFIG_ARCH_OMAP2PLUS)
> > +#include <plat/multi.h>
> > +#ifdef MULTI_OMAP2)
>                      ^
> Looks like my last change to this patch from if defined to ifdef
> broke the warning above with an unbalanced bracket..
> 
> Thanks Nishant for catching that, updated patch below.

Just tried that patch, but I now have bigger problems:

OMAP44XX SDP # mmcinit 0
OMAP44XX SDP # fatload mmc 0 0x80300000 uImage-test

0 bytes read
OMAP44XX SDP #

God knows why it's doing this now, as the file is present on the SD
card:

-rwxr-xr-x. 1 rmk rmk 1836636 Jan  6 20:35 uImage-test

is what's on the SD card - with no FAT errors:

$ fsck.msdos /dev/mmcblk0p1
dosfsck 3.0.1, 23 Nov 2008, FAT32, LFN
/dev/mmcblk0p1: 8 files, 10249/142266 clusters

The file's not corrupt either:

$ md5sum /media/boot/uImage-test
be3edd928f1dbb3c15215b1a8a62fa1f  /media/boot/uImage-test
$ md5sum ../build/omap4/arch/arm/boot/uImage
be3edd928f1dbb3c15215b1a8a62fa1f  ../build/omap4/arch/arm/boot/uImage

Nope, still won't work:

OMAP44XX SDP # setenv bootargs 'root=/dev/mmcblk0p2 rw mem=512M vmalloc=1G console=ttyO2,115200n8 rootdelay=2'
OMAP44XX SDP # mmcinit 0
OMAP44XX SDP # fatload mmc 0 0x80300000 uImage-test

0 bytes read
OMAP44XX SDP #

However, it can still boot the uImage contained on the SD card, so the
card must be okay, and the SDP must still be able to successfully read
from the card.  I can only assume that uboot's FAT support is buggered
in some way.

We _really_ need a _decent_ boot loader on these boards, one which can
do network booting _and_ can be configured to do so from bootup.  SD
cards just don't hack it for kernel development.  It's a far too long-
winded process for each cycle, and with all the additional problems
(such as SD cards not being recognised 50% of the time, FAT filesystem
bugs in boot loaders, etc) it's really not funny.

So, I give up at this point with the OMAP4430SDP board.  It's not worth
spending the time with this kind of unreliability.

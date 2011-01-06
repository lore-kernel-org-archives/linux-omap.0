From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4430SDP boot failure
Date: Thu, 6 Jan 2011 10:20:23 -0800
Message-ID: <20110106182023.GV7771@atomide.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk>
 <20110106180030.GA8249@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39531 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab1AFSUf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 13:20:35 -0500
Content-Disposition: inline
In-Reply-To: <20110106180030.GA8249@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110106 10:00]:
> On Thu, Jan 06, 2011 at 05:08:05PM +0000, Russell King - ARM Linux wrote:
> > This looks like something's rather broken on OMAP4 too - even with the
> > DEBUG_LL stuff enabled and my printk hack, I get nothing more, same with
> > vanilla 2.6.37.  So, no OMAP platform I have seems to be usable with
> > 2.6.37...
> > 
> > It's worth noting that the kernel which was originally supplied with the
> > board works fine (2.6.31-00682-g49ab82a-dirty) with this uboot, as have
> > previous kernels I've built.
> > 
> > Is there yet an updated uboot for this platform which works with ethernet,
> > and which has the uboot environment saving implemented?  Or are we stuck
> > with having to catch uboot before it runs the default settings and paste
> > the commands in each time?  Also, if possible please extend the default
> > timeout - I can only just get from the board to the terminal to stop it
> > booting the default environment.
> > 
> > For TI folk: it may be an idea to make X-loader say why it's hanging so
> > that we know what is going on.
> 
> And another thing: turning on DEBUG in the decompressor breaks the build
> on OMAP:
> 
> `.data' referenced in section `.text' of arch/arm/boot/compressed/head.o: defined in discarded section `.data' of arch/arm/boot/compressed/head.o
> `.data' referenced in section `.text' of arch/arm/boot/compressed/head.o: defined in discarded section `.data' of arch/arm/boot/compressed/head.o
> 
> Is there a reason why this:
> 
>                 .pushsection .data
> omap_uart_phys: .word   0
> omap_uart_virt: .word   0
> omap_uart_lsr:  .word   0
>                 .popsection
> 
> can't be in the BSS section?

BSS works too, got a patch for that?
 
> With that fixed, and a debug version of the decompressor built, when I
> load and run this I get the same results - without the debugging output.
> If I put additional debugging earlier in the decompressor, I don't see
> it decompressing the kernel at all.
> 
> Therefore, I believe the debugging address calculation stuff in
> arch/arm/mach-omap2/include/mach/debug-macros.S to be rather broken,
> causing an abort when it tries to access the serial port.

Can you please check if you have some older bootloader that passes
some wrong machine ID? 

Tony

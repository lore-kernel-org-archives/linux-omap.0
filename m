From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] omap: Add support for CONFIG_AUTO_ZRELADDR for
 DEBUG_LL
Date: Fri, 4 Feb 2011 09:02:50 -0800
Message-ID: <20110204170249.GV3322@atomide.com>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
 <20110204012709.26410.78100.stgit@baageli.muru.com>
 <alpine.LFD.2.00.1102032205140.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28977 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab1BDRDN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 12:03:13 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102032205140.12104@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Nicolas Pitre <nico@fluxnic.net> [110203 19:32]:
> On Thu, 3 Feb 2011, Tony Lindgren wrote:
> 
> > This way we can have the debug-macro.S be common for omap1 and omap2+
> > and get sensible error messages booting the wrong zImage with
> > CONFIG_AUTO_ZRELADDR selected. Note that this does not seem to work
> > with u-boot and uImage.
...
 
> Gaaaaah!  This is horrible.

-ENOREGISTERS :)
 
> OK, you do want to store data in memory, right?  So the best way to 
> always be position independent, even cross section, is to do the 
> following (inspired by RMK's trick in the p2v series):
> 
> 	.data
> 
> foo:	.word	0	@ value for sput
> 	.word	0	@ value for nik
> 
> 	.text
> 
> bar:	.word	.
> 	.word	foo
> 
> sputnik:
> 
> 	adr	r0, bar		@ get relative address of bar
> 	ldr	r1, [r0]	@ get absolute address of bar
> 	sub	r1, r1, r0	@ difference between abs and rel address
> 	ldr	r0, [r0, #4]	@ get absolute address of foo
> 	sub	r0, r0, r1	@ turn that into a relative address
> 
> 	ldmia	r0, {r1, r2}	@ retrieve sput and nik
> 	add	r0, r1, r2
> 	mov	pc, lr
> 
> This code is totally position independent, so it works whether or not 
> the MMU is active.  Therefore a similar technique in your macro (you 
> could even put it into a macro for it) would allow you to get rid of the 
> mrc and test for MMU active, get rid of the #ifdef, and not be limited 
> to a 128 MB mask, etc.  And it is just one word longer than your 
> shortest version i.e. 2 constants + 5 instructions vs 4 instructions + 2 
> literal pool entries.

I think if we keep the address of the memory location in rx instead of
the port address value, then this could be done.

That would limit all the trickery to inituart only. Then addruart and
busyuart could just do ldr from the memory location to get the port
data without any trickery.

In that case the mapping of IO space for the serial port in head.S
would have to be changed as that relies on rx containing the port
IO address..

Regards,

Tony

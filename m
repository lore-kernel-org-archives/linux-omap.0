From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code
 generic
Date: Sat, 16 Jan 2010 12:00:03 -0800
Message-ID: <20100116200003.GL10318@atomide.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
 <20100116013515.10065.30649.stgit@baageli.muru.com>
 <20100116093555.GA13596@n2100.arm.linux.org.uk>
 <20100116191820.GI10318@atomide.com>
 <20100116193313.GA23092@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53314 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab0APUAH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Jan 2010 15:00:07 -0500
Content-Disposition: inline
In-Reply-To: <20100116193313.GA23092@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100116 11:31]:
> On Sat, Jan 16, 2010 at 11:18:20AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100116 01:33]:
> > > On Fri, Jan 15, 2010 at 05:35:15PM -0800, Tony Lindgren wrote:
> > > > diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
> > > > index 23e4724..0174858 100644
> > > > --- a/arch/arm/mach-omap1/include/mach/debug-macro.S
> > > > +++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
> > > > @@ -15,18 +15,71 @@
> > > >  
> > > >  #include <plat/serial.h>
> > > >  
> > > > +omap_uart_phys:	.word	0x0
> > > > +omap_uart_virt:	.word	0x0
> > > 
> > > I assume that you have no plans for XIP kernel support on OMAP, since
> > > these will be placed in the .text section, and is therefore read-only
> > > on XIP kernels.
> > 
> > Did not think of that.. Maybe some addruart_premable solution here would.
> > Or adding \tmp register for addruart and just do the detection for each
> > character.
> 
> How does doing it per-character help?  The code is:
> 
> ENTRY(printascii)
>                 addruart r3
>                 b       2f
> 1:              waituart r2, r3
>                 senduart r1, r3
>                 busyuart r2, r3
>                 teq     r1, #'\n'
>                 moveq   r1, #'\r'
>                 beq     1b
> 2:              teq     r0, #0
>                 ldrneb  r1, [r0], #1
>                 teqne   r1, #0
>                 bne     1b
>                 mov     pc, lr
> 
> Your wait/send/busy macros are just using the already provided base
> address which comes via r3 from addruart.  That much is fine.
> 
> I'm at a loss to understand why you think moving the address-getting
> functionality out of addruart into the individual wait/send/busy
> macros is going to help in any way.

Sorry, I meant doing the detection each time addruart is run, not
for each character.
 
> Why not do something like this:
> 
> 		.pushsection .data
> omap_uart_phys:	.word 0
> omap_uart_virt:	.word 0
> 		.popsection
> 
> 		.macro addruart, rx
> ...		
> +               ldreq   \rx, =omap_uart_phys    @ physical base address
> +               ldrne   \rx, =omap_uart_virt    @ virtual base
> 		ldr	\rx, [\rx]
> +               cmp     \rx, #0                 @ is port configured?
> +               bne     99f                     @ already configured
> ...
> 
> ?

Sounds good to me. Will play with them and post refreshed patches.

Regards,

Tony

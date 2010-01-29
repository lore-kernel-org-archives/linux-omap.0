From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] OMAP4: Add L2 Cache support
Date: Fri, 29 Jan 2010 14:30:02 +0000
Message-ID: <20100129143002.GD16712@n2100.arm.linux.org.uk>
References: <1264765589-18353-1-git-send-email-santosh.shilimkar@ti.com> <1264767365.4242.54.camel@pc1117.cambridge.arm.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C09C688C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38263 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab0A2OaX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 09:30:23 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C09C688C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 29, 2010 at 05:56:55PM +0530, Shilimkar, Santosh wrote:
> Thanks for quick comment.
> > -----Original Message-----
> > From: Catalin Marinas [mailto:catalin.marinas@arm.com]
> > Sent: Friday, January 29, 2010 5:46 PM
> > To: Shilimkar, Santosh
> > Cc: tony@atomide.com; linux-arm-kernel@lists.infradead.org; rmk@arm.linux.org.uk; linux-
> > omap@vger.kernel.org
> > Subject: Re: [PATCH 1/3] OMAP4: Add L2 Cache support
> > 
> > On Fri, 2010-01-29 at 11:46 +0000, Santosh Shilimkar wrote:
> > > +#ifdef CONFIG_CACHE_L2X0
> > > +static int __init omap_l2_cache_init(void)
> > > +{
> > > +       void __iomem *l2cache_base;
> > > +
> > > +       /* Static mapping, never released */
> > > +       l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
> > > +       BUG_ON(!l2cache_base);
> > > +
> > > +       /* Enable L2 Cache using secure api
> > > +        * r0 contains the value to be modified and "r12" contains
> > > +        * the monitor API number. This API uses few CPU registers
> > > +        * internally and hence they need be backed up including
> > > +        * link register "lr".
> > > +        */
> > > +       __asm__ __volatile__(
> > > +               "stmfd r13!, {r0-r12, r14}\n"
> > > +               "mov r0, #1\n"
> > > +               "ldr r12, =0x102\n"
> > > +               "dsb\n"
> > > +               "smc\n"
> > > +               "ldmfd r13!, {r0-r12, r14}");
> > 
> > Same comments as on the cache-l2x0.c changes - can you not let the
> > compiler choose what to saved by declaring the clobbered register in the
> > asm directive?
>
> Since this code was used only ones in init, I haven't converted it to
> function. With clobber list as well as you know adding r12 to clobber
> list, compiler don't generate the save code and r11 can't be added to
> clobber list.

Well, we seem to have two places with the same code structure.  Let's
pull them together into a common function, such as:

void omap_smc1(u32 fn, u32 arg)
{
	register u32 r12 asm("r12") = fn;
	register u32 r0 asm("r0") = arg;
	asm volatile(
		"str r11, [sp], #-4\n"
		"dsb\n"
		"smc\n"
		"ldr r11, [sp, #4]!"
		: "+r" (r0), "+r" (r12)
		:
		: "r0-r10", "lr", "cc");
}
EXPORT_SYMBOL(omap_smc1);

The code there probably may not be Thumb-2 compatible.

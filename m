From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Mon, 7 Feb 2011 10:18:29 +0000
Message-ID: <20110207101829.GA32431@n2100.arm.linux.org.uk>
References: <20110125121655.GD13300@n2100.arm.linux.org.uk> <4534e82bf14eeea9f96769df760df5ae@mail.gmail.com> <20110125125656.GG13300@n2100.arm.linux.org.uk> <20110125130422.GH13300@n2100.arm.linux.org.uk> <20110125130611.GA15663@n2100.arm.linux.org.uk> <627ff975140c8e4afbad281105b29d35@mail.gmail.com> <20110204104113.GD15004@n2100.arm.linux.org.uk> <c703383234131695d040a1e5b8a79413@mail.gmail.com> <20110204113053.GF15004@n2100.arm.linux.org.uk> <247f9ef444eeb8ca59de74837a3e9c62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44744 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab1BGKSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 05:18:47 -0500
Content-Disposition: inline
In-Reply-To: <247f9ef444eeb8ca59de74837a3e9c62@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ccross@android.com

On Mon, Feb 07, 2011 at 03:21:44PM +0530, Santosh Shilimkar wrote:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Friday, February 04, 2011 5:01 PM
> > To: Santosh Shilimkar
> > Cc: catalin.marinas@arm.com; linus.ml.walleij@gmail.com; linux-
> > omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > ccross@android.com
> > Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> > file
> >
> [.....]
> 
> > 8<------
> > Subject: [PATCH] ARM: smp: add function to set WFI low-power mode
> > for SMP CPUs
> >
> > Add a function to set the SCU low-power mode for SMP CPUs.  This
> > centralizes this functionality rather than having to expose the
> > SCU register definitions to each platform.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/include/asm/smp_scu.h |    5 +++++
> >  arch/arm/kernel/smp_scu.c      |   24 ++++++++++++++++++++++++
> >  2 files changed, 29 insertions(+), 0 deletions(-)
> >
> 
> [....]
> 
> > diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
> > index 9ab4149..0ba329a 100644
> > --- a/arch/arm/kernel/smp_scu.c
> > +++ b/arch/arm/kernel/smp_scu.c
> > @@ -50,3 +50,27 @@ void __init scu_enable(void __iomem *scu_base)
> >  	 */
> >  	flush_cache_all();
> >  }
> > +
> > +/*
> > + * Set the executing CPUs power mode as defined.  This will be in
> > + * preparation for it executing a WFI instruction.
> > + *
> > + * This function must be called with preemption disabled, and as it
> > + * has the side effect of disabling coherency, caches must have
> > been
> > + * flushed.  Interrupts must also have been disabled.
> > + */
> > +int scu_power_mode(void __iomem *scu_base, unsigned int mode)
> > +{
> > +	unsigned int val;
> > +	int cpu = smp_processor_id();
> > +	int shift;
> shift is unused with this version now so I am removing it.

Yes, I noticed that - it's gone in the version I merged into my tree.

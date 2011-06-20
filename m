From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/10] omap: Use separate init_irq functions to avoid
 cpu_is_omap tests early
Date: Mon, 20 Jun 2011 03:14:25 -0700
Message-ID: <20110620101424.GH23145@atomide.com>
References: <20110620091754.357.56441.stgit@kaulin>
 <20110620092327.357.92354.stgit@kaulin>
 <20110620095445.GB2082@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22764 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752955Ab1FTKOc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 06:14:32 -0400
Content-Disposition: inline
In-Reply-To: <20110620095445.GB2082@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110620 02:50]:
> On Mon, Jun 20, 2011 at 02:23:28AM -0700, Tony Lindgren wrote:
> >  void __init gic_init_irq(void)
> >  {
> > -	void __iomem *gic_cpu_base;
> > -
> >  	/* Static mapping, never released */
> >  	gic_dist_base_addr = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
> >  	BUG_ON(!gic_dist_base_addr);
> >  
> >  	/* Static mapping, never released */
> > -	gic_cpu_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
> > -	BUG_ON(!gic_cpu_base);
> > +	omap_irq_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
> > +	BUG_ON(!omap_irq_base);
> >  
> > -	gic_init(0, 29, gic_dist_base_addr, gic_cpu_base);
> > +	gic_init(0, 29, gic_dist_base_addr, omap_irq_base);
> 
> Why do you change this?  Nothing should be using 'omap_irq_base' directly
> because it doesn't know what type of interrupt controller you have.

We need to set omap_irq_base for entry-macro.S for the MULTI_OMAP2 case.
So no need to have separate gic_cpu_base for gic_init_irq.
 
> The GIC IRQ entry code should be using gic_cpu_base_addr provided by the
> common gic driver rather than anything else.

You mean for get_irqnr_and_base? That is the case when we don't
have omap2 or 3 compiled in with omap4. For the multi-omap case
we are using omap_irq_base for get_irqnr_and_base as we need to
handle two different kind of irq controllers.

Regards,

Tony

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Latest regressions
Date: Thu, 27 Jan 2011 12:22:45 +0000
Message-ID: <20110127122245.GB26418@n2100.arm.linux.org.uk>
References: <20110107115744.GL1198@n2100.arm.linux.org.uk> <20110107165626.GD880@atomide.com> <20110126085848.GB2698@n2100.arm.linux.org.uk> <20110126181215.GC23412@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46085 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab1A0MWv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 07:22:51 -0500
Content-Disposition: inline
In-Reply-To: <20110126181215.GC23412@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Wed, Jan 26, 2011 at 10:12:16AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110126 00:57]:
> > On Fri, Jan 07, 2011 at 08:56:26AM -0800, Tony Lindgren wrote:
> > > > diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> > > > index e66687b..c203204 100644
> > > > --- a/arch/arm/mach-omap2/io.c
> > > > +++ b/arch/arm/mach-omap2/io.c
> > > > @@ -314,14 +314,13 @@ static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
> > > >  	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
> > > >  }
> > > >  
> > > > +void __iomem *omap_irq_base;
> > > > +
> > > >  /*
> > > >   * Initialize asm_irq_base for entry-macro.S
> > > >   */
> > > >  static inline void omap_irq_base_init(void)
> > > >  {
> > > > -	extern void __iomem *omap_irq_base;
> > > > -
> > > > -#ifdef MULTI_OMAP2
> > > >  	if (cpu_is_omap24xx())
> > > >  		omap_irq_base = OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE);
> > > >  	else if (cpu_is_omap34xx())
> > > > @@ -330,7 +329,6 @@ static inline void omap_irq_base_init(void)
> > > >  		omap_irq_base = OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE);
> > > >  	else
> > > >  		pr_err("Could not initialize omap_irq_base\n");
> > > > -#endif
> > > >  }
> > > >  
> > > >  void __init omap2_init_common_infrastructure(void)
> > > 
> > > This looks good to me.
> > 
> > I notice this one is still there.
> 
> Sorry I thought you'll queue this one.
> 
> BTW this fixes regression from patch 5d190c40100793a6dfc37bf325677c10f3c80edf
> (omap2+: Initialize omap_irq_base for entry-macro.S from platform code).
> So it should be OK for the -rc cycle:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Let me know if you want me to take it, in that case I think it's still
> missing your Signed-off-by.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

> Let me know if you want me to queue it.

Yes please.

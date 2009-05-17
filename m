From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESUBMIT][PATCH 5/7] OMAP4: Update common omap machine
	specific sources.
Date: Sun, 17 May 2009 16:32:07 +0100
Message-ID: <20090517153207.GA6585@n2100.arm.linux.org.uk>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-5-git-send-email-santosh.shilimkar@ti.com> <20090516100732.GK15328@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02B4904319@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59334 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbZEQPcP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 17 May 2009 11:32:15 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B4904319@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, May 17, 2009 at 06:30:27PM +0530, Shilimkar, Santosh wrote:
> Russell,
> 
> > > diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> > > index 916fcd3..6db7791 100644
> > > --- a/arch/arm/mach-omap2/io.c
> > > +++ b/arch/arm/mach-omap2/io.c
> > > @@ -200,7 +247,9 @@ void __init omap2_init_common_hw(struct 
> > omap_sdrc_params *sp)
> > >  	omap2_mux_init();
> > >  	pwrdm_init(powerdomains_omap);
> > >  	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
> > > +#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the 
> > clkdev is ready */
> > >  	omap2_clk_init();
> > > +#endif
> > >  	omap2_sdrc_init(sp);
> > >  	gpmc_init();
> > >  }
> > 
> > I'm not sure why:
> > 
> > 1. you're using a (possible) run time check in sdrc.c, 
> > clockdomain.c and
> >    powerdomain.c, but a compile time check in io.c
> This one I explained in the last email. And till we have the clean up
> done on clock.h I can't remove the compile time switch even though it
> looks ugly.

There's no point in using run-time checks here though.  This is a
temporary hack until OMAP4 gets the proper clock/clockdomain/powerdomain/
sdrc support.

Until that happens, there's no point in mixing this stuff up and making
more review work.  So just accept that OMAP4 won't live with anything
but itself for the time being and do as:

 	omap2_mux_init();
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
 	omap2_sdrc_init(sp);
+#endif
 	gpmc_init();

Nice and simple, fewer files touched and obvious what's going on.

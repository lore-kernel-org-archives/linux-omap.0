From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RESUBMIT][PATCH 5/7] OMAP4: Update common omap machine
	specific sources.
Date: Mon, 18 May 2009 09:29:59 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B49043B1@dbde02.ent.ti.com>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-5-git-send-email-santosh.shilimkar@ti.com>
 <20090516100732.GK15328@n2100.arm.linux.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B4904319@dbde02.ent.ti.com>
 <20090517153207.GA6585@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56534 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbZEREA3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 00:00:29 -0400
In-Reply-To: <20090517153207.GA6585@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Sunday, May 17, 2009 9:02 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
> linux-omap@vger.kernel.org
> Subject: Re: [RESUBMIT][PATCH 5/7] OMAP4: Update common omap 
> machine specific sources.
> 
> On Sun, May 17, 2009 at 06:30:27PM +0530, Shilimkar, Santosh wrote:
> > Russell,
> > 
> > > > diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> > > > index 916fcd3..6db7791 100644
> > > > --- a/arch/arm/mach-omap2/io.c
> > > > +++ b/arch/arm/mach-omap2/io.c
> > > > @@ -200,7 +247,9 @@ void __init omap2_init_common_hw(struct 
> > > omap_sdrc_params *sp)
> > > >  	omap2_mux_init();
> > > >  	pwrdm_init(powerdomains_omap);
> > > >  	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
> > > > +#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the 
> > > clkdev is ready */
> > > >  	omap2_clk_init();
> > > > +#endif
> > > >  	omap2_sdrc_init(sp);
> > > >  	gpmc_init();
> > > >  }
> > > 
> > > I'm not sure why:
> > > 
> > > 1. you're using a (possible) run time check in sdrc.c, 
> > > clockdomain.c and
> > >    powerdomain.c, but a compile time check in io.c
> > This one I explained in the last email. And till we have 
> the clean up
> > done on clock.h I can't remove the compile time switch even 
> though it
> > looks ugly.
> 
> There's no point in using run-time checks here though.  This is a
> temporary hack until OMAP4 gets the proper 
> clock/clockdomain/powerdomain/
> sdrc support.
> 
> Until that happens, there's no point in mixing this stuff up 
> and making
> more review work.  So just accept that OMAP4 won't live with anything
> but itself for the time being and do as:
> 
>  	omap2_mux_init();
> +#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the 
> clkdev is ready */
>  	pwrdm_init(powerdomains_omap);
>  	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
>  	omap2_clk_init();
>  	omap2_sdrc_init(sp);
> +#endif
>  	gpmc_init();
> 
> Nice and simple, fewer files touched and obvious what's going on.

Thanks and I completely agree with you.

Regards,
Santosh
 
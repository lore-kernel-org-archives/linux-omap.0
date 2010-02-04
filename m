From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2/3/4: ioremap address space
Date: Thu, 4 Feb 2010 13:50:54 -0800
Message-ID: <20100204215054.GT22747@atomide.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C0B426A2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60258 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757770Ab0BDVuY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 16:50:24 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C0B426A2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100204 11:45]:
> Tony,
> 
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Wednesday, January 27, 2010 11:14 AM
> To: Tony Lindgren
> Cc: linux-omap@vger.kernel.org; Kevin Hilman
> Subject: RE: [PATCH] OMAP2/3/4: ioremap address space
> 
> <snip>
> 
> > > >  void __iomem *omap_ctrl_base_get(void)
> > > > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > > > index a091b53..fb5921b 100644
> > > > --- a/arch/arm/mach-omap2/id.c
> > > > +++ b/arch/arm/mach-omap2/id.c
> > > > @@ -407,7 +407,12 @@ void __init omap2_check_revision(void)
> > > >  void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
> > > >  {
> > > >  	omap_revision = omap2_globals->class;
> > > > -	tap_base = omap2_globals->tap;
> > > > +
> > > > +	/* Static mapping, never released */
> > > > +	if (omap2_globals->tap) {
> > > > +		tap_base = ioremap(omap2_globals->tap, SZ_4K);
> > > > +		WARN_ON(!tap_base);
> > > > +	}
> > > >
> > > >  	if (cpu_is_omap34xx())
> > > >  		tap_prod_id = 0x0210;
> > >
> > > Nice clean-up.
> > >
> > > We need to check carefully that the cpu detection is done by the time
> > > we do the ioremap.. Initially we only know the machine class such as
> > > 34xx/24xx.
> > Machine class is good enough to select the correct omap_global descriptor.

Yeah but ioremap uses cpu_is_omap2420() and cpu_is_omap2430(), so we can't
use that for setting tap_base. Basically ioremap() won't work in this
case until omap2_check_revision() is done.

I _think_ the others are safe..

> > Isn't it ?
> > > We have at least cpu_is_omap2420 and cpu_is_omap2430 being used in io.c,
> > > so all these mappings may not work properly.
> > >
> > > Also, we should merge this as one patch to keep the system booting
> > > between the patches.
> > Git bisect would be problem. We can merge them together.
> Merged patch attached.
> 
> How do we proceed with this? I can test this patch with omap3_defconfig and see if
> the Image works on OMAP3430, OMAP3630 and OMAP4430 SDPs.

How about leave tap changes from this patcht, and ioremap the rest?

Then let's try it out in l-o master for next few weeks and then merge
it assuming things are OK.

Regards,

Tony

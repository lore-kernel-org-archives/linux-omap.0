From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] omap: Clean the serial port defines
Date: Sat, 16 Jan 2010 12:03:20 -0800
Message-ID: <20100116200320.GM10318@atomide.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
 <20100116013510.10065.59461.stgit@baageli.muru.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C06F9005@dbde02.ent.ti.com>
 <20100116192538.GK10318@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C06F906A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59459 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab0APUDN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Jan 2010 15:03:13 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C06F906A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100116 11:31]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com] 
> > Sent: Sunday, January 17, 2010 12:56 AM
> > To: Shilimkar, Santosh
> > Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 1/4] omap: Clean the serial port defines
> > 
> > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100115 23:46]:
> > > Thanks for the nice cleanup.
> > 
> > Thanks for testing :)
> > 
> > > <snip>
> > > > --- a/arch/arm/plat-omap/include/plat/common.h
> > > > +++ b/arch/arm/plat-omap/include/plat/common.h
> > > > @@ -47,6 +47,10 @@ struct omap_globals {
> > > >  	void __iomem	*prm;		/* Power and Reset Management */
> > > >  	void __iomem	*cm;		/* Clock Management */
> > > >  	void __iomem	*cm2;
> > > > +	unsigned long	uart1_phys;
> > > > +	unsigned long	uart2_phys;
> > > > +	unsigned long	uart3_phys;
> > > > +	unsigned long	uart4_phys;
> > > Considering they are register base address, can
> > > these be declared as "void __iomem" instead of "unsigned long"
> > 
> > These are physical addresses instead of virtual addresses.
> > They get ioremapped in mach-omap[12]/serial.c. So they should
> > not be void __iomem * in omap_globals.
> Yep. I see your point.  
> > BTW, we should eventually change everything in omap_globals
> > to be physical addresses.
> We did some work for OMAP4 to move most of the things to ioremap
> istead of those hardcoded macros. 
> Let me know when you want to do this clean up. We can do this together.

Great, let's try get some more of that ready for the upcoming
merge window.

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] omap2/3/4: mailbox: remove compiler warning
Date: Mon, 22 Feb 2010 13:37:13 -0800
Message-ID: <20100222213713.GT18786@atomide.com>
References: <2C1563023E232C49B9F505633D57C2DA2640D0235B@dlee04.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C417FF8B@dbde02.ent.ti.com>
 <2C1563023E232C49B9F505633D57C2DA2640E025F9@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60669 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab0BVVgS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 16:36:18 -0500
Content-Disposition: inline
In-Reply-To: <2C1563023E232C49B9F505633D57C2DA2640E025F9@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Anna, Suman" <s-anna@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Clark, Rob" <rob@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>

* Anna, Suman <s-anna@ti.com> [100222 11:53]:
> Hi Santosh,
> 
> > -----Original Message-----
> > From: Shilimkar, Santosh
> > Sent: Saturday, February 20, 2010 12:47 PM
> > To: Anna, Suman; linux-omap@vger.kernel.org
> > Cc: Hiroshi.DOYU@nokia.com; Clark, Rob; Kanigeri, Hari; C.A, Subramaniam
> > Subject: RE: [PATCH 1/5] omap2/3/4: mailbox: remove compiler warning
> > 
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Anna,
> > > Suman
> > > Sent: Friday, February 19, 2010 2:37 AM
> > > To: linux-omap@vger.kernel.org
> > > Cc: Hiroshi.DOYU@nokia.com; Clark, Rob; Kanigeri, Hari; C.A, Subramaniam
> > > Subject: [PATCH 1/5] omap2/3/4: mailbox: remove compiler warning
> > >
> > > From 78d00b562548e1d95ad12a4d8121be67950daf68 Mon Sep 17 00:00:00 2001
> > > From: Suman Anna <s-anna@ti.com>
> > > Date: Mon, 25 Jan 2010 18:27:21 -0600
> > > Subject: [PATCH 1/5] omap2/3/4: mailbox: remove compiler warning
> > >
> > > Remove a compiler warning in device-specific
> > > mailbox module.
> > >
> > > Signed-off-by: Suman Anna <s-anna@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/mailbox.c |    2 ++
> > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-
> > omap2/mailbox.c
> > > index 2c9fd1c..c970cf6 100644
> > > --- a/arch/arm/mach-omap2/mailbox.c
> > > +++ b/arch/arm/mach-omap2/mailbox.c
> > > @@ -419,8 +419,10 @@ static int __devinit omap2_mbox_probe(struct
> > platform_device *pdev)
> > >  #endif
> > >  	return 0;
> > >
> > > +#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
> > >  err_iva1:
> > >  	omap_mbox_unregister(&mbox_dsp_info);
> > > +#endif
> > Can't we avoid the #ifdef here? Is this "omap_mbox_unregister" omap2
> > specific?
> 
> Yes, this #ifdef is specific to 2420. There are other places in the mailbox code which also utilize a similar #ifdef. I have merely added it to remove the compile warning. I think it needs a separate patch to remove all the 2420 specific #ifdefs.

Let's drop this patch for now. We should fix this with something like
this in mailbox.h:

#ifdef CONFIG_ARCH_OMAP2420
int omap_mbox_unregister(struct omap_mbox *);
#else
static inline int omap_mbox_unregister(struct omap_mbox *mbox)
{
	return 0;
}
#endif

That way we can get rid of the ifdefs in other places too.

Tony

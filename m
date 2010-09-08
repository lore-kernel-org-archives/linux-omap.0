From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpmc, EXPORT_SYMBOLS, west bridge related
Date: Wed, 8 Sep 2010 10:30:40 -0700
Message-ID: <20100908173040.GP22507@atomide.com>
References: <1283887607.7250.10.camel@odc-laptop>
 <20100907235800.GD12823@kroah.com>
 <701AE2655D844F9AAB5F2492AD477066@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51592 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab0IHRal (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 13:30:41 -0400
Content-Disposition: inline
In-Reply-To: <701AE2655D844F9AAB5F2492AD477066@stanford.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cross <david.cross@cypress.com>
Cc: 'Greg KH' <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

* David Cross <david.cross@cypress.com> [100908 09:52]:
> 
> > From: Greg KH [mailto:greg@kroah.com] 
> 
> > On Tue, Sep 07, 2010 at 12:26:47PM -0700, David Cross wrote:
> > > This patch exports some of the gpmc driver functions in OMAP3. The
> purpose behind this patch 
> > > is to allow device drivers compiled as loadable modules to be interfaced
> > to the GPMC. I am
> > > hoping that Tony is the correct maintainer and willing to ACK this
> change. Please let me know 
> > > if there are any issues or concerns with this patch.
> > > Thanks,
> > > David
> > > 
> > > Signed-off-by: David Cross <david.cross@cypress.com>
> > > 
> > > diff -uprN -X linux-next-vanilla/Documentation/dontdiff
> linux-next-vanilla/arch/arm/mach-omap2/gpmc.c
> linux-next-incl-sdk/arch/arm/mach-omap2/gpmc.c
> > > --- linux-next-vanilla/arch/arm/mach-omap2/gpmc.c	2010-08-31
> 19:32:51.000000000 -0700
> > > +++ linux-next-incl-sdk/arch/arm/mach-omap2/gpmc.c	2010-09-01
> 16:10:21.000000000 -0700
> > > @@ -133,6 +133,7 @@ void gpmc_cs_write_reg(int cs, int idx, 
> > >  	reg_addr = gpmc_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
> > >  	__raw_writel(val, reg_addr);
> > >  }
> > > +EXPORT_SYMBOL(gpmc_cs_write_reg);
> 
> > EXPORT_SYMBOL_GPL() perhaps?
> 
> I don't have an issue with that, though I am not sure I understand why we
> would want to limit the usage of the function to GPL'd modules. It is
> probably Tony's call assuming he is ok with exporting the symbol.

Exporting these is not a good idea, it should be done in the platform
init code like I replied in another message.

Regards,

Tony

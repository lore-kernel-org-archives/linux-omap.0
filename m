From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3]NAND: OMAP: Fixing omap nand driver, compiled as
 module
Date: Tue, 10 Nov 2009 10:56:21 -0800
Message-ID: <20091110185621.GB23952@atomide.com>
References: <ce9ab5790910292321y1e7239b7pbffe9a5891d66448@mail.gmail.com>
 <ce9ab5790910300142kf12e31cpd6249d4c7383553f@mail.gmail.com>
 <ce9ab5790910300227r41d42673webad0ee48e3444d1@mail.gmail.com>
 <1257862989.21596.763.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59158 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757579AbZKJS4U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 13:56:20 -0500
Content-Disposition: inline
In-Reply-To: <1257862989.21596.763.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Vimal Singh <vimal.newwork@gmail.com>, Linux MTD <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org

* Artem Bityutskiy <dedekind1@gmail.com> [091110 06:22]:
> On Fri, 2009-10-30 at 14:57 +0530, Vimal Singh wrote:
> > Last time I forgot to 'git add' for 'arch/arm/mach-omap2/gpmc.c'... My bad.
> > Correct patch is below.
> > 
> > -vimal
> > 
> > 
> > From: Vimal Singh <vimalsingh@ti.com>
> > Date: Fri, 30 Oct 2009 14:54:29 +0530
> > Subject: [PATCH] NAND: OMAP: Fixing omap nand driver, compiled as module
> > 
> > Removing OMAP NAND driver, when loaded as a module, gives error and
> > does not get success. This fixes this and makes driver loadable and
> > removable run time.
> > 
> > Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> > ---
> >  arch/arm/mach-omap2/gpmc.c |    2 ++
> >  drivers/mtd/nand/omap2.c   |    5 ++++-
> >  2 files changed, 6 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> > index 1587682..1d10b7b 100644
> > --- a/arch/arm/mach-omap2/gpmc.c
> > +++ b/arch/arm/mach-omap2/gpmc.c
> > @@ -88,6 +88,7 @@ void gpmc_cs_write_reg(int cs, int idx, u32 val)
> >  	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
> >  	__raw_writel(val, reg_addr);
> >  }
> > +EXPORT_SYMBOL(gpmc_cs_write_reg);
> > 
> >  u32 gpmc_cs_read_reg(int cs, int idx)
> >  {
> > @@ -96,6 +97,7 @@ u32 gpmc_cs_read_reg(int cs, int idx)
> >  	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
> >  	return __raw_readl(reg_addr);
> >  }
> > +EXPORT_SYMBOL(gpmc_cs_read_reg);
> 
> You should get Tony's ack for this. I do not know the code, but on
> surface it looks strange. Exporting so low-level functions is bad in
> general, IMO. These function should either be inlined, or you should
> invent better abstraction, so that you would not need to ever call these
> functions from omap2.c. 

NAK. We don't want the drivers to tinker with these registers
directly. And really, the drivers should be platform independent.

This seems like a quick hack to add back the missing functionality
we threw out of the linux-omap tree. It was thrown out because there
were the same cut and paste hacks duplicated all over the place
tinkering with the GPMC registers directly.

We've fixed a lot of this by creating gpmc-onenand.c and gpmc-smc91x.c,
and that's clearly the way to go.

So instead of trying to add back the same old hacks, how about rather
spend that time to create something that we can use for all boards
using GPMC?

To me it looks like platform init like this should be done in a
generic way in arch/arm/mach-omap2/gpmc-nand.c the same way we have
gpmc-onenand.c and gpmc-smc91x.c.

Also, you should calculate the GPMC timings dynamically as they
can change based on the L3 frequency. Just take a look at the
gpmc-onenand.c and gpmc-smc91x.c.

Cheers,

Tony

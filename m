From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] gpmc, EXPORT_SYMBOLS, west bridge related
Date: Wed, 8 Sep 2010 20:39:08 -0700
Message-ID: <20100909033908.GB3723@kroah.com>
References: <1283887607.7250.10.camel@odc-laptop> <20100907235800.GD12823@kroah.com> <20100908172845.GO22507@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100908172845.GO22507@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Cross <david.cross@cypress.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 08, 2010 at 10:28:45AM -0700, Tony Lindgren wrote:
> * Greg KH <greg@kroah.com> [100907 17:17]:
> > On Tue, Sep 07, 2010 at 12:26:47PM -0700, David Cross wrote:
> > > This patch exports some of the gpmc driver functions in OMAP3. The purpose behind this patch 
> > > is to allow device drivers compiled as loadable modules to be interfaced to the GPMC. I am
> > > hoping that Tony is the correct maintainer and willing to ACK this change. Please let me know 
> > > if there are any issues or concerns with this patch.
> > > Thanks,
> > > David
> > > 
> > > Signed-off-by: David Cross <david.cross@cypress.com>
> > > 
> > > diff -uprN -X linux-next-vanilla/Documentation/dontdiff linux-next-vanilla/arch/arm/mach-omap2/gpmc.c linux-next-incl-sdk/arch/arm/mach-omap2/gpmc.c
> > > --- linux-next-vanilla/arch/arm/mach-omap2/gpmc.c	2010-08-31 19:32:51.000000000 -0700
> > > +++ linux-next-incl-sdk/arch/arm/mach-omap2/gpmc.c	2010-09-01 16:10:21.000000000 -0700
> > > @@ -133,6 +133,7 @@ void gpmc_cs_write_reg(int cs, int idx, 
> > >  	reg_addr = gpmc_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
> > >  	__raw_writel(val, reg_addr);
> > >  }
> > > +EXPORT_SYMBOL(gpmc_cs_write_reg);
> > 
> > EXPORT_SYMBOL_GPL() perhaps?
> > 
> > What about platforms that don't have this symbol, how will the driver
> > build properly then?  Shouldn't something like this be in a arch-neutral
> > place in the kernel tree?
> 
> I don't think exporting these functions is a good idea, so NAK from
> me for that.
> 
> All the drivers should be generic, and whatever needs to be done
> that's omap specific should be done in the platform init code.

Ah, that makes more sense.  David, care to make those changes?

thanks,

greg k-h

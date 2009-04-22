From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/7][RFC] OMAP4: Update common omap platform headers.
Date: Wed, 22 Apr 2009 12:11:36 -0700
Message-ID: <20090422191135.GX25864@atomide.com>
References: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com> <20090421182635.GJ25864@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F3B0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51343 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbZDVTLj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 15:11:39 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F3B0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090421 21:11]:
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Tuesday, April 21, 2009 11:57 PM
> > To: Shilimkar, Santosh
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 3/7][RFC] OMAP4: Update common omap 
> > platform headers.
> > 
> 
> > > -#define INT_24XX_SPI3_IRQ	91
> > > +#ifdef	CONFIG_ARCH_OMAP4
> > > +#define IRQ_GIC_START		32
> > > +#else
> > > +#define	IRQ_GIC_START		0
> > > +#endif
> > 
> > This ifdef we don't want to do as it blocks the compile
> > for multi-omap.
> Not sure why this should break multi-omap. As I mentioned in one of the patch OMAP4 may not be
> able to support multi-omap because of major differences on Memory controller and Interrupt handling.
> This macro ensures that only for OMAP4 all the IRQ lines are offseted by 32 and for rest of the OMAPs the offset is zero. Because that's the only change necessary.
> 
> May be I haven't understood your point here.

It makes the irq lines wrong if CONFIG_ARCH_OMAP4 and CONFIG_ARCH_OMAP3
are selected.
 
> > 
> > How about just add extra + 32 to the omap4 specific
> > defines? Something like this maybe:
> > 
> > #define OMAP4_GIC_OFFSET	32
> > #define INT_44XX_SP15_IRQ (69 + IRQ_GIC_START + OMAP4_GIC_OFFSET)
> > 
> > It's OK to define the numbers separately for each processors:
> 
> I thought about this but this will have impact on the drivers as well. In every driver you need to put different IRQ line macros depending on the OMAP2/3/4.

No. The interrupt numbers are coming from platform_data. You always
have separate platform_data for different processors.

> Just as an example UART1 uses "INT_24XX_UART1_IRQ" as the IRQ line number for OMAP2, OMAP3 and now for OMAP4 ( just offseted by 32).

This needs to be fixed in the serial code. I believe that's already
in Kevin's patches.

> If we define separate macros for each processor, we would be unnecessarily polluting the driver code with switches. Secondly, in this file itself we will be adding around 100 + lines of code just to take care of 32 offset.

The numbers are not the same. It's OK to add separate defines for
data that is not the same. The unused defines just will not be
used anywhere.

> If we are not breaking multi-omap for OMAP2/3, then this should be ok.

Nope, see above.

Tony

> 
> > > diff --git a/arch/arm/plat-omap/include/mach/system.h 
> > b/arch/arm/plat-omap/include/mach/system.h
> > > index 1060e34..371f98a 100644
> > > --- a/arch/arm/plat-omap/include/mach/system.h
> > > +++ b/arch/arm/plat-omap/include/mach/system.h
> > > @@ -48,4 +48,11 @@ static inline void arch_reset(char mode, 
> > const char *cmd)
> > >  		omap_prcm_arch_reset(mode);
> > >  }
> > >  
> > > +#ifdef CONFIG_ARCH_OMAP4
> > > +void omap_prcm_arch_reset(char mode)
> > > +{
> > > +	/* dummy hook for Linking */
> > > +}
> > > +#endif
> > > +
> > >  #endif
> > 
> > This should be named omap4_prcm_arch_reset() and then we just set
> > the right function pointer. Otherwise we'll break multi-omap
> > unnecessarily!
> omap_prcm_arch_reset() is called from arch_reset(). Currently since prcm files are not present/used for omap4, I get linking problem for just this API. Even if I make omap4_prcm_arch_reset(), I still need to compile out 
> omap_prcm_arch_reset() from arch_reset() which will look worser than this one. 
> 
> Thanks !!
> 
> Regards
> Santosh

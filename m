From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] OMAP3xx: Add DMA and IRQ definition for McBSP 1 and
	2
Date: Fri, 25 Apr 2008 11:13:57 -0700
Message-ID: <20080425181357.GB7671@atomide.com>
References: <1209052465-13210-1-git-send-email-edubezval@gmail.com> <1209052465-13210-2-git-send-email-edubezval@gmail.com> <1209052465-13210-3-git-send-email-edubezval@gmail.com> <1209052465-13210-4-git-send-email-edubezval@gmail.com> <1209052465-13210-5-git-send-email-edubezval@gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB2E706B5A@dbde02.ent.ti.com> <20080425164618.GD23025@atomide.com> <5A47E75E594F054BAF48C5E4FC4B92AB2E76E128@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:59534 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932728AbYDYSOB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 14:14:01 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB2E76E128@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@indt.org.br>

* Gadiyar, Anand <gadiyar@ti.com> [080425 11:11]:
> 
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Friday, April 25, 2008 10:16 PM
> > To: Gadiyar, Anand
> > Cc: Eduardo Valentin; linux-omap@vger.kernel.org; Eduardo Valentin
> > Subject: Re: [PATCH 4/5] OMAP3xx: Add DMA and IRQ definition
> > for McBSP 1 and 2
> >
> > * Gadiyar, Anand <gadiyar@ti.com> [080424 22:12]:
> > > <snip>
> > > > diff --git a/include/asm-arm/arch-omap/dma.h
> > > > b/include/asm-arm/arch-omap/dma.h
> > > > index be0431e..270e158 100644
> > > > --- a/include/asm-arm/arch-omap/dma.h
> > > > +++ b/include/asm-arm/arch-omap/dma.h
> > > > @@ -273,6 +273,10 @@
> > > >  #define OMAP24XX_DMA_MS                      63      /* S_DMA_62 */
> > > >  #define OMAP242X_DMA_EXT_DMAREQ5     64      /* S_DMA_63 */
> > > >  #define OMAP243X_DMA_EXT_DMAREQ6     64      /* S_DMA_63 */
> > > > +#define OMAP34XX_DMA_MCBSP1_TX               31      /* S_DMA_30 */
> > > > +#define OMAP34XX_DMA_MCBSP1_RX               32      /* S_DMA_31 */
> > > > +#define OMAP34XX_DMA_MCBSP2_TX               33      /* S_DMA_32 */
> > > > +#define OMAP34XX_DMA_MCBSP2_RX               34      /* S_DMA_33 */
> > > >  #define OMAP34XX_DMA_EXT_DMAREQ3     64      /* S_DMA_63 */
> > > >  #define OMAP34XX_DMA_AES2_TX         65      /* S_DMA_64 */
> > > >  #define OMAP34XX_DMA_AES2_RX         66      /* S_DMA_65 */
> > >
> > > What's the point of this patch? Can't you use OMAP24XX_DMA_MCBSP* names?
> > >
> > > > diff --git a/include/asm-arm/arch-omap/irqs.h
> > > > b/include/asm-arm/arch-omap/irqs.h
> > > > index 15446fd..4e185a8 100644
> > > > --- a/include/asm-arm/arch-omap/irqs.h
> > > > +++ b/include/asm-arm/arch-omap/irqs.h
> > > > @@ -316,7 +316,11 @@
> > > >  #define INT_34XX_USIM_IRQ    35
> > > >  #define INT_34XX_WDT3_IRQ    36
> > > >  #define INT_34XX_SPI4_IRQ    48
> > > > +#define INT_34XX_MCBSP1_IRQ_TX       59
> > > > +#define INT_34XX_MCBSP1_IRQ_RX       60
> > > >  #define INT_34XX_I2C3_IRQ    61
> > > > +#define INT_34XX_MCBSP2_IRQ_TX       62
> > > > +#define INT_34XX_MCBSP2_IRQ_RX       63
> > > >  #define INT_34XX_PBIAS_IRQ   75
> > > >  #define INT_34XX_OHCI_IRQ    76
> > > >  #define INT_34XX_EHCI_IRQ    77
> > >
> > > Ditto with the IRQ lines?
> > >
> > > @Tony,
> > > It would be nice to give people some time to take a look at
> > the patches before they get pushed.
> >
> > Sorry, it seemed like a safe patch to push. I will revert it
> > today.
> 
> I'm sorry I snapped at you guys earlier - it's just that this DMA
> code was some of my earliest work in the community and I'm a little
> passionate about it. This particular request line cleanup went
> through several iterations and I thought I'd done it reasonably well.

Hey no problem, you had several valid points there for sure!

Tony

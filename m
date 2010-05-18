From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/2] omap: iommu-update irq mask to be specific about twl
Date: Tue, 18 May 2010 11:54:57 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4BC6CD4A@dlee03.ent.ti.com>
References: <1274137950-18759-1-git-send-email-h-kanigeri2@ti.com>
	<1274137950-18759-2-git-send-email-h-kanigeri2@ti.com>
 <20100518.091202.246514683.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45920 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567Ab0ERQzE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 12:55:04 -0400
In-Reply-To: <20100518.091202.246514683.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hi Hiroshi,

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Tuesday, May 18, 2010 1:12 AM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: Re: [PATCH 1/2] omap: iommu-update irq mask to be specific about
> twl
> 
> > Update the irq mask so that is is clear that the MMU
>                               ~~typo?
> 

-- thanks for spotting this.

> > interrupt is related to TWL fault.
> >
> > Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> > ---
> >  arch/arm/mach-omap2/iommu2.c |   10 ++++++++--
> >  1 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
> > index e82da68..fcf4f4a 100644
> > --- a/arch/arm/mach-omap2/iommu2.c
> > +++ b/arch/arm/mach-omap2/iommu2.c
> > @@ -46,7 +46,13 @@
> >  #define MMU_IRQ_TLBMISS		(1 << 0)
> >  #define MMU_IRQ_MASK	\
> >  	(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_TABLEWALKFAULT | MMU_IRQ_EMUMISS |
> \
> > -	 MMU_IRQ_TRANSLATIONFAULT)
> > +	  MMU_IRQ_TRANSLATIONFAULT | MMU_IRQ_TLBMISS)
> > +#define MMU_IRQ_TWL_MASK	\
> > +	(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_TABLEWALKFAULT | MMU_IRQ_EMUMISS |
> \
> > +	  MMU_IRQ_TRANSLATIONFAULT)
> > +#define MMU_IRQ_TLB_MISS_MASK	\
> > +	(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_TLBMISS | MMU_IRQ_EMUMISS | \
> > +	  MMU_IRQ_TRANSLATIONFAULT)
> 
> nitpick: The above could look better as blew?

-- I agree. I will update this in my next patch revision.

> 
> #define __MMU_IRQ_FAULT		(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_EMUMISS |
> MMU_IRQ_TRANSLATIONFAULT)
> #define MMU_IRQ_MASK		(__MMU_IRQ_FAULT | MMU_IRQ_TABLEWALKFAULT |
> MMU_IRQ_TLBMISS)
> #define MMU_IRQ_TWL_MASK	(__MMU_IRQ_FAULT | MMU_IRQ_TABLEWALKFAULT)
> #define MMU_IRQ_TLB_MISS_MASK	(__MMU_IRQ_FAULT | MMU_IRQ_TLBMISS)
> 
> >
> >  /* MMU_CNTL */
> >  #define MMU_CNTL_SHIFT		1
> > @@ -96,7 +102,7 @@ static int omap2_iommu_enable(struct iommu *obj)
> >  	l |= (MMU_SYS_IDLE_SMART | MMU_SYS_AUTOIDLE);
> >  	iommu_write_reg(obj, l, MMU_SYSCONFIG);
> >
> > -	iommu_write_reg(obj, MMU_IRQ_MASK, MMU_IRQENABLE);
> > +	iommu_write_reg(obj, MMU_IRQ_TWL_MASK, MMU_IRQENABLE);
> >  	iommu_write_reg(obj, pa, MMU_TTB);
> >
> >  	l = iommu_read_reg(obj, MMU_CNTL);
> > --
> > 1.7.0
> >

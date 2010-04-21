From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/4][v3] OMAP:iommu support for OMAP4
Date: Wed, 21 Apr 2010 17:18:40 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B3C06CE@dlee03.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B3BF951@dlee03.ent.ti.com>
 <20100421220449.GP18272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45821 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756852Ab0DUWT3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 18:19:29 -0400
In-Reply-To: <20100421220449.GP18272@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Tony,

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, April 21, 2010 5:05 PM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; Felipe Contreras;
> Hiroshi DOYU
> Subject: Re: [PATCH 2/4][v3] OMAP:iommu support for OMAP4
> 
> * Kanigeri, Hari <h-kanigeri2@ti.com> [100420 15:52]:
> > From 9a2bcae7a2de6890884c23c45563eece1e6838de Mon Sep 17 00:00:00 2001
> > From: Hari Kanigeri <h-kanigeri2@ti.com>
> > Date: Tue, 20 Apr 2010 17:39:18 -0500
> > Subject: [PATCH 2/4] OMAP:iommu support for OMAP4
> >
> > This patch provides the iommu support for OMAP4 co-processors.
> >
> > Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap-iommu.c           |   26
> ++++++++++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/omap44xx.h |    3 +++
> >  2 files changed, 29 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-
> omap2/omap-iommu.c
> > index 416a65d..f569371 100644
> > --- a/arch/arm/mach-omap2/omap-iommu.c
> > +++ b/arch/arm/mach-omap2/omap-iommu.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/platform_device.h>
> >
> >  #include <plat/iommu.h>
> > +#include <plat/irqs.h>
> >
> >  struct iommu_device {
> >  	resource_size_t base;
> > @@ -46,6 +47,31 @@ static struct iommu_device devices[] = {
> >  };
> >  #endif
> >
> > +#ifdef CONFIG_ARCH_OMAP4
> > +static struct iommu_device devices[] = {
> > +	{
> > +		.base = OMAP4_MMU1_BASE,
> > +		.irq = INT_44XX_DUCATI_MMU_IRQ,
> > +		.pdata = {
> > +			.name = "ducati",
> > +			.nr_tlb_entries = 32,
> > +			.clk_name = "ducati_ick",
> > +		},
> > +	},
> > +#if defined(CONFIG_MPU_TESLA_IOMMU)
> > +	{
> > +		.base = OMAP4_MMU2_BASE,
> > +		.irq = INT_44XX_DSP_MMU,
> > +		.pdata = {
> > +			.name = "tesla",
> > +			.nr_tlb_entries = 32,
> > +			.clk_name = "tesla_ick",
> > +		},
> > +	},
> > +#endif
> > +};
> > +#endif
> 
> This should use:
> 
> static struct iommu_device *devices;
> 
> #ifdef CONFIG_ARCH_OMAP3
> static struct iommu_device omap3_devices[] = {
> ...
> #else
> #define omap3_devices	NULL
> #endif
> 
> #ifdef CONFIG_ARCH_OMAP4
> static struct iommu_device omap4_devices[] = {
> ...
> #else
> #define omap4_devices	NULL
> #endif
> 
> Then in init, just set devices based on the omap type.
> 

Appreciate your input. I will send revised patches.

Best regards,
Hari

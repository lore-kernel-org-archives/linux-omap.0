From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC][PATCH 2/3] ARM:OMAP4 iommu:add omap4 support in iommu
Date: Sun, 26 Jul 2009 13:16:15 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E3A941FAE@dlee03.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD44@dlee03.ent.ti.com>
 <20090724182702.GA10206@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38430 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871AbZGZSQd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Jul 2009 14:16:33 -0400
In-Reply-To: <20090724182702.GA10206@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ramesh" <grgupta@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Pasam, Vijay" <vpasam@ti.com>

Felipe,

> > +
> > +static const struct iommu_platform_data omap4_iommu_pdata[] __initconst
> = {
> > +	{
> > +		.name = "ducati",
> > +		.nr_tlb_entries = 32,
> > +		.clk_name = "ducati_ick",
> 
> passing clk names should be avoided. use clkdev.
>

-- Thanks for your comment. I will include this change in my revised patch.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> Sent: Friday, July 24, 2009 1:27 PM
> To: Kanigeri, Hari
> Cc: tony@atomide.com; Doyu Hiroshi (Nokia-D/Helsinki); linux-
> omap@vger.kernel.org; Gupta, Ramesh; rmk@arm.linux.org.uk; Pasam, Vijay
> Subject: Re: [RFC][PATCH 2/3] ARM:OMAP4 iommu:add omap4 support in iommu
> 
> On Fri, Jul 24, 2009 at 07:22:32PM +0200, ext Kanigeri, Hari wrote:
> > This patch adds omap4 support in iommu
> > module. This creates OMAP4 platform specific file
> > for iommu and defines the Ducati MMU fault interrupt.
> >
> > Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap4-iommu.c      |  112
> ++++++++++++++++++++++++++++++++
> >  arch/arm/plat-omap/include/mach/irqs.h |    2 +-
> >  2 files changed, 113 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/omap4-iommu.c
> >
> > diff --git a/arch/arm/mach-omap2/omap4-iommu.c b/arch/arm/mach-
> omap2/omap4-iommu.c
> > new file mode 100644
> > index 0000000..5a782df
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/omap4-iommu.c
> > @@ -0,0 +1,112 @@
> > +/*
> > + * omap iommu: omap4 device registration
> > + *
> > + * Copyright (C) 2009-2010 Nokia Corporation
> > + *
> > + * Written by Hari Kanigeri <h-kanigeri2@ti.com>
> > + *
> > + * Added support for OMAP4. This is based on original file
> > + * omap3-iommu.c
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/platform_device.h>
> > +
> > +#include <mach/iommu.h>
> > +#include <mach/irqs.h>
> > +
> > +#define OMAP4_MMU1_BASE	0x55082000
> > +#define OMAP4_MMU2_BASE	0x4A066000
> > +
> > +#define OMAP4_MMU1_IRQ	INT_44XX_DUCATI_MMU_IRQ
> > +#define OMAP4_MMU2_IRQ	INT_44XX_DSP_MMU
> > +
> > +
> > +
> > +static unsigned long iommu_base[] __initdata = {
> > +	OMAP4_MMU1_BASE,
> > +	OMAP4_MMU2_BASE,
> > +};
> > +
> > +static int iommu_irq[] __initdata = {
> > +	OMAP4_MMU1_IRQ,
> > +	OMAP4_MMU2_IRQ,
> > +};
> 
> these two looks really odd :-s
> 
> > +
> > +static const struct iommu_platform_data omap4_iommu_pdata[] __initconst
> = {
> > +	{
> > +		.name = "ducati",
> > +		.nr_tlb_entries = 32,
> > +		.clk_name = "ducati_ick",
> 
> passing clk names should be avoided. use clkdev.
> 
> > +	},
> > +#if defined(CONFIG_MPU_TESLA_IOMMU)
> 
> this ifdef looks odd.
> 
> --
> balbi


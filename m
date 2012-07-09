From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 04/14] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Mon, 9 Jul 2012 16:09:59 +0530
Message-ID: <CAMQu2gwGzK4dt0VW19LhQK_tjGgY6C4b628M3dNi5xP_hYFPhg@mail.gmail.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-5-git-send-email-santosh.shilimkar@ti.com> <4FFA9B61.8030808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:51283 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752891Ab2GIKkV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 06:40:21 -0400
Received: by qadz3 with SMTP id z3so1448918qad.10
        for <linux-omap@vger.kernel.org>; Mon, 09 Jul 2012 03:40:20 -0700 (PDT)
In-Reply-To: <4FFA9B61.8030808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>

On Mon, Jul 9, 2012 at 2:20 PM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
>
>
>
> On 7/6/2012 2:51 PM, Santosh Shilimkar wrote:
> > From: R Sricharan <r.sricharan@ti.com>
> >
> > OMAP5430 is Texas Instrument's SOC based on ARM Cortex-A15 SMP
> > architecture. It's a dual core SOC with GIC used for interrupt
> > handling and with an integrated L2 cache controller.
> >
> > OMAP5432 is another variant of OMAP5430, with a
> > memory controller supporting DDR3 and SATA.
> >
> > Patch includes:
> >  - The machine specific headers and sources updates.
> >  - Platform header updates.
> >  - Minimum initialisation support for serial.
> >  - IO table init
> >
> > Signed-off-by: R Sricharan <r.sricharan@ti.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---

[..]

> >
> > +#if defined(CONFIG_SOC_OMAP5)
> > +static struct omap_globals omap5_globals = {
> > +     .class  = OMAP54XX_CLASS,
> > +     .tap    = OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
> > +     .ctrl   = OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
> > +     .ctrl_pad       = OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE),
> > +     .prm    = OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE),
> > +     .cm     = OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_AON_BASE),
> > +     .cm2    = OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE),
> > +     .prcm_mpu = OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE),
>
> I am not sure whether we had discussed on this before, couldn't find it.
>
> Why don't we reuse OMAP4 data here and elsewhere??
>
Because data is not same between OMAP4 and OMAP5.
Wherever it is same, it is taken care.

[..]

> > diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> > index 70cf825..766181c 100644
> > --- a/arch/arm/plat-omap/sram.c
> > +++ b/arch/arm/plat-omap/sram.c
> > @@ -6,8 +6,8 @@
> >   * Copyright (C) 2005 Nokia Corporation
> >   * Written by Tony Lindgren <tony@atomide.com>
> >   *
> > - * Copyright (C) 2009 Texas Instruments
> > - * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
> > + * Copyright (C) 2009-2012 Texas Instruments
> > + * Added OMAP4/5 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
> >   *
> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of the GNU General Public License version 2 as
> > @@ -44,6 +44,7 @@
> >  #else
> >  #define OMAP4_SRAM_PUB_PA    (OMAP4_SRAM_PA + 0x4000)
> >  #endif
> > +#define OMAP5_SRAM_PA                0x40300000
> >
>
> We have mix of such definitions here, for example,
>
> "arch/arm/plat-omap/include/plat/sram.h"
> and now in arch/arm/plat-omap/sram.c here itself.
>
>
> May be right time to clean it up now.
>
Thats because of an interconnect BUG which needed it exported
at plat level in case of OMAP4.

Regards
Santosh

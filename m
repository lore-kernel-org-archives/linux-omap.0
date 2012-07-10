From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 04/14] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Tue, 10 Jul 2012 11:36:15 +0530
Message-ID: <CAMQu2gxLvG82zGsyEpw6HXp+=3OtB+O8zYSzQ=-ga7NUrcrfog@mail.gmail.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-5-git-send-email-santosh.shilimkar@ti.com>
 <4FFA9B61.8030808@ti.com> <CAMQu2gwGzK4dt0VW19LhQK_tjGgY6C4b628M3dNi5xP_hYFPhg@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA69474@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:36302 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751900Ab2GJGGi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jul 2012 02:06:38 -0400
Received: by qadz32 with SMTP id z32so2235444qad.14
        for <linux-omap@vger.kernel.org>; Mon, 09 Jul 2012 23:06:36 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA69474@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "R, Sricharan" <r.sricharan@ti.com>

On Tue, Jul 10, 2012 at 11:27 AM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> On Mon, Jul 09, 2012 at 16:09:59, Shilimkar, Santosh wrote:
>> On Mon, Jul 9, 2012 at 2:20 PM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
>> >
>> >
>> >
>> > On 7/6/2012 2:51 PM, Santosh Shilimkar wrote:
>> > > From: R Sricharan <r.sricharan@ti.com>
>> > >
>> > > OMAP5430 is Texas Instrument's SOC based on ARM Cortex-A15 SMP
>> > > architecture. It's a dual core SOC with GIC used for interrupt
>> > > handling and with an integrated L2 cache controller.
>> > >
>> > > OMAP5432 is another variant of OMAP5430, with a
>> > > memory controller supporting DDR3 and SATA.
>> > >
>> > > Patch includes:
>> > >  - The machine specific headers and sources updates.
>> > >  - Platform header updates.
>> > >  - Minimum initialisation support for serial.
>> > >  - IO table init
>> > >
>> > > Signed-off-by: R Sricharan <r.sricharan@ti.com>
>> > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > > ---
>>
>> [..]
>>
>> > >
>> > > +#if defined(CONFIG_SOC_OMAP5)
>> > > +static struct omap_globals omap5_globals = {
>> > > +     .class  = OMAP54XX_CLASS,
>> > > +     .tap    = OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
>> > > +     .ctrl   = OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
>> > > +     .ctrl_pad       = OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE),
>> > > +     .prm    = OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE),
>> > > +     .cm     = OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_AON_BASE),
>> > > +     .cm2    = OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE),
>> > > +     .prcm_mpu = OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE),
>> >
>> > I am not sure whether we had discussed on this before, couldn't find it.
>> >
>> > Why don't we reuse OMAP4 data here and elsewhere??
>> >
>> Because data is not same between OMAP4 and OMAP5.
>> Wherever it is same, it is taken care.
>>
>
> Above most of the base-addresses are same as omap4.
>
> And what about clocktree and hwmod? Is it going tobe same as omap4?
> Or we have separate data generated?
>
The data generated is different for OMAP5. Hwmod, powerdomain, clockdomain,
muxes. This data is out of the tree now since we are waiting for ES2.0
data which
has some differences w.r.t ES1.0. This was discussed in the beginning
as part of this
series review on the list.

>
>> [..]
>>
>> > > diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
>> > > index 70cf825..766181c 100644
>> > > --- a/arch/arm/plat-omap/sram.c
>> > > +++ b/arch/arm/plat-omap/sram.c
>> > > @@ -6,8 +6,8 @@
>> > >   * Copyright (C) 2005 Nokia Corporation
>> > >   * Written by Tony Lindgren <tony@atomide.com>
>> > >   *
>> > > - * Copyright (C) 2009 Texas Instruments
>> > > - * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > > + * Copyright (C) 2009-2012 Texas Instruments
>> > > + * Added OMAP4/5 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > >   *
>> > >   * This program is free software; you can redistribute it and/or modify
>> > >   * it under the terms of the GNU General Public License version 2 as
>> > > @@ -44,6 +44,7 @@
>> > >  #else
>> > >  #define OMAP4_SRAM_PUB_PA    (OMAP4_SRAM_PA + 0x4000)
>> > >  #endif
>> > > +#define OMAP5_SRAM_PA                0x40300000
>> > >
>> >
>> > We have mix of such definitions here, for example,
>> >
>> > "arch/arm/plat-omap/include/plat/sram.h"
>> > and now in arch/arm/plat-omap/sram.c here itself.
>> >
>> >
>> > May be right time to clean it up now.
>> >
>> Thats because of an interconnect BUG which needed it exported
>> at plat level in case of OMAP4.
>>
>
> Not only omap4, but we have 2, 3, 4 and AM33xx definitions present there
> at plat/sram.h and public PA (SRAM_PUB_PA) address is defined in sram.c file.
>
I see that now. Infact there is no need for any of those PA's to be defined
there except OMAP4 which needs to have that macro available for an errata.

I will clean that up once the series is merged. Don't want to introduce any
regression in last moment changes.

Regards
Santosh

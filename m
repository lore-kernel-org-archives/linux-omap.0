From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v5 7/12] OMAP1: dmtimer: conversion to platform devices
Date: Tue, 7 Dec 2010 10:47:11 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03736F5040@dbde02.ent.ti.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
 <1291679059-13419-8-git-send-email-tarun.kanti@ti.com>
 <20101206175600.GD4924@manju-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42858 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698Ab0LGFRU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 00:17:20 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB75HHId020333
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 6 Dec 2010 23:17:19 -0600
In-Reply-To: <20101206175600.GD4924@manju-desktop>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: G, Manjunath Kondaiah [mailto:manjugk@ti.com]
> Sent: Monday, December 06, 2010 11:26 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> Subject: Re: [PATCH v5 7/12] OMAP1: dmtimer: conversion to platform
> devices
> 
> On Tue, Dec 07, 2010 at 05:14:14AM +0530, Tarun Kanti DebBarma wrote:
> > From: Thara Gopinath <thara@ti.com>
> >
> > Convert OMAP1 dmtimers into a platform devices and then registers with
> > device model framework so that it can be bound to corresponding driver.
> >
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Reviewed-by: Cousson, Benoit <b-cousson@ti.com>
> > Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
> > ---
> >  arch/arm/mach-omap1/Makefile  |    2 +-
> >  arch/arm/mach-omap1/dmtimer.c |  172
> +++++++++++++++++++++++++++++++++++++++++
> >  arch/arm/plat-omap/dmtimer.c  |   46 +-----------
> >  3 files changed, 175 insertions(+), 45 deletions(-)
> >  create mode 100644 arch/arm/mach-omap1/dmtimer.c
> >
> > diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
> > index 9a304d8..0001659 100644
> > --- a/arch/arm/mach-omap1/Makefile
> > +++ b/arch/arm/mach-omap1/Makefile
> > @@ -4,7 +4,7 @@
> >
> >  # Common support
> >  obj-y := io.o id.o sram.o irq.o mux.o flash.o serial.o devices.o
> > -obj-y += clock.o clock_data.o opp_data.o
> > +obj-y += clock.o clock_data.o opp_data.o dmtimer.o
> >
> >  obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
> >
> > diff --git a/arch/arm/mach-omap1/dmtimer.c b/arch/arm/mach-
> omap1/dmtimer.c
> > new file mode 100644
> > index 0000000..2c42432
> > --- /dev/null
> > +++ b/arch/arm/mach-omap1/dmtimer.c
> > @@ -0,0 +1,172 @@
> > +/**
> > + * OMAP1 Dual-Mode Timers - platform device registration
> > + *
> > + * Contains first level initialization routines which internally
> > + * generates timer device information and registers with linux
> > + * device model. It also has low level function to chnage the timer
> > + * input clock source.
> > + *
> > + * Copyright (C) 2010 Texas Instruments Incorporated -
> http://www.ti.com/
> > + * Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > + * Thara Gopinath <thara@ti.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > + * kind, whether express or implied; without even the implied warranty
> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/err.h>
> > +#include <linux/slab.h>
> > +#include <mach/irqs.h>
> > +#include <plat/dmtimer.h>
> > +#include <plat/omap_device.h>
> > +
> > +#define OMAP1610_GPTIMER1_BASE		0xfffb1400
> > +#define OMAP1610_GPTIMER2_BASE		0xfffb1c00
> > +#define OMAP1610_GPTIMER3_BASE		0xfffb2400
> > +#define OMAP1610_GPTIMER4_BASE		0xfffb2c00
> > +#define OMAP1610_GPTIMER5_BASE		0xfffb3400
> > +#define OMAP1610_GPTIMER6_BASE		0xfffb3c00
> > +#define OMAP1610_GPTIMER7_BASE		0xfffb7400
> > +#define OMAP1610_GPTIMER8_BASE		0xfffbd400
> > +
> > +#define OMAP1_DM_TIMER_COUNT		8
> > +
> > +static int omap1_dm_timer_set_src(struct platform_device *pdev,
> > +				int source)
> > +{
> > +	int n = (pdev->id) << 1;
> > +	u32 l;
> > +
> > +	l = omap_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
> > +	l |= source << n;
> > +	omap_writel(l, MOD_CONF_CTRL_1);
> > +
> > +	return 0;
> > +}
> > +
> > +int __init omap1_dm_timer_device_init(void)
> > +{
> > +	int i;
> > +	int ret;
> > +	struct dmtimer_platform_data *pdata;
> > +	struct platform_device *pdev;
> > +
> > +	pr_debug("%s: +\n", __func__);
> > +
> > +	if (!cpu_is_omap16xx())
> > +		return 0;
> 
> Wondering how it is handled for other omap1's
So this check was right there when dmtimer was originally written.
I believe the code is relevant for OMAP16xx and OMAP1710 and not
For other OMAP1's. So far I have not got chance to look at OMAp15xx
And other OMAP1 hw manuals to confirm this. If it is relevant for all
OMAP1's then I can replace with cpu_class_is_omap1() macro.

> 
> /*
>  * Macros to group OMAP into cpu classes.
>  * These can be used in most places.
>  * cpu_is_omap7xx():	True for OMAP730, OMAP850
>  * cpu_is_omap15xx():	True for OMAP1510, OMAP5910 and OMAP310
>  * cpu_is_omap16xx():	True for OMAP1610, OMAP5912 and OMAP1710
> ...
Yes, Thanks.

> 
> > +
> > +	for (i = 1; i <= OMAP1_DM_TIMER_COUNT; i++) {
> > +		struct resource res[2];
> > +		u32 base, irq;
> > +
> > +		switch (i) {
> > +		case 1:
> > +			base = OMAP1610_GPTIMER1_BASE;
> > +			irq = INT_1610_GPTIMER1;
> > +			break;
> > +		case 2:
> > +			base = OMAP1610_GPTIMER2_BASE;
> > +			irq = INT_1610_GPTIMER2;
> > +			break;
> > +		case 3:
> > +			base = OMAP1610_GPTIMER3_BASE;
> > +			irq = INT_1610_GPTIMER3;
> > +			break;
> > +		case 4:
> > +			base = OMAP1610_GPTIMER4_BASE;
> > +			irq = INT_1610_GPTIMER4;
> > +			break;
> > +		case 5:
> > +			base = OMAP1610_GPTIMER5_BASE;
> > +			irq = INT_1610_GPTIMER5;
> > +			break;
> > +		case 6:
> > +			base = OMAP1610_GPTIMER6_BASE;
> > +			irq = INT_1610_GPTIMER6;
> > +			break;
> > +		case 7:
> > +			base = OMAP1610_GPTIMER7_BASE;
> > +			irq = INT_1610_GPTIMER7;
> > +			break;
> > +		case 8:
> > +			base = OMAP1610_GPTIMER8_BASE;
> > +			irq = INT_1610_GPTIMER8;
> > +			break;
> > +		default:
> > +			/*
> > +			 * not supposd to reach here.
> 
> s/supposd/supposed
Ok.

> 
> > +			 * this is to remove warning.
> > +			 */
> > +			return -EINVAL;
> > +		}
> > +
> > +		pdev = platform_device_alloc("omap_timer", i);
> > +		if (!pdev) {
> > +			pr_err("%s: Unable to device alloc for dmtimer%d\n",
> > +				__func__, i);
> > +			return -ENOMEM;
> > +		}
> > +
> > +		memset(res, 0, 2 * sizeof(struct resource));
> > +		res[0].start = base;
> > +		res[0].end = base + 0xff;
> > +		res[0].flags = IORESOURCE_MEM;
> > +		res[1].start = res[1].end = irq;
> 
> CHECK: multiple assignments should be avoided
Ok.

> 
> > +		res[1].flags = IORESOURCE_IRQ;
> > +		ret = platform_device_add_resources(pdev, res,
> > +				ARRAY_SIZE(res));
> > +		if (ret) {
> > +			pr_err("%s: Unable to add resources for %s.%d\n",
> 
> dev is available here. replace pr_err with dev_err. Applies to other
> places also.
Ok.

> 
> > +				__func__, pdev->name, pdev->id);
> > +			goto err_free_pdev;
> > +		}
> > +
> > +		pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> > +		if (!pdata) {
> > +			pr_err("%s: Unable to allocate pdata for %s.%d\n",
> > +				__func__, pdev->name, pdev->id);
> > +			ret = -ENOMEM;
> > +			goto err_free_pdev;
> > +		}
> > +
> > +		pdata->set_timer_src = omap1_dm_timer_set_src;
> > +		pdata->is_early_init = 0;
> > +		pdata->timer_ip_type = OMAP_TIMER_IP_VERSION_1;
> > +		pdata->intr_reg_offset = 0;
> > +		pdata->func_reg_offset = 0;
> 
> Looks like omap1 is broken here:
> s/intr_reg_offset/intr_offset/g
> s/func_reg_offset/func_offset/g
Yes, there were last minute changes to make these names shorter.
I missed to make the same for OMAP1 and compile.
I realized that after sending out the patch series.
Thanks!
--
Tarun

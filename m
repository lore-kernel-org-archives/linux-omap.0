From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 5/9] OMAP:GPIO: Introduce support for OMAP2PLUS chip
 specific GPIO
Date: Tue, 4 May 2010 21:29:06 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C52D12CC@dbde02.ent.ti.com>
References: <87och0bl1d.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57884 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759481Ab0EDP7M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 11:59:12 -0400
In-Reply-To: <87och0bl1d.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Saturday, May 01, 2010 4:33 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com; tony@atomide.com
> Subject: Re: [PATCH 5/9] OMAP:GPIO: Introduce support for OMAP2PLUS chip specific
> GPIO
> 
> Charulatha V <charu@ti.com> writes:
> 
> > This patch adds support for handling GPIO as a HWMOD adapted
> > platform device for OMAP2PLUS chips.
> >
> > Signed-off-by: Charulatha V <charu@ti.com>
> > ---
> >  arch/arm/mach-omap2/gpio.c |  101 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 101 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/gpio.c
> >
> > diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> > new file mode 100644
> > index 0000000..6424050
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/gpio.c
> > @@ -0,0 +1,101 @@
> > +/*
> > + * gpio.c - OMAP2PLUS-specific gpio code
> > + *
> > + * Copyright (C) 2010 Texas Instruments, Inc.
> > + *
> > + * Author:
> > + *	Charulatha V <charu@ti.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/gpio.h>
> > +#include <linux/err.h>
> > +#include <plat/omap_hwmod.h>
> > +#include <plat/omap_device.h>
> > +
> > +static int gpio_bank_count;
> > +
> > +struct omap_device_pm_latency omap_gpio_latency[] = {
> > +	[0] = {
> > +		.deactivate_func = omap_device_idle_hwmods,
> > +		.activate_func   = omap_device_enable_hwmods,
> > +		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> > +	},
> > +};
> > +
> > +int __init gpio_init(void)
> > +{
> > +	int i = 0;
> > +	static int is_early_device = true;
> > +
> > +	do {
> > +		struct omap_device *od;
> > +		struct omap_hwmod *oh;
> > +		int hw_mod_name_len = 16;
> > +		int l;
> > +		char oh_name[hw_mod_name_len];
> > +		struct omap_gpio_platform_data *pdata;
> > +		char *name = "omap-gpio";
> > +
> > +		l = snprintf(oh_name, hw_mod_name_len, "gpio%d_hwmod", i + 1);
> > +		WARN(l >= hw_mod_name_len,
> > +			"String buffer overflow in GPIO device setup\n");
> > +
> 
> Rather than iterating over the name, you should have a hwmod_class for
> GPIOs and use omap_hwmod_for_each_by_class() to iterate over all the
> hwmods in the GPIO class.

Ok.

> 
> > +		oh = omap_hwmod_lookup(oh_name);
> > +		if (!oh) {
> > +			pr_err("Could not look up %s\n", oh_name);
> > +			i++;
> > +			continue;
> > +		}
> > +
> > +		pdata = kzalloc(sizeof(struct omap_gpio_platform_data),
> > +					GFP_KERNEL);
> > +		if (!pdata) {
> > +			pr_err("Memory allocation failed gpio%d\n", i + 1);
> > +			return -ENOMEM;
> > +		}
> > +		pdata->base = oh->_rt_va;
> > +		pdata->irq = oh->mpu_irqs[0].irq;
> 
> base address and IRQ should not be part of platform_data.   platform
> driver should be using platform_get_resource() for both.

Agreed. Will modify.

> 
> > +		if (cpu_is_omap24xx() || cpu_is_omap34xx())
> > +			pdata->method = METHOD_GPIO_24XX;
> > +		if (cpu_is_omap44xx())
> > +			pdata->method = METHOD_GPIO_44XX;
> > +		pdata->virtual_irq_start = IH_GPIO_BASE + 32 * i;
> > +		pdata->device_enable = omap_device_enable;
> > +		pdata->device_idle = omap_device_idle;
> > +		pdata->device_shutdown = omap_device_shutdown;
> 
> These aren't valid for GPIO1 which is in WKUP.  Maybe we need
> to check if the hwmod is not in wkup_pwrdm before setting these?

I need to check how to implement this. 

> 
> > +		od = omap_device_build(name, i, oh, pdata,
> > +					sizeof(*pdata),	omap_gpio_latency,
> > +					ARRAY_SIZE(omap_gpio_latency),
> > +					is_early_device);
> > +		WARN(IS_ERR(od), "Cant build omap_device for %s:%s.\n",
> > +					name, oh->name);
> > +
> > +		i++;
> > +	} while (i < gpio_bank_count);
> > +	is_early_device = false;
> > +
> > +	return 0;
> > +}
> > +arch_initcall(gpio_init);
> > +
> > +int __init omap2_gpio_init(void)
> > +{
> > +	if (cpu_is_omap242x())
> > +		gpio_bank_count = 4;
> > +	else if (cpu_is_omap243x())
> > +		gpio_bank_count = 5;
> > +	else if (cpu_is_omap34xx() || cpu_is_omap44xx())
> > +		gpio_bank_count = OMAP34XX_NR_GPIOS;
> 
> The count should be gathered after iterating over the GPIO hwmod class.
> and should not need cpu_is checks.

Sure.

> 
> > +	if (gpio_init())
> > +		return -EINVAL;
> > +
> > +	early_platform_driver_register_all("earlygpio");
> > +	early_platform_driver_probe("earlygpio", gpio_bank_count, 0);
> > +	return 0;
> > +}
> > --
> > 1.6.3.3
> 
> Kevin

From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 4/8] OMAP3: PM: Adding smartreflex device file.
Date: Wed, 25 Aug 2010 15:26:58 -0700
Message-ID: <878w3ucor1.fsf@deeprootsystems.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
	<1281707231-3026-5-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57991 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab0HYW1B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 18:27:01 -0400
Received: by pzk9 with SMTP id 9so375364pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Aug 2010 15:27:00 -0700 (PDT)
In-Reply-To: <1281707231-3026-5-git-send-email-thara@ti.com> (Thara Gopinath's
	message of "Fri, 13 Aug 2010 19:17:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, dderrick@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds support for device registration of various
> smartreflex module present in the system. This patch introduces
> the platform data for smartreflex devices which include
> the efused and test n-target vaules, module enable/disable
> pointers and a parameter to indicate whether smartreflex
> autocompensation needs to be enabled on init or not.
> Currently auocompensation is enabled on init by default
> for OMAP3430 ES3.1 chip.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile    |    2 +-
>  arch/arm/mach-omap2/sr_device.c |  185 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 186 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/sr_device.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 0754886..f259bb8 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -53,7 +53,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
>  					   cpuidle34xx.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
> -obj-$(CONFIG_OMAP_SMARTREFLEX)          += smartreflex.o
> +obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
>  
>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
>  AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
> new file mode 100644
> index 0000000..3bd0170
> --- /dev/null
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -0,0 +1,185 @@
> +/*
> + * OMAP3/OMAP4 smartreflex device file
> + *
> + * Author: Thara Gopinath	<thara@ti.com>
> + *
> + * Based originally on code from smartreflex.c
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Thara Gopinath <thara@ti.com>
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + * Kalle Jokiniemi
> + *
> + * Copyright (C) 2007 Texas Instruments, Inc.
> + * Lesly A M <x0080970@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +
> +#include <plat/control.h>
> +#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
> +#include <plat/opp.h>
> +#include <plat/smartreflex.h>
> +#include <plat/voltage.h>
> +
> +static struct omap_device_pm_latency omap_sr_latency[] = {
> +	{
> +		.deactivate_func = omap_device_idle_hwmods,
> +		.activate_func	 = omap_device_enable_hwmods,
> +		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST
> +	},
> +};
> +
> +/* Read EFUSE values from control registers for OMAP3430 */
> +static void __init sr_read_efuse(struct omap_sr_dev_data *dev_data,
> +				struct omap_sr_data *sr_data)
> +{
> +	int i;
> +
> +	if (!dev_data || !dev_data->volts_supported || !dev_data->volt_data ||
> +			!dev_data->efuse_nvalues_offs) {
> +		pr_warning("%s: Bad parameters! dev_data = %x,"
> +			"dev_data->volts_supported = %x,"
> +			"dev_data->volt_data = %x,"
> +			"dev_data->efuse_nvalues_offs = %x\n", __func__,
> +			(unsigned int)dev_data, dev_data->volts_supported,
> +			(unsigned int)dev_data->volt_data,
> +			(unsigned int)dev_data->efuse_nvalues_offs);
> +		return;
> +	}
> +
> +	/*
> +	 * From OMAP3630 onwards there are no efuse registers for senn_mod
> +	 * and senp_mod. They have to be 0x1 by default.
> +	 */
> +	if (!dev_data->efuse_sr_control) {
> +		sr_data->senn_mod = 0x1;
> +		sr_data->senp_mod = 0x1;
> +	} else {
> +		sr_data->senn_mod =
> +				((omap_ctrl_readl(dev_data->efuse_sr_control) &
> +				(0x3 << dev_data->sennenable_shift)) >>
> +				dev_data->sennenable_shift);
> +		sr_data->senp_mod =
> +				((omap_ctrl_readl(dev_data->efuse_sr_control) &
> +				(0x3 << dev_data->senpenable_shift)) >>
> +				dev_data->senpenable_shift);
> +	}
> +
> +	for (i = 0; i < dev_data->volts_supported; i++)
> +		dev_data->volt_data[i].sr_nvalue = omap_ctrl_readl(
> +				dev_data->efuse_nvalues_offs[i]);
> +}
> +
> +/*
> + * Hard coded nvalues for testing purposes for OMAP3430,
> + * may cause device to hang!
> + */
> +static void __init sr_set_testing_nvalues(struct omap_sr_dev_data *dev_data,
> +				struct omap_sr_data *sr_data)
> +{
> +	int i;
> +
> +	if (!dev_data || !dev_data->volts_supported ||
> +			!dev_data->volt_data || !dev_data->test_nvalues) {
> +		pr_warning("%s: Bad parameters! dev_data = %x,"
> +			"dev_data->volts_supported = %x,"
> +			"dev_data->volt_data = %x,"
> +			"dev_data->test_nvalues = %x\n", __func__,
> +			(unsigned int)dev_data, dev_data->volts_supported,
> +			(unsigned int)dev_data->volt_data,
> +			(unsigned int)dev_data->test_nvalues);
> +		return;
> +	}
> +
> +	sr_data->senn_mod = dev_data->test_sennenable;
> +	sr_data->senp_mod = dev_data->test_senpenable;
> +	for (i = 0; i < dev_data->volts_supported; i++)
> +		dev_data->volt_data[i].sr_nvalue = dev_data->test_nvalues[i];
> +}
> +
> +static void __init sr_set_nvalues(struct omap_sr_dev_data *dev_data,
> +				struct omap_sr_data *sr_data)
> +{
> +	if (SR_TESTING_NVALUES)
> +		sr_set_testing_nvalues(dev_data, sr_data);
> +	else
> +		sr_read_efuse(dev_data, sr_data);
> +}
> +
> +static int sr_dev_init(struct omap_hwmod *oh, void *user)
> +{
> +	struct omap_sr_data *sr_data;
> +	struct omap_sr_dev_data *sr_dev_data;
> +	struct omap_device *od;
> +	char *name = "smartreflex";
> +	static int i;
> +
> +	sr_data = kzalloc(sizeof(struct omap_sr_data), GFP_KERNEL);
> +	if (!sr_data) {
> +		pr_err("%s: Unable to allocate memory for %s sr_data.Error!\n",
> +			__func__, oh->name);
> +		return -ENOMEM;
> +	}
> +
> +	sr_dev_data = (struct omap_sr_dev_data *)oh->dev_attr;
> +	if (unlikely(!sr_dev_data)) {
> +		pr_err("%s: dev atrribute is NULL\n", __func__);
> +		goto exit;
> +	}
> +
> +	/*
> +	 * OMAP3430 ES3.1 chips by default come with Efuse burnt
> +	 * with parameters required for full functionality of
> +	 * smartreflex AVS feature like ntarget values , sennenable
> +	 * and senpenable. So enable the SR AVS feature during boot up
> +	 * itself if it is a OMAP3430 ES3.1 chip.
> +	 */

here, do:
	sr_data->enable_on_init = false;

> +	if (cpu_is_omap343x()) {
> +		if (omap_rev() == OMAP3430_REV_ES3_1)
> +			sr_data->enable_on_init = true;

and drop the rest of this

> +		else
> +			sr_data->enable_on_init = false;
> +	} else {
> +		sr_data->enable_on_init = false;
> +	}

until here.

> +	sr_data->device_enable = omap_device_enable;
> +	sr_data->device_shutdown = omap_device_shutdown;
> +	sr_data->device_idle = omap_device_idle;

Please drop these and use runtime PM as suggested in previous patch.

> +	sr_data->voltdm = omap_voltage_domain_get(sr_dev_data->vdd_name);
> +	if (IS_ERR(sr_data->voltdm)) {
> +		pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
> +			__func__, sr_dev_data->vdd_name);
> +		goto exit;
> +	}
> +	sr_dev_data->volts_supported = omap_voltage_get_volttable(
> +			sr_data->voltdm, &sr_dev_data->volt_data);
> +	if (!sr_dev_data->volts_supported) {
> +		pr_warning("%s: No Voltage table registerd fo VDD%d."
> +			"Something really wrong\n\n", __func__, i + 1);
> +		goto exit;
> +	}
> +	sr_set_nvalues(sr_dev_data, sr_data);
> +	od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
> +			       omap_sr_latency,
> +			       ARRAY_SIZE(omap_sr_latency), 0);
> +	if (IS_ERR(od))
> +		pr_warning("%s: Could not build omap_device for %s: %s.\n\n",
> +			__func__, name, oh->name);
> +exit:
> +	i++;
> +	kfree(sr_data);

This looks like it fixes the kmemleak reported by Artem/Nishanth, right?

> +	return 0;
> +}
> +
> +static int __init omap_devinit_smartreflex(void)
> +{
> +	return omap_hwmod_for_each_by_class("smartreflex", sr_dev_init, NULL);
> +}
> +device_initcall(omap_devinit_smartreflex);

Kevin

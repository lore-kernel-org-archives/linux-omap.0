From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 04/11] OMAP3: PM: Adding smartreflex device file.
Date: Thu, 14 Oct 2010 12:29:23 -0700
Message-ID: <1287084563.14514.155.camel@localhost>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	 <1285166719-19352-5-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39218 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203Ab0JNV5o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 17:57:44 -0400
Received: by mail-vw0-f46.google.com with SMTP id 2so76279vws.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Oct 2010 14:57:43 -0700 (PDT)
In-Reply-To: <1285166719-19352-5-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

On Wed, 2010-09-22 at 20:15 +0530, Thara Gopinath wrote:
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
>  arch/arm/mach-omap2/sr_device.c |  174 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 175 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/sr_device.c
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 8dd32a7..abc377a 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -56,7 +56,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
>  					   cpuidle34xx.o pm_bus.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
> -obj-$(CONFIG_OMAP_SMARTREFLEX)          += smartreflex.o
> +obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
>  
>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
>  AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
> new file mode 100644
> index 0000000..606da59
> --- /dev/null
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -0,0 +1,174 @@
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
> +#include <plat/omap_device.h>
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
> +#ifdef OMAP_SMARTREFLEX_TESTING
> +/*
> + * Hard coded nvalues for testing purposes for OMAP3430,
> + * may cause device to hang!
> + */
> +static void __init sr_set_nvalues(struct omap_sr_dev_data *dev_data,
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
> +#else
> +/* Read EFUSE values from control registers for OMAP3430 */
> +static void __init sr_set_nvalues(struct omap_sr_dev_data *dev_data,
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

For readbility, can you do the ctrl_read on one line, then the
mask/shift on a separate line, e.g.:

		sr_data->senn_mod = omap_ctrl_readl...
		sr_data->senn_mod &= ....

> +	for (i = 0; i < dev_data->volts_supported; i++)
> +		dev_data->volt_data[i].sr_nvalue = omap_ctrl_readl(
> +				dev_data->efuse_nvalues_offs[i]);

The wrapping here affects readability.  It would be better to do this in
two lines:

		v = omap_ctrl_readl...
		dev_data-... = v;

Similar readability problem this part of OMAP4 series.

> +}
> +#endif
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
> +	sr_data->enable_on_init = false;
> +	if (cpu_is_omap343x()) {
> +		if (omap_rev() == OMAP3430_REV_ES3_1)
> +			sr_data->enable_on_init = true;
> +	}

The braces are not needed here.

> +	sr_data->voltdm = omap_voltage_domain_get(sr_dev_data->vdd_name);
> +	if (IS_ERR(sr_data->voltdm)) {
> +		pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
> +			__func__, sr_dev_data->vdd_name);
> +		goto exit;
> +	}
> +
> +	sr_dev_data->volts_supported = omap_voltage_get_volttable(
> +			sr_data->voltdm, &sr_dev_data->volt_data);
>
> +	if (!sr_dev_data->volts_supported) {
> +		pr_warning("%s: No Voltage table registerd fo VDD%d."
> +			"Something really wrong\n\n", __func__, i + 1);
> +		goto exit;
> +	}
> +
> +	sr_set_nvalues(sr_dev_data, sr_data);

First question: why does this N-value init need to be done in the device
init?  It seems better to be a part of the SR driver probe.

Second, this section took me quite some time to understand, as it seems
to blur the lines of device and driver but also how it interacts with
the voltage layer.

sr_set_nvalues() is directly manipulating structures that are internal
to the voltage layer.  It also makes assumptions about the ordering of
volt_data structs in the voltage layer.

Strictly speaking neither the sr_nvalue or sr_errminlimit fields of
volt_data are not used at all in the voltage layer, but only in the SR
layer, so ideally they should really stay in the SR layer.

I think what is needed here is a cleaner way for the SR layer to connect
the N-values to a voltage.  The current method of manipulating voltage
layer structs inside the SR layer is not acceptable.  Since the n-values
are fixed in HW (per SoC), what I suggest is simply having a field like
'efuse_id' or something in volt_data.  Then, the smart reflex layer can
lookup and index all the efuse values during probe, and when sr_enable
is called, it looks up the nvalue based on efuse_id.

I assume that the sr_errminlimit could also be set based on efuse_id,
and therefore remain contained within the SR layer, but I'm not sure I
like that idea any better than keeping it inside volt_data.  For now,
I'll let you make the call on errminlimit, but I really want to see the
N-value stuff isolated in the SR layer.

Kevin

> +	od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
> +			       omap_sr_latency,
> +			       ARRAY_SIZE(omap_sr_latency), 0);
> +	if (IS_ERR(od))
> +		pr_warning("%s: Could not build omap_device for %s: %s.\n\n",
> +			__func__, name, oh->name);
> +exit:
> +	i++;
> +	kfree(sr_data);
> +	return 0;
> +}
> +
> +static int __init omap_devinit_smartreflex(void)
> +{
> +	return omap_hwmod_for_each_by_class("smartreflex", sr_dev_init, NULL);
> +}
> +device_initcall(omap_devinit_smartreflex);



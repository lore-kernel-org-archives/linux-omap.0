From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 06/11] OMAP3: PM: Adding smartreflex class3 driver
Date: Thu, 14 Oct 2010 16:09:03 -0700
Message-ID: <87iq14qsmo.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-7-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:41380 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab0JNXJG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 19:09:06 -0400
Received: by pxi16 with SMTP id 16so15726pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Oct 2010 16:09:05 -0700 (PDT)
In-Reply-To: <1285166719-19352-7-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Wed, 22 Sep 2010 20:15:14 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> Smartreflex Class3 implementation continuously monitors
> silicon performance  and instructs the Voltage Processors
> to increase or decrease the voltage.
> This patch adds smartreflex class 3 driver. This driver hooks
> up with the generic smartreflex driver smartreflex.c to abstract
> out class specific implementations out of the generic driver.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

Some minor comments below...

> ---
>  arch/arm/mach-omap2/Makefile             |    1 +
>  arch/arm/mach-omap2/smartreflex-class3.c |   61 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/smartreflex-class3.h |   23 +++++++++++
>  arch/arm/plat-omap/Kconfig               |    9 ++++
>  4 files changed, 94 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
>  create mode 100644 arch/arm/mach-omap2/smartreflex-class3.h
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index abc377a..4f6139c 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
>  obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
> +obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
>  
>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
>  AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
> diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
> new file mode 100644
> index 0000000..f1ade08
> --- /dev/null
> +++ b/arch/arm/mach-omap2/smartreflex-class3.c
> @@ -0,0 +1,61 @@
> +/*
> + * Smart reflex Class 3 specific implementations
> + *
> + * Author: Thara Gopinath       <thara@ti.com>
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Thara Gopinath <thara@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <plat/smartreflex.h>
> +
> +#include "smartreflex-class3.h"
> +
> +static int sr_class3_enable(struct voltagedomain *voltdm)
> +{
> +	unsigned long volt = 0;

minor: '= 0' assignment not needed as it's immediately assigned in the
next line.

> +	volt = omap_voltage_get_nom_volt(voltdm);
> +	if (!volt) {
> +		pr_warning("%s: Curr voltage unknown. Cannot enable sr_%s\n",
> +				__func__, voltdm->name);
> +		return -ENODATA;
> +	}
> +
> +	omap_vp_enable(voltdm);
> +	return sr_enable(voltdm, volt);
> +}
> +
> +static int sr_class3_disable(struct voltagedomain *voltdm, int is_volt_reset)
> +{
> +	omap_vp_disable(voltdm);
> +	sr_disable(voltdm);
> +	if (is_volt_reset)
> +		omap_voltage_reset(voltdm);
> +
> +	return 0;
> +}
> +
> +static int sr_class3_configure(struct voltagedomain *voltdm)
> +{
> +	return sr_configure_errgen(voltdm);
> +}
> +
> +/* SR class3 structure */
> +static struct omap_smartreflex_class_data class3_data = {
> +	.enable = sr_class3_enable,
> +	.disable = sr_class3_disable,
> +	.configure = sr_class3_configure,
> +	.class_type = SR_CLASS3,
> +};
> +
> +/* Smartreflex CLASS3 init API to be called from board file */

s/CLASS3/Class 3/

> +int __init sr_class3_init(void)
> +{
> +	pr_info("SmartReflex CLASS3 initialized\n");

ditto

> +	return sr_register_class(&class3_data);
> +}
> diff --git a/arch/arm/mach-omap2/smartreflex-class3.h b/arch/arm/mach-omap2/smartreflex-class3.h
> new file mode 100644
> index 0000000..4d86037
> --- /dev/null
> +++ b/arch/arm/mach-omap2/smartreflex-class3.h
> @@ -0,0 +1,23 @@
> +/*
> + * Smartreflex Class 3 Routines
> + *
> + * Author: Thara Gopinath      <thara@ti.com>
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Thara Gopinath <thara@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_SMARTREFLEXCLASS3_H
> +#define __ARCH_ARM_MACH_OMAP2_SMARTREFLEXCLASS3_H
> +
> +#ifdef CONFIG_OMAP_SMARTREFLEX_CLASS3
> +int sr_class3_init(void);
> +#else
> +static int sr_class3_init(void) { return 0; }
> +#endif
> +
> +#endif
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 8056349..af7acc9 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -67,6 +67,15 @@ config OMAP_SMARTREFLEX_TESTING
>  
>  	  WARNING: Enabling this option may cause your device to hang!
>  
> +config OMAP_SMARTREFLEX_CLASS3
> +	bool "Class 3 mode of Smartreflex Implementation"
> +	depends on OMAP_SMARTREFLEX && TWL4030_CORE
> +	help
> +	  Say Y to enable Class 3 implementation of Smartreflex
> +
> +	  Class 3 implementation of Smartreflex employs continuous hardware
> +	  voltage caliberation.

calibration

> +
>  config OMAP_RESET_CLOCKS
>  	bool "Reset unused clocks during boot"
>  	depends on ARCH_OMAP

Kevin

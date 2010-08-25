From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 10/10] OMAP4: Add opp tables.
Date: Wed, 25 Aug 2010 16:15:14 -0700
Message-ID: <87y6bu8et9.fsf@deeprootsystems.com>
References: <1282130191-9062-1-git-send-email-thara@ti.com>
	<1282130191-9062-11-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54504 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab0HYXPT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 19:15:19 -0400
Received: by ywh1 with SMTP id 1so106159ywh.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Aug 2010 16:15:19 -0700 (PDT)
In-Reply-To: <1282130191-9062-11-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Wed, 18 Aug 2010 16:46:31 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds OPP tables for OMAP4. A new file
> opp44xx.c has been added to keep the OMAP4 opp tables
> and the registeration of these tables with the generic
> opp framework.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile       |    2 +-
>  arch/arm/mach-omap2/opp44xx.h      |   26 ++++++++++++
>  arch/arm/mach-omap2/opp44xx_data.c |   80 ++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm.c           |    6 ++-
>  4 files changed, 112 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/opp44xx.h
>  create mode 100644 arch/arm/mach-omap2/opp44xx_data.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index d46fbec..ebe3f36 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -51,7 +51,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
>  					   cpuidle34xx.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o voltage.o
> +obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o voltage.o opp44xx_data.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
> diff --git a/arch/arm/mach-omap2/opp44xx.h b/arch/arm/mach-omap2/opp44xx.h
> new file mode 100644
> index 0000000..2cae9f3
> --- /dev/null
> +++ b/arch/arm/mach-omap2/opp44xx.h

We don't really a new OMAP4-specific header for this.  Let's just rename
omap3-opp.h to omap-opp.h and put both init functions there.

I'll update the pm-opp branch accordingly.

Kevin

> @@ -0,0 +1,26 @@
> +/*
> + * OMAP4 OPP API's.
> + *
> + * Copyright (C) 2010 Texas Instruments Incorporated.
> + *	Thara Gopinath
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> + * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
> + * History:
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_OPP44XX_H
> +#define __ARCH_ARM_MACH_OMAP2_OPP44XX_H
> +
> +#ifdef CONFIG_PM
> +extern int omap4_pm_init_opp_table(void);
> +#else
> +static inline int omap4_pm_init_opp_table(void) { return -EINVAL; }
> +#endif
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/opp44xx_data.c b/arch/arm/mach-omap2/opp44xx_data.c
> new file mode 100644
> index 0000000..b5c9680
> --- /dev/null
> +++ b/arch/arm/mach-omap2/opp44xx_data.c
> @@ -0,0 +1,80 @@
> +/*
> + * OMAP4 OPP table definitions.
> + *
> + * Copyright (C) 2009 - 2010 Texas Instruments Incorporated.
> + *	Nishanth Menon
> + * Copyright (C) 2009 - 2010 Deep Root Systems, LLC.
> + *	Kevin Hilman
> + * Copyright (C) 2010 Nokia Corporation.
> + *      Eduardo Valentin
> + * Copyright (C) 2010 Texas Instruments Incorporated.
> + *	Thara Gopinath
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> + * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
> + * History:
> + */
> +
> +#include <linux/module.h>
> +#include <linux/err.h>
> +
> +#include <plat/opp.h>
> +#include <plat/cpu.h>
> +
> +#include "opp44xx.h"
> +
> +static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
> +	/* MPU OPP1 - OPP50 */
> +	OMAP_OPP_DEF("mpu", true, 300000000, 930000),
> +	/* MPU OPP2 - OPP100 */
> +	OMAP_OPP_DEF("mpu", true, 600000000, 1100000),
> +	/* MPU OPP3 - OPP-Turbo */
> +	OMAP_OPP_DEF("mpu", true, 800000000, 1260000),
> +	/* MPU OPP4 - OPP-SB */
> +	OMAP_OPP_DEF("mpu", true, 1008000000, 1350000),
> +	/* IVA OPP1 - OPP50 */
> +	OMAP_OPP_DEF("iva", true,  133000000, 930000),
> +	/* IVA OPP2 - OPP100 */
> +	OMAP_OPP_DEF("iva", true,  266000000, 1100000),
> +	/* IVA OPP3 - OPP-Turbo */
> +	OMAP_OPP_DEF("iva", false, 332000000, 1260000),
> +	/* L3 OPP1 - OPP50 */
> +	OMAP_OPP_DEF("l3_main_1", true, 100000000, 930000),
> +	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
> +	OMAP_OPP_DEF("l3_main_1", true, 200000000, 1100000),
> +};
> +
> +static u32 omap44xx_opp_def_size = ARRAY_SIZE(omap44xx_opp_def_list);
> +
> +/* Temp variable to allow multiple calls */
> +static u8 __initdata omap4_table_init;
> +
> +
> +int __init omap4_pm_init_opp_table(void)
> +{
> +	struct omap_opp_def *opp_def;
> +	int i, r;
> +
> +	/*
> +	 * Allow multiple calls, but initialize only if not already initalized
> +	 * even if the previous call failed, coz, no reason we'd succeed again
> +	 */
> +	if (omap4_table_init)
> +		return 0;
> +	omap4_table_init = 1;
> +
> +	opp_def = omap44xx_opp_def_list;
> +
> +	for (i = 0; i < omap44xx_opp_def_size; i++) {
> +		r = opp_add(opp_def++);
> +		if (r)
> +			pr_err("unable to add OPP %ld Hz for %s\n",
> +				opp_def->freq, opp_def->hwmod_name);
> +	}
> +	return 0;
> +}
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 740e506..6707a2e 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -19,6 +19,7 @@
>  #include <plat/common.h>
>  
>  #include "omap3-opp.h"
> +#include "opp44xx.h"
>  
>  static struct omap_device_pm_latency *pm_lats;
>  
> @@ -90,7 +91,10 @@ static void omap2_init_processor_devices(void)
>  static int __init omap2_common_pm_init(void)
>  {
>  	omap2_init_processor_devices();
> -	omap3_pm_init_opp_table();
> +	if (cpu_is_omap34xx())
> +		omap3_pm_init_opp_table();
> +	else if (cpu_is_omap44xx())
> +		omap4_pm_init_opp_table();
>  
>  	omap_pm_if_init();

From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 2/3] omap4: opp: add OPP table data
Date: Mon, 22 Nov 2010 14:45:04 -0800
Message-ID: <87oc9hm0zz.fsf@deeprootsystems.com>
References: <1289933661-19505-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:35792 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757701Ab0KVWpI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 17:45:08 -0500
Received: by pxi15 with SMTP id 15so1687179pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 14:45:08 -0800 (PST)
In-Reply-To: <1289933661-19505-3-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Tue, 16 Nov 2010 12:54:20 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>, Thomas <thomas.petazzoni@free-electrons.com>

Nishanth Menon <nm@ti.com> writes:

> This patch adds OPP tables for OMAP4. New file has been added to keep
> the OMAP4 opp tables and the registration of these tables with the
> generic opp framework by OMAP SoC OPP interface.
>
> Based on:
> http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=blob;f=arch/arm/mach-omap2/opp44xx_data.c;h=252e3d0cb6050a64f390b9311c1c4977d74f762a;hb=refs/heads/omap4_next
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Warning: http://lkml.org/lkml/2010/11/9/389
> Introduces ARCH_HAS_OPP which needs to be enabled as well
> for OMAP4 in Kconfig
>
> V4: switched data to .c file
> v3: http://marc.info/?l=linux-omap&m=128984926712794&w=2
> 	* switched to using device_initcall to autoinitialize the
> 	  opp tables
> v2: https://patchwork.kernel.org/patch/266921/
>
>  arch/arm/mach-omap2/Kconfig        |    1 +
>  arch/arm/mach-omap2/opp.c          |    3 +-
>  arch/arm/mach-omap2/opp4xxx_data.c |   49 ++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm.h           |    5 +++
>  4 files changed, 57 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/opp4xxx_data.c
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 93a91ff..0f1855a 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -45,6 +45,7 @@ config ARCH_OMAP4
>  	select ARM_GIC
>  	select PL310_ERRATA_588369
>  	select ARM_ERRATA_720789
> + 	select PM_OPP if PM

spaces before tab (reported by git-apply)

>  comment "OMAP Core Type"
>  	depends on ARCH_OMAP2
> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
> index 66e12be..48a553f 100644
> --- a/arch/arm/mach-omap2/opp.c
> +++ b/arch/arm/mach-omap2/opp.c
> @@ -131,4 +131,5 @@ static int __init omap_init_opp_table(struct omap_opp_def *opp_def,
>  
>  /* omap3 opps */
>  #include "opp3xxx_data.c"
> -
> +/* omap4 opps */
> +#include "opp4xxx_data.c"
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
> new file mode 100644
> index 0000000..6271774
> --- /dev/null
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -0,0 +1,49 @@
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
> + */
> +
> +static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
> +	/* MPU OPP1 - OPP50 */
> +	OPP_INITIALIZER("mpu", true, 300000000, 1100000),
> +	/* MPU OPP2 - OPP100 */
> +	OPP_INITIALIZER("mpu", true, 600000000, 1200000),
> +	/* MPU OPP3 - OPP-Turbo */
> +	OPP_INITIALIZER("mpu", false, 800000000, 1260000),
> +	/* MPU OPP4 - OPP-SB */
> +	OPP_INITIALIZER("mpu", false, 1008000000, 1350000),
> +	/* L3 OPP1 - OPP50 */
> +	OPP_INITIALIZER("l3_main_1", true, 100000000, 930000),
> +	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
> +	OPP_INITIALIZER("l3_main_1", true, 200000000, 1100000),
> +	/* TODO: add IVA, DSP, aess, fdif, gpu */
> +};
> +
> +/**
> + * omap4_opp_init() - initialize omap4 opp table
> + */
> +int __init omap4_opp_init(void)
> +{
> +	int r = -ENODEV;
> +
> +	if (!cpu_is_omap44xx())
> +		return r;
> +
> +	r = omap_init_opp_table(omap44xx_opp_def_list,
> +			ARRAY_SIZE(omap44xx_opp_def_list));
> +
> +	return r;
> +}
> +device_initcall(omap4_opp_init);
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 2031f15..a43e069 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -22,11 +22,16 @@ extern int omap3_idle_init(void);
>  
>  #if defined(CONFIG_PM_OPP)
>  extern int omap3_opp_init(void);
> +extern int omap4_opp_init(void);
>  #else
>  static inline int omap3_opp_init(void)
>  {
>  	return -EINVAL;
>  }
> +static inline int omap4_opp_init(void)
> +{
> +	return -EINVAL;
> +}
>  #endif

Now that these are device_initcalls, seems like they can be made static
and not callable externally.

Kevin


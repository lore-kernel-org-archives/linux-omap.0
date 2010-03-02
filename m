From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 07/16] OMAP3: PM: Adding smartreflex class 3 driver.
Date: Tue, 02 Mar 2010 11:36:42 -0800
Message-ID: <87y6iav7lh.fsf@deeprootsystems.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
	<1267003757-22456-2-git-send-email-thara@ti.com>
	<1267003757-22456-3-git-send-email-thara@ti.com>
	<1267003757-22456-4-git-send-email-thara@ti.com>
	<1267003757-22456-5-git-send-email-thara@ti.com>
	<1267003757-22456-6-git-send-email-thara@ti.com>
	<1267003757-22456-7-git-send-email-thara@ti.com>
	<1267003757-22456-8-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37122 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0CBTgr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 14:36:47 -0500
Received: by pwj8 with SMTP id 8so359468pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Mar 2010 11:36:46 -0800 (PST)
In-Reply-To: <1267003757-22456-8-git-send-email-thara@ti.com> (Thara Gopinath's message of "Wed\, 24 Feb 2010 14\:59\:08 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds smartreflex class 3 driver. This driver hooks
> up with the generic smartreflex driver smartreflex.c to abstract
> out class specific implementations out of the generic driver.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

I like this abstraction, but I don't like that it still uses OPP IDs.

So, before doing this, we need to get rid of OPP IDs from the
smartreflex layer and keep OPP ID usage isolated to SRF.

It appears the only reason we need OPP IDs in SR is because the Nvalue
tables are indexed by OPP ID in sr_enable().  

One way to fix this is for this SR layer to keep it's own mapping of
voltage to nvalue.  So instead of taking OPP ID, sr_enable() should
take a voltage (or frequency) and use that to look up the nvalue.

a couple other minor comments below...

> ---
>  arch/arm/mach-omap2/Makefile             |    1 +
>  arch/arm/mach-omap2/smartreflex-class3.c |   49 ++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/Kconfig               |   11 ++++++-
>  3 files changed, 60 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index f6f901f..cd8ab86 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX)	+= smartreflex.o
> +obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
>  
>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
>  AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
> diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
> new file mode 100644
> index 0000000..d2e98a5
> --- /dev/null
> +++ b/arch/arm/mach-omap2/smartreflex-class3.c
> @@ -0,0 +1,49 @@
> +/*
> + * Smart reflex Class 3 specific implementations
> + *
> + * Copyright (C) 2009 Texas Instruments, Inc.

2010

> + * Thara Gopinath <thara@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "smartreflex.h"
> +
> +static int sr_class3_enable(int id)
> +{
> +	int target_opp_no = 0;

insert blank line

> +	if (id == SR1)
> +		target_opp_no = get_vdd1_opp();
> +	else if (id == SR2)
> +		target_opp_no = get_vdd2_opp();
> +	if (!target_opp_no) {
> +		pr_warning("Targetopp not known.Cannot enable SR%d\n", id);
> +		return false;
> +	}

and here

> +	return sr_enable(id, target_opp_no);
> +}
>
> +static int sr_class3_disable(int id)
> +{
> +	int target_opp_no = 0;

blank line

> +	if (id == SR1)
> +		target_opp_no = get_vdd1_opp();
> +	else if (id == SR2)
> +		target_opp_no = get_vdd2_opp();
> +	sr_disable(id);

blank line

> +	return true;
> +}
> +/* SR class3 structure */
> +struct omap_smartreflex_class_data class3_data = {
> +	.enable = sr_class3_enable,
> +	.disable = sr_class3_disable,
> +};
> +
> +static int __init sr_class3_init(void)
> +{
> +	omap_sr_register_class(&class3_data);
> +	return 0;
> +}
> +late_initcall(sr_class3_init);
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index cef67f3..9d286e6 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -54,7 +54,7 @@ config OMAP_DEBUG_LEDS
>  
>  config OMAP_SMARTREFLEX
>  	bool "SmartReflex support"
> -	depends on ARCH_OMAP3 && TWL4030_CORE && PM
> +	depends on ARCH_OMAP3 && PM
>  	help
>  	  Say Y if you want to enable SmartReflex.
>  
> @@ -69,6 +69,15 @@ config OMAP_SMARTREFLEX
>  	  compensation for VDD1 and VDD2, user must write 1 to
>  	  /sys/power/sr_vddX_autocomp, where X is 1 or 2.
>  
> +config OMAP_SMARTREFLEX_CLASS3
> +	bool "Class 3 mode of Smartreflex Implementation"
> +	depends on OMAP_SMARTREFLEX && TWL4030_CORE
> +	help
> +	  Say Y to enable Class 3 implementation of Smartreflex
> +
> +	  Class 3 implementation of Smartreflex employs continuous hardware
> +	  voltage caliberation.
> +
>  config OMAP_SMARTREFLEX_TESTING
>  	bool "Smartreflex testing support"
>  	depends on OMAP_SMARTREFLEX
> -- 
> 1.7.0.rc1.33.g07cf0f

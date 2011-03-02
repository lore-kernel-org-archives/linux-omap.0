From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 02/17] omap4: pm: Add SAR RAM support
Date: Wed, 02 Mar 2011 13:56:45 -0800
Message-ID: <87vd016vaa.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:60195 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756306Ab1CBV4t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 16:56:49 -0500
Received: by mail-yx0-f181.google.com with SMTP id 8so151537yxm.12
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 13:56:48 -0800 (PST)
In-Reply-To: <1298112158-28469-3-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 19 Feb 2011 16:12:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> This patch adds SAR RAM support on OMAP4430. SAR RAM used to save
> and restore the HW context in low power modes.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/omap4-common.c         |   25 ++++++++++++++++++++++++-
>  arch/arm/mach-omap2/omap4-sar-layout.h     |   24 ++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
>  3 files changed, 49 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/omap4-sar-layout.h
>
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 559d227..48484a5 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -23,12 +23,14 @@
>  #include <mach/omap4-common.h>
>  #include <mach/omap-wakeupgen.h>
>  
> +#include "omap4-sar-layout.h"
> +
>  #ifdef CONFIG_CACHE_L2X0
>  void __iomem *l2cache_base;
>  #endif
>  
>  void __iomem *gic_dist_base_addr;
> -
> +void __iomem *sar_ram_base;
>  
>  void __init gic_init_irq(void)
>  {
> @@ -107,3 +109,24 @@ static int __init omap_l2_cache_init(void)
>  }
>  early_initcall(omap_l2_cache_init);
>  #endif
> +
> +/*
> + * SAR RAM used to save and restore the HW
> + * context in low power modes
> + */
> +static int __init omap4_sar_ram_init(void)
> +{
> +	/*
> +	 * To avoid code running on other OMAPs in
> +	 * multi-omap builds
> +	 */
> +	if (!cpu_is_omap44xx())
> +		return -ENODEV;
> +
> +	/* Static mapping, never released */
> +	sar_ram_base = ioremap(OMAP44XX_SAR_RAM_BASE, SZ_8K);
> +	BUG_ON(!sar_ram_base);

Again, a BUG is not approprate here.

Instead, other code needs to properly handle when sar_ram_base == NULL

> +	return 0;
> +}
> +early_initcall(omap4_sar_ram_init);
> diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
> new file mode 100644
> index 0000000..bb66816
> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap4-sar-layout.h
> @@ -0,0 +1,24 @@
> +/*
> + * omap4-sar-layout.h: OMAP4 SAR RAM layout header file
> + *
> + * Copyright (C) 2011 Texas Instruments, Inc.
> + * Santosh Shilimkar <santosh.shilimkar@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef OMAP_ARCH_OMAP4_SAR_LAYOUT_H
> +#define OMAP_ARCH_OMAP4_SAR_LAYOUT_H
> +
> +/*
> + * SAR BANK offsets from base address OMAP44XX_SAR_RAM_BASE
> + */
> +#define SAR_BANK1_OFFSET		0x0000
> +#define SAR_BANK2_OFFSET		0x1000
> +#define SAR_BANK3_OFFSET		0x2000
> +#define SAR_BANK4_OFFSET		0x3000
> +
> +extern void __iomem *sar_ram_base;

This patch creates this as global, but has no global users.

Also, personally, I don't like these 'base address as global pointer'
that are appearing throughout the OMAP4 code.  This one is continuing
the pattern of some others (gic_dist_base_addr, gic_cpu_base) etc., but
I'm not crazy about them.  BTW, the gic* ones also suffer from the BUG
problem and do not properly handle error conditions.

It would be much cleaner to keep this base address static (and local)
and just create some sar_read/write helpers that can be used from other
code.

Hmm, I see the assembly code uses this base address to.  For that, a
helper function to get the base address could be created.

Kevin


> +#endif
> diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
> index ea2b8a6..c0d478e 100644
> --- a/arch/arm/plat-omap/include/plat/omap44xx.h
> +++ b/arch/arm/plat-omap/include/plat/omap44xx.h
> @@ -45,6 +45,7 @@
>  #define OMAP44XX_WKUPGEN_BASE		0x48281000
>  #define OMAP44XX_MCPDM_BASE		0x40132000
>  #define OMAP44XX_MCPDM_L3_BASE		0x49032000
> +#define OMAP44XX_SAR_RAM_BASE		0x4a326000
>  
>  #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
>  #define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)

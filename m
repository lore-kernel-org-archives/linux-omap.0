From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: Re: [PATCH 1/4] [OMAP1] Add MMC board code common to HTC devices
Date: Tue, 1 Jun 2010 12:19:47 +0200
Message-ID: <20100601101947.GB4085@localhost.localdomain>
References: <1275110887-2918-1-git-send-email-darkstar6262@gmail.com> <1275110887-2918-2-git-send-email-darkstar6262@gmail.com>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.76.43]:37517 "EHLO smtp.seznam.cz"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753607Ab0FAIeY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Jun 2010 04:34:24 -0400
Content-Disposition: inline
In-Reply-To: <1275110887-2918-2-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linwizard-devel@lists.sf.net

On Fri, May 28, 2010 at 10:28:04PM -0700, Cory Maccarrone wrote:
> This change adds the htc-mmc.c and htc-mmc.h files that
> contain common setup code for many OMAP850-based HTC
> smartphones.  This code is a port of the code used by
> the linwizard project to support devices such as the
> HTC Wizard, HTC Herald, HTC Opal, etc.
> 
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> ---
>  arch/arm/mach-omap1/htc-mmc.c |  104 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap1/htc-mmc.h |   26 ++++++++++
>  2 files changed, 130 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap1/htc-mmc.c
>  create mode 100644 arch/arm/mach-omap1/htc-mmc.h
> 
> diff --git a/arch/arm/mach-omap1/htc-mmc.c b/arch/arm/mach-omap1/htc-mmc.c
> new file mode 100644
> index 0000000..4fa8bb4
> --- /dev/null
> +++ b/arch/arm/mach-omap1/htc-mmc.c
> @@ -0,0 +1,104 @@
> +/*
> + * linux/arch/arm/mach-omap1/htc-mmc.c
> + *
> + * Copyright (C) 2007 Instituto Nokia de Tecnologia - INdT
> + * Author: Felipe Balbi <felipe.lima@indt.org.br>
> + *
> + * This code is based on linux/arch/arm/mach-omap2/board-n800-mmc.c, which is:
> + * Copyright (C) 2006 Nokia Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <plat/mmc.h>
> +#include <asm/mach-types.h>
> +
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
> +
> +#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
> +
> +#define OMAP_MMC_REG_SYSC (0xfffb7800 + 0x32)
> +#define OMAP_MMC_REG_SYSS (0xfffb7800 + 0x34)

Where are these used?

> +static int slot_cover_open;
> +static struct device *mmc_device;
> +
> +static int htc_mmc_set_power(struct device *dev, int slot, int power_on,
> +				int vdd)
> +{
> +#ifdef CONFIG_MMC_DEBUG
> +	dev_dbg(dev, "Set slot %d power: %s (vdd %d)\n", slot + 1,
> +		power_on ? "on" : "off", vdd);
> +#endif
> +	if (slot != 0) {
> +		dev_err(dev, "No such slot %d\n", slot + 1);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}

No-op? 

> +static int htc_mmc_set_bus_mode(struct device *dev, int slot, int bus_mode)
> +{
> +#ifdef CONFIG_MMC_DEBUG
> +	dev_dbg(dev, "Set slot %d bus_mode %s\n", slot + 1,
> +		bus_mode == MMC_BUSMODE_OPENDRAIN ? "open-drain" : "push-pull");
> +#endif
> +	if (slot != 0) {
> +		dev_err(dev, "No such slot %d\n", slot + 1);
> +		return -ENODEV;
> +	}
> +
> +	/* Treated on upper level */
> +
> +	return bus_mode;
> +}
> +
> +static int htc_mmc_get_cover_state(struct device *dev, int slot)
> +{
> +	BUG_ON(slot != 0);
> +	return slot_cover_open;
> +}

Just a complicated way to return zero...

> +static int htc_mmc_late_init(struct device *dev)
> +{
> +	mmc_device = dev;
> +	return 0;
> +}

What is this good for?

> +static void htc_mmc_cleanup(struct device *dev)
> +{
> +}
> +
> +static struct omap_mmc_platform_data htc_mmc1_data = {
> +	.nr_slots                       = 1,
> +	.switch_slot                    = NULL,
> +	.init                           = htc_mmc_late_init,
> +	.cleanup                        = htc_mmc_cleanup,
> +	.slots[0]       = {
> +		.set_power              = htc_mmc_set_power,
> +		.set_bus_mode           = htc_mmc_set_bus_mode,
> +		.get_ro                 = NULL,
> +		.get_cover_state        = htc_mmc_get_cover_state,
> +		.ocr_mask               = MMC_VDD_28_29 | MMC_VDD_30_31 |
> +					  MMC_VDD_32_33 | MMC_VDD_33_34,
> +		.name                   = "mmcblk",
> +		.nomux                  = 1,
> +		.wires                  = 4,
> +		.switch_pin             = -1,
> +	},
> +};

To me above seems completely no-op, so it could be simplified this way:
static struct omap_mmc_platform_data htc_mmc1_data = {
	.nr_slots                       = 1,
	.switch_slot                    = NULL,
	.slots[0]       = {
		.ocr_mask               = MMC_VDD_28_29 | MMC_VDD_30_31 |
					  MMC_VDD_32_33 | MMC_VDD_33_34,
		.name                   = "mmcblk",
		.nomux                  = 1,
		.wires                  = 4,
		.switch_pin             = -1,
	},
};

Now, once this file contains only one structure definition, is it worth
to let it exist at all? What about adding it to board-htcherald.c instead?

> +
> +static struct omap_mmc_platform_data *htc_mmc_data[1];
> +
> +void __init htc_mmc_init(void)
> +{
> +	/* register it */
> +	htc_mmc_data[0] = &htc_mmc1_data;
> +	omap1_init_mmc(htc_mmc_data, 1);
> +}
> +#endif
> +
> diff --git a/arch/arm/mach-omap1/htc-mmc.h b/arch/arm/mach-omap1/htc-mmc.h
> new file mode 100644
> index 0000000..480de14
> --- /dev/null
> +++ b/arch/arm/mach-omap1/htc-mmc.h
> @@ -0,0 +1,26 @@
> +/*
> + * linux/arch/arm/mach-omap1/htc-mmc.h
> + *
> + * Copyright (C) 2007 Instituto Nokia de Tecnologia - INdT
> + * Author: Felipe Balbi <felipe.lima@indt.org.br>
> + *
> + * This code is based on linux/arch/arm/mach-omap2/board-n800-mmc.c, which is:
> + * Copyright (C) 2006 Nokia Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __HTC_MMC_H
> +#define __HTC_MMC_H
> +
> +#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
> +extern void htc_mmc_init(void);
> +#else
> +static inline void htc_mmc_init(void)
> +{
> +}
> +#endif
> +
> +#endif /* __HTC_MMC_H */
> +
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

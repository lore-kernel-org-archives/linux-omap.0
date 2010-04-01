From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/8] OMAP2PLUS:GPIO:Add OMAP2PLUS specific gpio support
Date: Thu, 1 Apr 2010 02:30:21 -0700
Message-ID: <20100401093020.GF31200@atomide.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
 <1270038239-1090-2-git-send-email-charu@ti.com>
 <1270038239-1090-3-git-send-email-charu@ti.com>
 <1270038239-1090-4-git-send-email-charu@ti.com>
 <1270038239-1090-5-git-send-email-charu@ti.com>
 <1270038239-1090-6-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51253 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930Ab0DAJ2b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 05:28:31 -0400
Content-Disposition: inline
In-Reply-To: <1270038239-1090-6-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com

* Charulatha V <charu@ti.com> [100331 05:15]:
> --- /dev/null
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -0,0 +1,36 @@
> +/*
> + * gpio.c - OMAP2PLUS architecture specific common gpio code
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + *
> + * Author:
> + *	Charulatha V <charu@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <mach/gpio.h>

Should be include <linux/gpio.h>

> +void __init omap_gpio_early_init(void)
> +{
> +	struct platform_device **pdev;
> +	int no_of_dev;
> +
> +	if (cpu_is_omap24xx()) {
> +		omap2_gpio_init_data();
> +		no_of_dev = omap2_early_init_gpio(&pdev);
> +	} else if (cpu_is_omap34xx()) {
> +		omap3_gpio_init_data();
> +		no_of_dev = omap3_early_init_gpio(&pdev);
> +	} else if (cpu_is_omap44xx()) {
> +		omap4_gpio_init_data();
> +		no_of_dev = omap4_early_init_gpio(&pdev);
> +	} else
> +		return;
> +
> +	early_platform_add_devices(pdev, no_of_dev);
> +	early_platform_driver_register_all("earlygpio");
> +	early_platform_driver_probe("earlygpio", no_of_dev, 0);
> +}
> diff --git a/arch/arm/mach-omap2/include/mach/gpio.h b/arch/arm/mach-omap2/include/mach/gpio.h
> index d2d9d17..3a0fcb1 100644
> --- a/arch/arm/mach-omap2/include/mach/gpio.h
> +++ b/arch/arm/mach-omap2/include/mach/gpio.h
> @@ -115,4 +115,5 @@ extern void omap4_gpio_init_data(void);
>  extern int omap2_early_init_gpio(struct platform_device ***pdev);
>  extern int omap3_early_init_gpio(struct platform_device ***pdev);
>  extern int omap4_early_init_gpio(struct platform_device ***pdev);
> +extern void __init omap_gpio_early_init(void);
>  #endif

Uhh, is this some April fool's day joke? :)

To me it looks like you have no need for ***pdev, just swap the init
code around so the omap specific code calls omap_gpio_init with the
platform data.

Regards,

Tony

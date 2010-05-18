From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09/11] OMAP: GPIO: Introduce support for OMAP2PLUS chip
 GPIO init
Date: Tue, 18 May 2010 16:46:49 -0700
Message-ID: <20100518234649.GW5818@atomide.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
 <1274194260-16401-2-git-send-email-charu@ti.com>
 <1274194260-16401-3-git-send-email-charu@ti.com>
 <1274194260-16401-4-git-send-email-charu@ti.com>
 <1274194260-16401-5-git-send-email-charu@ti.com>
 <1274194260-16401-6-git-send-email-charu@ti.com>
 <1274194260-16401-7-git-send-email-charu@ti.com>
 <1274194260-16401-8-git-send-email-charu@ti.com>
 <1274194260-16401-9-git-send-email-charu@ti.com>
 <1274194260-16401-10-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49694 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0ERXqw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 19:46:52 -0400
Content-Disposition: inline
In-Reply-To: <1274194260-16401-10-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, khilman@deeprootsystems.com

* Charulatha V <charu@ti.com> [100518 07:44]:
> This patch adds support for handling GPIO as a HWMOD FW adapted
> platform device for OMAP2PLUS chips.
> 
> Signed-off-by: Charulatha V <charu@ti.com>

> --- /dev/null
> +++ b/arch/arm/mach-omap2/gpio.c
> +
> +/*
> + * gpio_init needs to be done before
> + * machine_init functions access gpio APIs.
> + * Hence gpio_init is a postcore_initcall.
> + */
> +#ifdef CONFIG_ARCH_OMAP2
> +static int __init omap242x_gpio_init(void)
> +{	if (!cpu_is_omap2420())
> +		return -EINVAL;
> +
> +	return gpio_init(METHOD_GPIO_24XX);
> +}
> +postcore_initcall(omap242x_gpio_init);
> +
> +static int __init omap243x_gpio_init(void)
> +{
> +	if (!cpu_is_omap2430())
> +		return -EINVAL;
> +
> +	return gpio_init(METHOD_GPIO_24XX);
> +}
> +postcore_initcall(omap243x_gpio_init);
> +#endif
> +
> +#ifdef CONFIG_ARCH_OMAP3
> +static int __init omap3xxx_gpio_init(void)
> +{
> +	if (!cpu_is_omap34xx())
> +		return -EINVAL;
> +
> +	return gpio_init(METHOD_GPIO_24XX);
> +}
> +postcore_initcall(omap3xxx_gpio_init);
> +#endif
> +
> +#ifdef CONFIG_ARCH_OMAP4
> +static int __init omap44xx_gpio_init(void)
> +{
> +	if (!cpu_is_omap44xx())
> +		return -EINVAL;
> +
> +	return gpio_init(METHOD_GPIO_44XX);
> +}
> +postcore_initcall(omap44xx_gpio_init);
> +#endif

What was the reason again for using postcore_initcall? You mentioned
it somewhere, but I forgot already.. Maybe put that into the patch
description too?

Regards,

Tony

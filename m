From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH, RFC] default machine descriptor for multiplatform
Date: Thu, 31 Jan 2013 11:52:32 -0700
Message-ID: <510ABD70.1020408@wwwdotorg.org>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk> <20130131161823.GT2637@n2100.arm.linux.org.uk> <1731670.s76EGcEZ7m@wuerfel> <1638002.UJ7zfj1Wn5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:40042 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756638Ab3AaSwn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 13:52:43 -0500
In-Reply-To: <1638002.UJ7zfj1Wn5@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, Fabio Estevam <festevam@gmail.com>

On 01/31/2013 10:51 AM, Arnd Bergmann wrote:
> This is what I think it would look like to do a default platform
> with an empty machine descriptor on ARM. It makes the few required
> entries in the descriptor optional by using the new irqchip_init()
> and clocksource_of_init() functions as defaults, and adds
> a fallback for the DT case to customize_machine to probe all
> the default devices.
> 
> For the case that CONFIG_MULTIPLATFORM is enabled, it then
> adds a machine descriptor that never matches any machine but
> is used as a fallback if nothing else matches.

> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c

>  static int __init customize_machine(void)
>  {
> -	/* customizes platform devices, or adds new ones */
> +	/*
> +	 * customizes platform devices, or adds new ones
> +	 * On DT based machines, we fall back to populating the
> +	 * machine from the device tree, if no callback is provided,
> +	 * otherwise we would always need an init_machine callback.
> +	 */
>  	if (machine_desc->init_machine)
>  		machine_desc->init_machine();
> +	else
> +		of_platform_populate(NULL, of_default_bus_match_table,
> +					NULL, NULL);

With that change, we can remove the custom .init_machine() functions for
all of Tegra, since they just do that:-)

> diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c

> +#ifdef CONFIG_IRQCHIP
>  void __init irqchip_init(void)
>  {
>  	of_irq_init(__irqchip_begin);
>  }
> +#else
> +static inline void irqchip_init(void)
> +{
> +}
> +#endif

That'd need to go in a header file.

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/9] OMAP:GPIO: Introduce support for OMAP2PLUS chip
 specific GPIO
Date: Wed, 5 May 2010 15:31:47 -0700
Message-ID: <20100505223147.GG29604@atomide.com>
References: <1271951720-21714-1-git-send-email-charu@ti.com>
 <1271951720-21714-2-git-send-email-charu@ti.com>
 <1271951720-21714-3-git-send-email-charu@ti.com>
 <1271951720-21714-4-git-send-email-charu@ti.com>
 <1271951720-21714-5-git-send-email-charu@ti.com>
 <1271951720-21714-6-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52227 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab0EEWbt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 18:31:49 -0400
Content-Disposition: inline
In-Reply-To: <1271951720-21714-6-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, khilman@deeprootsystems.com

* Charulatha V <charu@ti.com> [100422 08:50]:
> This patch adds support for handling GPIO as a HWMOD adapted
> platform device for OMAP2PLUS chips.

<snip>

> +int __init gpio_init(void)
> +{
> +	int i = 0;
> +	static int is_early_device = true;
> +
> +	do {
> +		struct omap_device *od;
> +		struct omap_hwmod *oh;
> +		int hw_mod_name_len = 16;
> +		int l;
> +		char oh_name[hw_mod_name_len];
> +		struct omap_gpio_platform_data *pdata;
> +		char *name = "omap-gpio";
> +
> +		l = snprintf(oh_name, hw_mod_name_len, "gpio%d_hwmod", i + 1);
> +		WARN(l >= hw_mod_name_len,
> +			"String buffer overflow in GPIO device setup\n");
> +
> +		oh = omap_hwmod_lookup(oh_name);
> +		if (!oh) {
> +			pr_err("Could not look up %s\n", oh_name);
> +			i++;
> +			continue;
> +		}
> +
> +		pdata = kzalloc(sizeof(struct omap_gpio_platform_data),
> +					GFP_KERNEL);
> +		if (!pdata) {
> +			pr_err("Memory allocation failed gpio%d\n", i + 1);
> +			return -ENOMEM;
> +		}
> +		pdata->base = oh->_rt_va;
> +		pdata->irq = oh->mpu_irqs[0].irq;
> +		if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +			pdata->method = METHOD_GPIO_24XX;
> +		if (cpu_is_omap44xx())
> +			pdata->method = METHOD_GPIO_44XX;
> +		pdata->virtual_irq_start = IH_GPIO_BASE + 32 * i;
> +		pdata->device_enable = omap_device_enable;
> +		pdata->device_idle = omap_device_idle;
> +		pdata->device_shutdown = omap_device_shutdown;
> +
> +		od = omap_device_build(name, i, oh, pdata,
> +					sizeof(*pdata),	omap_gpio_latency,
> +					ARRAY_SIZE(omap_gpio_latency),
> +					is_early_device);
> +		WARN(IS_ERR(od), "Cant build omap_device for %s:%s.\n",
> +					name, oh->name);
> +
> +		i++;
> +	} while (i < gpio_bank_count);
> +	is_early_device = false;
> +
> +	return 0;
> +}
> +arch_initcall(gpio_init);

You can get rid of most of the cpu_is_omapxxxx in gpio_init if you pass
the method as a parameter to gpio_init(int method). We should only need
to use cpu_is_omap exactly once for every init.

> +int __init omap2_gpio_init(void)
> +{
> +	if (cpu_is_omap242x())
> +		gpio_bank_count = 4;
> +	else if (cpu_is_omap243x())
> +		gpio_bank_count = 5;
> +	else if (cpu_is_omap34xx() || cpu_is_omap44xx())
> +		gpio_bank_count = OMAP34XX_NR_GPIOS;
> +
> +	if (gpio_init())
> +		return -EINVAL;
> +
> +	early_platform_driver_register_all("earlygpio");
> +	early_platform_driver_probe("earlygpio", gpio_bank_count, 0);
> +	return 0;
> +}

Then please replace this init with something like:

#ifdef CONFIG_ARCH_OMAP2
int __init omap242x_gpio_init(void)
{
	if (!cpu_is_omap2420())
		return -EINVAL;

	gpio_bank_count = 4;

	return gpio_init(METHOD_GPIO_24XX);
}
subsys_initcall(omap242x_gpio_init);

int __init omap243x_gpio_init(void)
{
	if (!cpu_is_omap2430())
		return -EINVAL;

	gpio_bank_count = 5;

	return gpio_init(METHOD_GPIO_24XX);
}
subsys_initcall(omap243x_gpio_init);
#endif

#ifdef CONFIG_ARCH_OMAP3
int __init omap34xx_gpio_init(void)
{
	if (!cpu_is_omap34xx())
		return -EINVAL;

	gpio_bank_count = OMAP34X_NR_GPIOS;

	return gpio_init(METHOD_GPIO_34XX);
}
subsys_initcall(omap34xx_gpio_init);
#endif
...

This way it will be more future proof when new omaps get added
and the if else stuff disappears. Also then you'll have an omap
specific function to initialize the gpio stuff.

Note that then early_platform_driver_register_all and
early_platform_driver_probe can be moved to gpio_init.

With multi-omap build the subsys_initcall runs for all of the
selected platforms, but returns early except for the machine
we're running on. All the code is optimized out for omap
specific product kernels.

Regards,

Tony

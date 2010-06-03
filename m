From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/9] OMAP: Convert dual mode timer into a platform driver.
Date: Thu, 03 Jun 2010 12:47:14 -0700
Message-ID: <87wrufoq4d.fsf@deeprootsystems.com>
References: <1275143831-7629-1-git-send-email-thara@ti.com>
	<1275143831-7629-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61165 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab0FCTrS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 15:47:18 -0400
Received: by pwj2 with SMTP id 2so241026pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 12:47:18 -0700 (PDT)
In-Reply-To: <1275143831-7629-2-git-send-email-thara@ti.com> (Thara Gopinath's message of "Sat\, 29 May 2010 20\:07\:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch converts dual mode timer library into a platform driver.
> This essentially involves moving out interrupt and base address
> related info from plat-omap/dmtimer.c and making certain clock related
> functions platform data. This patch also initializes dm timer driver as
> a earlydriver. This is so that early timer devices required during
> system boot up can be initialized very early on.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/plat-omap/dmtimer.c              |  401 ++++++++++++-----------------
>  arch/arm/plat-omap/include/plat/dmtimer.h |   12 +-
>  2 files changed, 176 insertions(+), 237 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 4d99dfb..c17911d 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -10,6 +10,9 @@
>   * Copyright (C) 2009 Texas Instruments
>   * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
>   *
> + * Copyright (C) 2010 Texas Instruments
> + * Converted to a platform driver - Thara Gopinath <thara@ti.com>
> + *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License as published by the
>   * Free Software Foundation; either version 2 of the License, or (at your
> @@ -32,11 +35,14 @@
>  #include <linux/init.h>
>  #include <linux/spinlock.h>
>  #include <linux/errno.h>
> +#include <linux/err.h>
>  #include <linux/list.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/slab.h>
> +
>  #include <mach/hardware.h>
>  #include <plat/dmtimer.h>
>  #include <mach/irqs.h>
> @@ -153,136 +159,18 @@
>  struct omap_dm_timer {
>  	unsigned long phys_base;
>  	int irq;
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -	struct clk *iclk, *fclk;
> -#endif
>  	void __iomem *io_base;
>  	unsigned reserved:1;
>  	unsigned enabled:1;
>  	unsigned posted:1;
> +	unsigned is_intialized:1;

typo: is_initialized.

> +	struct platform_device *pdev;
>  };
>  
> -static int dm_timer_count;
> -
> -#ifdef CONFIG_ARCH_OMAP1
> -static struct omap_dm_timer omap1_dm_timers[] = {
> -	{ .phys_base = 0xfffb1400, .irq = INT_1610_GPTIMER1 },
> -	{ .phys_base = 0xfffb1c00, .irq = INT_1610_GPTIMER2 },
> -	{ .phys_base = 0xfffb2400, .irq = INT_1610_GPTIMER3 },
> -	{ .phys_base = 0xfffb2c00, .irq = INT_1610_GPTIMER4 },
> -	{ .phys_base = 0xfffb3400, .irq = INT_1610_GPTIMER5 },
> -	{ .phys_base = 0xfffb3c00, .irq = INT_1610_GPTIMER6 },
> -	{ .phys_base = 0xfffb7400, .irq = INT_1610_GPTIMER7 },
> -	{ .phys_base = 0xfffbd400, .irq = INT_1610_GPTIMER8 },
> -};
> -
> -static const int omap1_dm_timer_count = ARRAY_SIZE(omap1_dm_timers);
> -
> -#else
> -#define omap1_dm_timers			NULL
> -#define omap1_dm_timer_count		0
> -#endif	/* CONFIG_ARCH_OMAP1 */
> -
> -#ifdef CONFIG_ARCH_OMAP2
> -static struct omap_dm_timer omap2_dm_timers[] = {
> -	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
> -	{ .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2 },
> -	{ .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3 },
> -	{ .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4 },
> -	{ .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5 },
> -	{ .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6 },
> -	{ .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7 },
> -	{ .phys_base = 0x48082000, .irq = INT_24XX_GPTIMER8 },
> -	{ .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9 },
> -	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
> -	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
> -	{ .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12 },
> -};
> -
> -static const char *omap2_dm_source_names[] __initdata = {
> -	"sys_ck",
> -	"func_32k_ck",
> -	"alt_ck",
> -	NULL
> -};
> -
> -static struct clk *omap2_dm_source_clocks[3];
> -static const int omap2_dm_timer_count = ARRAY_SIZE(omap2_dm_timers);
> -
> -#else
> -#define omap2_dm_timers			NULL
> -#define omap2_dm_timer_count		0
> -#define omap2_dm_source_names		NULL
> -#define omap2_dm_source_clocks		NULL
> -#endif	/* CONFIG_ARCH_OMAP2 */
> -
> -#ifdef CONFIG_ARCH_OMAP3
> -static struct omap_dm_timer omap3_dm_timers[] = {
> -	{ .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1 },
> -	{ .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2 },
> -	{ .phys_base = 0x49034000, .irq = INT_24XX_GPTIMER3 },
> -	{ .phys_base = 0x49036000, .irq = INT_24XX_GPTIMER4 },
> -	{ .phys_base = 0x49038000, .irq = INT_24XX_GPTIMER5 },
> -	{ .phys_base = 0x4903A000, .irq = INT_24XX_GPTIMER6 },
> -	{ .phys_base = 0x4903C000, .irq = INT_24XX_GPTIMER7 },
> -	{ .phys_base = 0x4903E000, .irq = INT_24XX_GPTIMER8 },
> -	{ .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9 },
> -	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
> -	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
> -	{ .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ },
> -};
> -
> -static const char *omap3_dm_source_names[] __initdata = {
> -	"sys_ck",
> -	"omap_32k_fck",
> -	NULL
> -};
> -
> -static struct clk *omap3_dm_source_clocks[2];
> -static const int omap3_dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
> -
> -#else
> -#define omap3_dm_timers			NULL
> -#define omap3_dm_timer_count		0
> -#define omap3_dm_source_names		NULL
> -#define omap3_dm_source_clocks		NULL
> -#endif	/* CONFIG_ARCH_OMAP3 */
> -
> -#ifdef CONFIG_ARCH_OMAP4
> -static struct omap_dm_timer omap4_dm_timers[] = {
> -	{ .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1 },
> -	{ .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2 },
> -	{ .phys_base = 0x48034000, .irq = OMAP44XX_IRQ_GPT3 },
> -	{ .phys_base = 0x48036000, .irq = OMAP44XX_IRQ_GPT4 },
> -	{ .phys_base = 0x40138000, .irq = OMAP44XX_IRQ_GPT5 },
> -	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT6 },
> -	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT7 },
> -	{ .phys_base = 0x4013e000, .irq = OMAP44XX_IRQ_GPT8 },
> -	{ .phys_base = 0x4803e000, .irq = OMAP44XX_IRQ_GPT9 },
> -	{ .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10 },
> -	{ .phys_base = 0x48088000, .irq = OMAP44XX_IRQ_GPT11 },
> -	{ .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12 },
> -};
> -static const char *omap4_dm_source_names[] __initdata = {
> -	"sys_ck",
> -	"omap_32k_fck",
> -	NULL
> -};
> -static struct clk *omap4_dm_source_clocks[2];
> -static const int omap4_dm_timer_count = ARRAY_SIZE(omap4_dm_timers);
> -
> -#else
> -#define omap4_dm_timers			NULL
> -#define omap4_dm_timer_count		0
> -#define omap4_dm_source_names		NULL
> -#define omap4_dm_source_clocks		NULL
> -#endif	/* CONFIG_ARCH_OMAP4 */
> -
> +int omap_dm_timer_count;
>  static struct omap_dm_timer *dm_timers;
> -static const char **dm_source_names;
> -static struct clk **dm_source_clocks;
> -
>  static spinlock_t dm_timer_lock;
> +static int is_driver_init;
>  
>  /*
>   * Reads timer registers in posted and non-posted mode. The posted mode bit
> @@ -368,7 +256,7 @@ struct omap_dm_timer *omap_dm_timer_request(void)
>  	int i;
>  
>  	spin_lock_irqsave(&dm_timer_lock, flags);
> -	for (i = 0; i < dm_timer_count; i++) {
> +	for (i = 0; i < omap_dm_timer_count; i++) {
>  		if (dm_timers[i].reserved)
>  			continue;
>  
> @@ -391,7 +279,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&dm_timer_lock, flags);
> -	if (id <= 0 || id > dm_timer_count || dm_timers[id-1].reserved) {
> +	if (id <= 0 || id > omap_dm_timer_count || dm_timers[id-1].reserved) {
>  		spin_unlock_irqrestore(&dm_timer_lock, flags);
>  		printk("BUG: warning at %s:%d/%s(): unable to get timer %d\n",
>  		       __FILE__, __LINE__, __func__, id);
> @@ -422,32 +310,32 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
>  
>  void omap_dm_timer_enable(struct omap_dm_timer *timer)
>  {
> +	struct omap_dm_timer_plat_info *pdata = timer->pdev->dev.platform_data;
> +
>  	if (timer->enabled)
>  		return;
>  
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -	if (cpu_class_is_omap2()) {
> -		clk_enable(timer->fclk);
> -		clk_enable(timer->iclk);
> -	}
> -#endif
> -
> +	if (pdata->omap_dm_clk_enable)
> +		pdata->omap_dm_clk_enable(timer->pdev);
> +	else
> +		dev_warn(&timer->pdev->dev, "%s: No enable fn registered\n",
> +				__func__);
>  	timer->enabled = 1;
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
>  
>  void omap_dm_timer_disable(struct omap_dm_timer *timer)
>  {
> +	struct omap_dm_timer_plat_info *pdata = timer->pdev->dev.platform_data;
> +
>  	if (!timer->enabled)
>  		return;
>  
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -	if (cpu_class_is_omap2()) {
> -		clk_disable(timer->iclk);
> -		clk_disable(timer->fclk);
> -	}
> -#endif
> -
> +	if (pdata->omap_dm_clk_disable)
> +		pdata->omap_dm_clk_disable(timer->pdev);
> +	else
> +		dev_warn(&timer->pdev->dev, "%s: No disable fn registered\n",
> +				__func__);
>  	timer->enabled = 0;
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
> @@ -458,22 +346,26 @@ int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
>  
> -#if defined(CONFIG_ARCH_OMAP1)
> -
>  /**
>   * omap_dm_timer_modify_idlect_mask - Check if any running timers use ARMXOR
> + *					valid only for OMAP1
>   * @inputmask: current value of idlect mask
>   */
>  __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
>  {
>  	int i;
>  
> +	if (cpu_class_is_omap2()) {
> +		BUG();
> +		return 0;
> +	}
> +
>  	/* If ARMXOR cannot be idled this function call is unnecessary */
>  	if (!(inputmask & (1 << 1)))
>  		return inputmask;
>  
>  	/* If any active timer is using ARMXOR return modified mask */
> -	for (i = 0; i < dm_timer_count; i++) {
> +	for (i = 0; i < omap_dm_timer_count; i++) {
>  		u32 l;
>  
>  		l = omap_dm_timer_read_reg(&dm_timers[i], OMAP_TIMER_CTRL_REG);
> @@ -489,23 +381,18 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
>  
> -#else
> -
>  struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
>  {
> -	return timer->fclk;
> -}
> -EXPORT_SYMBOL_GPL(omap_dm_timer_get_fclk);
> +	struct omap_dm_timer_plat_info *pdata = timer->pdev->dev.platform_data;
>  
> -__u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
> -{
> -	BUG();
> +	if (pdata->omap_dm_get_timer_clk)
> +		return pdata->omap_dm_get_timer_clk(timer->pdev);
>  
> -	return 0;
> +	dev_warn(&timer->pdev->dev, "%s: No get fclk clock fn registered\n",
> +		       __func__);
> +	return ERR_PTR(-EINVAL);
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
> -
> -#endif
> +EXPORT_SYMBOL_GPL(omap_dm_timer_get_fclk);
>  
>  void omap_dm_timer_trigger(struct omap_dm_timer *timer)
>  {
> @@ -531,64 +418,47 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
>  
>  	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
>  	if (l & OMAP_TIMER_CTRL_ST) {
> +		struct clk *timer_fclk;
> +
>  		l &= ~0x1;
>  		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> +
> +		if (cpu_class_is_omap1())
> +			return;
> +
>  		/* Readback to make sure write has completed */
>  		omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
>  		 /*
>  		  * Wait for functional clock period x 3.5 to make sure that
>  		  * timer is stopped
>  		  */
> -		udelay(3500000 / clk_get_rate(timer->fclk) + 1);
> +		timer_fclk = omap_dm_timer_get_fclk(timer);
> +		if (IS_ERR(timer_fclk))
> +			dev_warn(&timer->pdev->dev, "%s: Unable to get"
> +				"timer fclk!\n", __func__);
> +		else
> +			udelay(3500000 / clk_get_rate(timer_fclk) + 1);
> +
>  		/* Ack possibly pending interrupt */
>  		omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
>  				OMAP_TIMER_INT_OVERFLOW);
> -#endif
>  	}
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
>  
> -#ifdef CONFIG_ARCH_OMAP1
> -
> -int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
> -{
> -	int n = (timer - dm_timers) << 1;
> -	u32 l;
> -
> -	l = omap_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
> -	l |= source << n;
> -	omap_writel(l, MOD_CONF_CTRL_1);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
> -
> -#else
> -
>  int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
>  {
> -	int ret = -EINVAL;
> +	struct omap_dm_timer_plat_info *pdata = timer->pdev->dev.platform_data;
>  
> -	if (source < 0 || source >= 3)
> -		return -EINVAL;
> -
> -	clk_disable(timer->fclk);
> -	ret = clk_set_parent(timer->fclk, dm_source_clocks[source]);
> -	clk_enable(timer->fclk);
> -
> -	/*
> -	 * When the functional clock disappears, too quick writes seem
> -	 * to cause an abort. XXX Is this still necessary?
> -	 */
> -	__delay(150000);
> +	if (pdata->omap_dm_set_source_clk)
> +		return pdata->omap_dm_set_source_clk(timer->pdev, source);
>  
> -	return ret;
> +	dev_warn(&timer->pdev->dev, "%s: No set source clock fn registered\n",
> +	       __func__);
> +	return -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
>  
> -#endif
> -
>  void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
>  			    unsigned int load)
>  {
> @@ -716,7 +586,7 @@ int omap_dm_timers_active(void)
>  {
>  	int i;
>  
> -	for (i = 0; i < dm_timer_count; i++) {
> +	for (i = 0; i < omap_dm_timer_count; i++) {
>  		struct omap_dm_timer *timer;
>  
>  		timer = &dm_timers[i];
> @@ -733,61 +603,120 @@ int omap_dm_timers_active(void)
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timers_active);
>  
> -int __init omap_dm_timer_init(void)
> +static int __devinit omap_dm_timer_data_init(void)
>  {
> -	struct omap_dm_timer *timer;
> -	int i, map_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
> +	if (!is_driver_init) {
> +		is_driver_init = 1;
> +		spin_lock_init(&dm_timer_lock);
> +		if (!omap_dm_timer_count) {
> +			pr_err("%s: OMAP DMTIMER - Number of dmtimers in"
> +				"the system not defined.Error!\n", __func__);
> +			return -EINVAL;
> +		}
> +		dm_timers = kzalloc(omap_dm_timer_count *
> +				sizeof(struct omap_dm_timer), GFP_KERNEL);
> +		if (!dm_timers) {
> +			pr_err("%s: OMAPP DMTIMER - Unable to allocate"
> +				"dm_timers\n", __func__);
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}

I don't follow the need for this as a separate function.  Can't this
just live in _probe() with some error checking?

Also, it looks like the spin_lock_init() could be moved to after the
'is_initialized' check in probe.

> -	if (!(cpu_is_omap16xx() || cpu_class_is_omap2()))
> -		return -ENODEV;
> +static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
> +{
> +	struct omap_dm_timer_plat_info *pdata = pdev->dev.platform_data;
> +	struct resource *mem;
> +	int id = pdev->id;
> +	int ret;
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "%s: Timer device initialized without"
> +			"platform data\n", __func__);
> +		return -EINVAL;
> +	}
>  
> -	spin_lock_init(&dm_timer_lock);
> -
> -	if (cpu_class_is_omap1()) {
> -		dm_timers = omap1_dm_timers;
> -		dm_timer_count = omap1_dm_timer_count;
> -		map_size = SZ_2K;
> -	} else if (cpu_is_omap24xx()) {
> -		dm_timers = omap2_dm_timers;
> -		dm_timer_count = omap2_dm_timer_count;
> -		dm_source_names = omap2_dm_source_names;
> -		dm_source_clocks = omap2_dm_source_clocks;
> -	} else if (cpu_is_omap34xx()) {
> -		dm_timers = omap3_dm_timers;
> -		dm_timer_count = omap3_dm_timer_count;
> -		dm_source_names = omap3_dm_source_names;
> -		dm_source_clocks = omap3_dm_source_clocks;
> -	} else if (cpu_is_omap44xx()) {
> -		dm_timers = omap4_dm_timers;
> -		dm_timer_count = omap4_dm_timer_count;
> -		dm_source_names = omap4_dm_source_names;
> -		dm_source_clocks = omap4_dm_source_clocks;
> +	ret = omap_dm_timer_data_init();
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: Unable to do timer data init\n",
> +			__func__);
> +		return ret;
>  	}
>  
> -	if (cpu_class_is_omap2())
> -		for (i = 0; dm_source_names[i] != NULL; i++)
> -			dm_source_clocks[i] = clk_get(NULL, dm_source_names[i]);
> +	dm_timers[id].pdev = pdev;

I don't like the use of the id index here.  It makes _probe() assume that
there are multiple instances which it should not have to know.

Just make _probe() allocate memory for its own instance.

Kevin

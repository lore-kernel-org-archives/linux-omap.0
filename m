From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 9/9] OMAP:GPIO: Implement GPIO as a platform device
Date: Fri, 30 Apr 2010 17:04:26 -0700
Message-ID: <8739yca3n9.fsf@deeprootsystems.com>
References: <1271951720-21714-1-git-send-email-charu@ti.com>
	<1271951720-21714-2-git-send-email-charu@ti.com>
	<1271951720-21714-3-git-send-email-charu@ti.com>
	<1271951720-21714-4-git-send-email-charu@ti.com>
	<1271951720-21714-5-git-send-email-charu@ti.com>
	<1271951720-21714-6-git-send-email-charu@ti.com>
	<1271951720-21714-7-git-send-email-charu@ti.com>
	<1271951720-21714-8-git-send-email-charu@ti.com>
	<1271951720-21714-9-git-send-email-charu@ti.com>
	<1271951720-21714-10-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:46468 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053Ab0EAAEd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 20:04:33 -0400
Received: by iwn12 with SMTP id 12so951756iwn.15
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 17:04:31 -0700 (PDT)
In-Reply-To: <1271951720-21714-10-git-send-email-charu@ti.com> (Charulatha V.'s message of "Thu\, 22 Apr 2010 21\:25\:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, tony@atomide.com

Charulatha V <charu@ti.com> writes:

> This patch implements GPIO as a early platform device. Also it
> implements OMAP2PLUS specific GPIO as HWMOD FW adapted driver.

Should include a summary explanation of why you're converting to an
early platform device as well.

> Inorder to convert GPIO as platform device, modifications are
> required in clockxxxx_data.c files so that device names can be
> used to obtain clock instead of getting clocks by name/NULL ptr.

ok

> Currently early platform device register does not do device_pm_init.
> Hence pm_runtime functions are not used to enable the GPIO device
> since gpio is early platform device.

OK for now, since this isn't using runtime PM, but maybe we need a
late_initcall() here to do the device_pm_init() + pm_runtime_enable()

This change log needs more description of the intended init sequence.
Right now it seems that there are multiple init paths.  Now that GPIO
is an early_platform_device, we should be able to at least make
omap_gpio_init() static and remove its usage from all the board files.

Also, the driver and device separation and init is totally mixed
together and very confusing. The platform_driver is in
plat-omap/gpio.c and should be doing the driver init:
[early_]platform_driver_register() and _probe(). The platform_device
setup is in mach-omapX/gpio*.c and where the device init should be, in
this case early_platform_add_devices().


> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap1/Makefile           |    6 +
>  arch/arm/mach-omap1/clock_data.c       |    2 +-
>  arch/arm/mach-omap2/Makefile           |    2 +-
>  arch/arm/mach-omap2/clock2420_data.c   |   10 +-
>  arch/arm/mach-omap2/clock2430_data.c   |   14 +-
>  arch/arm/mach-omap2/clock3xxx_data.c   |   24 +-
>  arch/arm/mach-omap2/clock44xx_data.c   |   24 +-
>  arch/arm/plat-omap/gpio.c              |  405 ++++++++++++--------------------
>  arch/arm/plat-omap/include/plat/gpio.h |   21 ++
>  9 files changed, 220 insertions(+), 288 deletions(-)

[...]

> @@ -1621,6 +1501,34 @@ static void __init omap_gpio_show_rev(void)
>   */
>  static struct lock_class_key gpio_lock_class;
>  
> +static int init_gpio_info(void)
> +{
> +	gpio_bank_bits = 32;
> +
> +	if (cpu_is_omap15xx()) {
> +		gpio_bank_count = 2;
> +		gpio_bank_bits = 16;
> +	} else if (cpu_is_omap16xx()) {
> +		gpio_bank_count = 5;
> +		gpio_bank_bits = 16;
> +	} else if (cpu_is_omap7xx())
> +		gpio_bank_count = 7;
> +	else if (cpu_is_omap242x())
> +		gpio_bank_count = 4;
> +	else if (cpu_is_omap243x())
> +		gpio_bank_count = 5;
> +	else if (cpu_is_omap34xx() || cpu_is_omap44xx())
> +		gpio_bank_count = OMAP34XX_NR_GPIOS;

Both the bank count and bank bits could be part of platform_data
and set in the SoC specific init.  This is the GPIO driver part
and we're trying to make this as SoC independent as possible.  Anytime
you need to add a cpu_is* or #ifdef in this code indicates something
that should be part of SoC specific init and passed in.

> +	gpio_bank = kzalloc(gpio_bank_count * sizeof(struct gpio_bank),
> +				GFP_KERNEL);
> +	if (!gpio_bank) {
> +		pr_err("Memory allocation failed for gpio_bank\n");
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
>  static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
>  {
>  	if (cpu_class_is_omap2()) {
> @@ -1686,16 +1594,9 @@ static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
>  
>  static void __init omap_gpio_chip_init(struct gpio_bank *bank)
>  {
> -	int j, gpio_bank_bits = 16;
> +	int j;
>  	static int gpio;
>  
> -	if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX)
> -		gpio_bank_bits = 32; /* 7xx has 32-bit GPIOs */
> -
> -	if ((bank->method == METHOD_GPIO_24XX) ||
> -			(bank->method == METHOD_GPIO_44XX))
> -		gpio_bank_bits = 32;
> -
>  	bank->mod_usage = 0;
>  	/* REVISIT eventually switch from OMAP-specific gpio structs
>  	 * over to the generic ones
> @@ -1737,140 +1638,103 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
>  	set_irq_data(bank->irq, bank);
>  }
>  
> -static int __init _omap_gpio_init(void)
> +static inline void get_gpio_dbck(struct platform_device *pdev,
> +				struct gpio_bank *bank)
>  {
> -	int i;
> -	int gpio = 0;
> +	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> +		bank->dbck = clk_get(&pdev->dev, "dbck");
> +		if (IS_ERR(bank->dbck))
> +			pr_err("GPIO: Could not get dbck\n");
> +	}
> +}
> +static int __devinit omap_gpio_probe(struct platform_device *pdev)
> +{
> +	static int gpio_init_done;
> +	struct omap_gpio_platform_data *pdata;
> +	int id;
>  	struct gpio_bank *bank;
> -	int bank_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
> -	char clk_name[11];
> +	struct resource *res;
>  
> -	initialized = 1;
> +	if (!gpio_init_done)
> +		init_gpio_info();
>  
> -#if defined(CONFIG_ARCH_OMAP1)
> -	if (cpu_is_omap15xx()) {
> -		gpio_ick = clk_get(NULL, "arm_gpio_ck");
> -		if (IS_ERR(gpio_ick))
> -			printk("Could not get arm_gpio_ck\n");
> -		else
> -			clk_enable(gpio_ick);
> +	if (!pdev || !pdev->dev.platform_data) {
> +		pr_err("GPIO device initialize without"
> +					"platform data\n");
> +		return -EINVAL;
>  	}
> -#endif
> -#if defined(CONFIG_ARCH_OMAP2)
> -	if (cpu_class_is_omap2()) {
> -		gpio_ick = clk_get(NULL, "gpios_ick");
> -		if (IS_ERR(gpio_ick))
> -			printk("Could not get gpios_ick\n");
> -		else
> -			clk_enable(gpio_ick);
> -		gpio_fck = clk_get(NULL, "gpios_fck");
> -		if (IS_ERR(gpio_fck))
> -			printk("Could not get gpios_fck\n");
> -		else
> -			clk_enable(gpio_fck);
>  
> -		/*
> -		 * On 2430 & 3430 GPIO 5 uses CORE L4 ICLK
> -		 */
> -#if defined(CONFIG_ARCH_OMAP2430)
> -		if (cpu_is_omap2430()) {
> -			gpio5_ick = clk_get(NULL, "gpio5_ick");
> -			if (IS_ERR(gpio5_ick))
> -				printk("Could not get gpio5_ick\n");
> -			else
> -				clk_enable(gpio5_ick);
> -			gpio5_fck = clk_get(NULL, "gpio5_fck");
> -			if (IS_ERR(gpio5_fck))
> -				printk("Could not get gpio5_fck\n");
> -			else
> -				clk_enable(gpio5_fck);
> -		}
> -#endif
> -	}
> -#endif
> +	pdata = pdev->dev.platform_data;
>  
> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> -	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> -		for (i = 0; i < OMAP34XX_NR_GPIOS; i++) {
> -			sprintf(clk_name, "gpio%d_ick", i + 1);
> -			gpio_iclks[i] = clk_get(NULL, clk_name);
> -			if (IS_ERR(gpio_iclks[i]))
> -				printk(KERN_ERR "Could not get %s\n", clk_name);
> -			else
> -				clk_enable(gpio_iclks[i]);
> -		}
> +	id = pdev->id;
> +	if (id > gpio_bank_count) {
> +		pr_err("Invalid GPIO device id (%d)\n", id);
> +		return -EINVAL;
>  	}
> -#endif
>  
> +	bank = &gpio_bank[id];
>  
> -#ifdef CONFIG_ARCH_OMAP15XX
> -	if (cpu_is_omap15xx()) {
> -		gpio_bank_count = 2;
> -		gpio_bank = gpio_bank_1510;
> -		bank_size = SZ_2K;
> -	}
> -#endif
> -#if defined(CONFIG_ARCH_OMAP16XX)
> -	if (cpu_is_omap16xx()) {
> -		gpio_bank_count = 5;
> -		gpio_bank = gpio_bank_1610;
> -		bank_size = SZ_2K;
> -	}
> -#endif
> -#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> -	if (cpu_is_omap7xx()) {
> -		gpio_bank_count = 7;
> -		gpio_bank = gpio_bank_7xx;
> -		bank_size = SZ_2K;
> -	}
> -#endif
> -#ifdef CONFIG_ARCH_OMAP2
> -	if (cpu_is_omap242x()) {
> -		gpio_bank_count = 4;
> -		gpio_bank = gpio_bank_242x;
> -	}
> -	if (cpu_is_omap243x()) {
> -		gpio_bank_count = 5;
> -		gpio_bank = gpio_bank_243x;
> -	}
> -#endif
> -#ifdef CONFIG_ARCH_OMAP3
> -	if (cpu_is_omap34xx()) {
> -		gpio_bank_count = OMAP34XX_NR_GPIOS;
> -		gpio_bank = gpio_bank_34xx;
> +	if (bank->initialized == 1) {

is_early_platform_device() can be used to tell if the _probe() is
being called as part of early platform driver probe or "regular".

> +		/*
> +		 * Currently, for early platform_devices,
> +		 * clk_get() using dev ptr does not seem to be working
> +		 * Hence getting dbck during regular device probe
> +		 */

Need a better explanation here.  "does not seem to work" is not
quite good enough.

> +		get_gpio_dbck(pdev, bank);

In any case, maybe it's better to defer the clk_get() into
the debounce setup and only use if needed.

> +		return 0;
>  	}
> -#endif
> -#ifdef CONFIG_ARCH_OMAP4
> -	if (cpu_is_omap44xx()) {
> -		gpio_bank_count = OMAP34XX_NR_GPIOS;
> -		gpio_bank = gpio_bank_44xx;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (unlikely(!res)) {
> +		pr_err("GPIO Bank %i Invalid IRQ resource\n", id);
> +		return -ENODEV;
>  	}
> -#endif
> -	for (i = 0; i < gpio_bank_count; i++) {
> +	bank->irq = res->start;
> +	bank->virtual_irq_start = pdata->virtual_irq_start;
> +	bank->base = pdata->base;

Why are you using pdata->base for OMAP2+ base addresses...

> +	bank->method = pdata->method;
>  
> -		bank = &gpio_bank[i];
> -		spin_lock_init(&bank->lock);
> +	spin_lock_init(&bank->lock);
>  
> +	if (cpu_class_is_omap2()) {
> +		bank->device_enable = pdata->device_enable;
> +		bank->device_idle = pdata->device_idle;
> +		bank->device_shutdown = pdata->device_shutdown;
> +		pdata->device_enable(pdev);
> +	} else if (cpu_class_is_omap1()) {
>  		/* Static mapping, never released */
> -		bank->base = ioremap(bank->pbase, bank_size);
> -		if (!bank->base) {
> -			printk(KERN_ERR "Could not ioremap gpio bank%i\n", i);
> -			continue;
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

... and doing it the right way here for OMAP1?

platform_get_resource() should be used for both.

> +		if (unlikely(!res)) {
> +			pr_err("GPIO Bank %i Invalid mem resource\n", id);
> +			return -ENODEV;
>  		}
>  
> -		omap_gpio_mod_init(bank, i);
> -		omap_gpio_chip_init(bank);
> +		bank->base = ioremap(res->start, resource_size(res));
> +		if (!bank->base) {
> +			pr_err("Could not ioremap gpio bank%i\n", id);
> +			return -ENOMEM;
> +		}
>  
> -		if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> -			sprintf(clk_name, "gpio%d_dbck", i + 1);
> -			bank->dbck = clk_get(NULL, clk_name);
> -			if (IS_ERR(bank->dbck))
> -				printk(KERN_ERR "Could not get %s\n", clk_name);
> +		if (cpu_is_omap15xx() && (id == 0)) {
> +			static struct clk *gpio_clk;
> +			gpio_clk = clk_get(&pdev->dev, "arm_gpio_ck");
> +			if (IS_ERR(gpio_clk))
> +				pr_err("Could not get arm_gpio_ck\n");
> +			else
> +				clk_enable(gpio_clk);
>  		}
>  	}
>  
> -	omap_gpio_show_rev();
> +	omap_gpio_mod_init(bank, id);
> +	omap_gpio_chip_init(bank);
>  
> +	if (!gpio_init_done) {
> +		omap_gpio_show_rev();
> +		gpio_init_done = 1;
> +	}
> +
> +	bank->initialized = 1;

I think you can drop this flag, and use is_early_platform_device() if
needed.

>  	return 0;
>  }
>  
> @@ -2210,16 +2074,42 @@ void omap_gpio_restore_context(void)
>  }
>  #endif
>  
> -/*
> - * This may get called early from board specific init
> - * for boards that have interrupts routed via FPGA.
> - */
> +static struct platform_driver omap_gpio_driver = {
> +	.probe		= omap_gpio_probe,
> +	.driver		= {
> +		.name	= "omap-gpio",
> +	},
> +};
> +
> +int __init omap_gpio_drv_reg(void)
> +{
> +	return platform_driver_register(&omap_gpio_driver);
> +}
> +
> +early_platform_init("earlygpio", &omap_gpio_driver);
> +
>  int __init omap_gpio_init(void)
>  {
> -	if (!initialized)
> -		return _omap_gpio_init();
> -	else
> +	int ret = 0;
> +
> +	if (initialized)
>  		return 0;
> +
> +#ifdef CONFIG_ARCH_OMAP1
> +	if (cpu_is_omap7xx())
> +		ret = omap7xx_gpio_init();
> +	if (cpu_is_omap15xx())
> +		ret = omap15xx_gpio_init();
> +	if (cpu_is_omap16xx())
> +		ret = omap16xx_gpio_init();
> +#endif
> +#ifdef CONFIG_ARCH_OMAP2PLUS
> +	if (cpu_class_is_omap2())
> +		ret = omap2_gpio_init();
> +#endif

No thanks.  driver init should not be calling device init.  The device
init should have it's own initcall or be called by other early device
init.

> +	initialized = 1;
> +
> +	return ret;
>  }
>  
>  static int __init omap_gpio_sysinit(void)
> @@ -2227,7 +2117,10 @@ static int __init omap_gpio_sysinit(void)
>  	int ret = 0;
>  
>  	if (!initialized)
> -		ret = _omap_gpio_init();
> +		ret = omap_gpio_init();
> +
> +	if (!ret)
> +		ret = omap_gpio_drv_reg();
>  
>  	mpuio_init();

Kevin

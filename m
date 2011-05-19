From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 04/10] OMAP: GPIO: Remove dependency on gpio_bank_count
Date: Thu, 19 May 2011 17:42:50 +0200
Message-ID: <87ipt68znp.fsf@ti.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
	<1305546104-1511-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:52437 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751527Ab1ESPnA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 11:43:00 -0400
Received: by mail-wy0-f178.google.com with SMTP id 33so2601698wyb.23
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 08:42:59 -0700 (PDT)
In-Reply-To: <1305546104-1511-5-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Mon, 16 May 2011 17:11:38 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> gpio_bank_count is the count of number of GPIO devices
> in a SoC. Remove this dependency from the driver. Also remove
> the dependency on array of pointers to gpio_bank struct of
> all GPIO devices.
>
> The cpu_is*() checks used in omap2_gpio_prepare_for_idle() and
> omap2_gpio_resume_after_idle() would be removed in one of the
> patches in this series
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>


Nice.  I like this direction.... Some minor comments below...

> ---
>  arch/arm/mach-omap1/gpio15xx.c         |    1 -
>  arch/arm/mach-omap1/gpio16xx.c         |    2 -
>  arch/arm/mach-omap1/gpio7xx.c          |    2 -
>  arch/arm/mach-omap2/gpio.c             |    1 -
>  arch/arm/plat-omap/gpio.c              |  157 ++++++++++++++++---------------
>  arch/arm/plat-omap/include/plat/gpio.h |    3 -
>  6 files changed, 81 insertions(+), 85 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
> index c3caf25..7a15f69 100644
> --- a/arch/arm/mach-omap1/gpio15xx.c
> +++ b/arch/arm/mach-omap1/gpio15xx.c
> @@ -117,7 +117,6 @@ static int __init omap15xx_gpio_init(void)
>  	platform_device_register(&omap15xx_mpu_gpio);
>  	platform_device_register(&omap15xx_gpio);
>  
> -	gpio_bank_count = 2;
>  	return 0;
>  }
>  postcore_initcall(omap15xx_gpio_init);
> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
> index f62eaf3..43718ec 100644
> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@ -223,8 +223,6 @@ static int __init omap16xx_gpio_init(void)
>  	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
>  		platform_device_register(omap16xx_gpio_dev[i]);
>  
> -	gpio_bank_count = ARRAY_SIZE(omap16xx_gpio_dev);
> -
>  	return 0;
>  }
>  postcore_initcall(omap16xx_gpio_init);
> diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
> index 0fc2557..c7684ce 100644
> --- a/arch/arm/mach-omap1/gpio7xx.c
> +++ b/arch/arm/mach-omap1/gpio7xx.c
> @@ -284,8 +284,6 @@ static int __init omap7xx_gpio_init(void)
>  	for (i = 0; i < ARRAY_SIZE(omap7xx_gpio_dev); i++)
>  		platform_device_register(omap7xx_gpio_dev[i]);
>  
> -	gpio_bank_count = ARRAY_SIZE(omap7xx_gpio_dev);
> -
>  	return 0;
>  }
>  postcore_initcall(omap7xx_gpio_init);
> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 6cd26b4..487b49a 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -143,7 +143,6 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  		return PTR_ERR(od);
>  	}
>  
> -	gpio_bank_count++;
>  	return 0;
>  }
>  
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 12deb1c..0b76475 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -30,7 +30,10 @@
>  #include <mach/gpio.h>
>  #include <asm/mach/irq.h>
>  
> +static LIST_HEAD(omap_gpio_list);
> +
>  struct gpio_bank {
> +	struct list_head node;
>  	unsigned long pbase;
>  	void __iomem *base;
>  	u16 irq;
> @@ -57,6 +60,7 @@ struct gpio_bank {
>  	bool dbck_flag;
>  	int stride;
>  	u32 width;
> +	u16 id;
>  
>  	void (*set_dataout)(struct gpio_bank *bank, int gpio, int enable);
>  
> @@ -80,15 +84,6 @@ struct omap3_gpio_regs {
>  static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
>  #endif
>  
> -/*
> - * TODO: Cleanup gpio_bank usage as it is having information
> - * related to all instances of the device
> - */
> -static struct gpio_bank *gpio_bank;
> -
> -/* TODO: Analyze removing gpio_bank_count usage from driver code */
> -int gpio_bank_count;
> -
>  #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
>  #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
>  #define GPIO_MOD_CTRL_BIT	BIT(0)
> @@ -859,23 +854,29 @@ static struct platform_device omap_mpuio_device = {
>  	/* could list the /proc/iomem resources */
>  };
>  
> -static inline void mpuio_init(void)
> +static inline void mpuio_init(struct gpio_bank *bank)
>  {
> -	struct gpio_bank *bank = &gpio_bank[0];
> +	static int mpuio_init_done;

Why is this flag needed?   isn't the bank->method check enough?

> +	if (mpuio_init_done || (bank->method != METHOD_MPUIO))
> +		return;
> +
>  	platform_set_drvdata(&omap_mpuio_device, bank);
>  
>  	if (platform_driver_register(&omap_mpuio_driver) == 0)
>  		(void) platform_device_register(&omap_mpuio_device);
> +
> +	mpuio_init_done = 1;
>  }
>  
>  #else
> -static inline void mpuio_init(void) {}
> +static inline void mpuio_init(struct gpio_bank *bank) {}
>  #endif	/* 16xx */
>  
>  #else
>  
>  #define bank_is_mpuio(bank)	0
> -static inline void mpuio_init(void) {}
> +static inline void mpuio_init(struct gpio_bank *bank) {}
>  
>  #endif
>  
> @@ -997,18 +998,6 @@ static void __init omap_gpio_show_rev(struct gpio_bank *bank)
>   */
>  static struct lock_class_key gpio_lock_class;
>  
> -static inline int init_gpio_info(struct platform_device *pdev)
> -{
> -	/* TODO: Analyze removing gpio_bank_count usage from driver code */
> -	gpio_bank = kzalloc(gpio_bank_count * sizeof(struct gpio_bank),
> -				GFP_KERNEL);
> -	if (!gpio_bank) {
> -		dev_err(&pdev->dev, "Memory alloc failed for gpio_bank\n");
> -		return -ENOMEM;
> -	}
> -	return 0;
> -}
> -
>  /* TODO: Cleanup cpu_is_* checks */
>  static void omap_gpio_mod_init(struct gpio_bank *bank)
>  {
> @@ -1140,36 +1129,37 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
>  
>  static int __devinit omap_gpio_probe(struct platform_device *pdev)
>  {
> -	static int gpio_init_done;
>  	struct omap_gpio_platform_data *pdata;
>  	struct resource *res;
> -	int id;
>  	struct gpio_bank *bank;
> +	int ret = 0;
>  
> -	if (!pdev->dev.platform_data)
> -		return -EINVAL;
> -
> -	pdata = pdev->dev.platform_data;
> -
> -	if (!gpio_init_done) {
> -		int ret;
> -
> -		ret = init_gpio_info(pdev);
> -		if (ret)
> -			return ret;
> +	if (!pdev->dev.platform_data) {
> +		ret = -EINVAL;
> +		goto err_exit;
>  	}
>  
> -	id = pdev->id;
> -	bank = &gpio_bank[id];
> +	bank = kzalloc(sizeof(struct gpio_bank), GFP_KERNEL);
> +	if (!bank) {
> +		dev_err(&pdev->dev, "Memory alloc failed for gpio_bank\n");
> +		ret = -ENOMEM;
> +		goto err_exit;
> +	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (unlikely(!res)) {
> -		dev_err(&pdev->dev, "GPIO Bank %i Invalid IRQ resource\n", id);
> -		return -ENODEV;
> +		dev_err(&pdev->dev, "GPIO Bank %i Invalid IRQ resource\n",
> +				pdev->id);
> +		ret = -ENODEV;
> +		goto err_free;
>  	}
>  
>  	bank->irq = res->start;
> +	bank->id = pdev->id;
> +
> +	pdata = pdev->dev.platform_data;
>  	bank->virtual_irq_start = pdata->virtual_irq_start;
> +
>  	bank->method = pdata->bank_type;
>  	bank->dev = &pdev->dev;
>  	bank->dbck_flag = pdata->dbck_flag;
> @@ -1189,39 +1179,47 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>  	/* Static mapping, never released */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (unlikely(!res)) {
> -		dev_err(&pdev->dev, "GPIO Bank %i Invalid mem resource\n", id);
> -		return -ENODEV;
> +		dev_err(&pdev->dev, "GPIO Bank %i Invalid mem resource\n",
> +				pdev->id);
> +		ret = -ENODEV;
> +		goto err_free;
>  	}
>  
>  	bank->base = ioremap(res->start, resource_size(res));
>  	if (!bank->base) {
> -		dev_err(&pdev->dev, "Could not ioremap gpio bank%i\n", id);
> -		return -ENOMEM;
> +		dev_err(&pdev->dev, "Could not ioremap gpio bank%i\n",
> +				pdev->id);
> +		ret = -ENOMEM;
> +		goto err_free;
>  	}
>  
>  	pm_runtime_enable(bank->dev);
>  	pm_runtime_get_sync(bank->dev);
>  
> +	mpuio_init(bank);

How about moving this call into _mod_init(), and call it only when
->method = MPUIO.

>  	omap_gpio_mod_init(bank);
>  	omap_gpio_chip_init(bank);
>  	omap_gpio_show_rev(bank);

[...]

Kevin

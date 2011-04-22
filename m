From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 04/18] OMAP: GPIO: Move gpio_valid() to SoC specific files
Date: Fri, 22 Apr 2011 08:15:48 -0700
Message-ID: <87mxjiz597.fsf@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
	<1303470512-19671-5-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:50421 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755905Ab1DVPPv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 11:15:51 -0400
Received: by mail-px0-f180.google.com with SMTP id 25so468636pxj.25
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 08:15:50 -0700 (PDT)
In-Reply-To: <1303470512-19671-5-git-send-email-charu@ti.com> (Charulatha V.'s
	message of "Fri, 22 Apr 2011 16:38:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com

Charulatha V <charu@ti.com> writes:

> gpio_valid() implementation is different for different SoCs.
> Hence handle them in SoC specific gpio files.
>
> Signed-off-by: Charulatha V <charu@ti.com>

This one is only moving the mess into SoC-specific code.

Looking closer at the gpio_valid() (and check_gpio()) calls, they are
actually pointless.  These functions are only called in a few places,
and where they are called, the GPIO has already been converted from an
IRQ or masked, so these functions will never fail.

Kevin

> ---
>  arch/arm/mach-omap1/gpio15xx.c         |   26 ++++++++++++++++++++-
>  arch/arm/mach-omap1/gpio16xx.c         |   32 ++++++++++++++++++++++----
>  arch/arm/mach-omap1/gpio7xx.c          |   38 ++++++++++++++++++++++++++------
>  arch/arm/mach-omap2/gpio.c             |   14 +++++++++++-
>  arch/arm/plat-omap/gpio.c              |   27 +---------------------
>  arch/arm/plat-omap/include/plat/gpio.h |    1 +
>  6 files changed, 98 insertions(+), 40 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
> index eb2727a..9d7a3fa 100644
> --- a/arch/arm/mach-omap1/gpio15xx.c
> +++ b/arch/arm/mach-omap1/gpio15xx.c
> @@ -22,6 +22,10 @@
>  #define OMAP1510_GPIO_BASE		0xFFFCE000
>  
>  #define OMAP1510_GPIO_INDEX_MASK	0x0f
> +#define OMAP1510_GPIO_WIDTH		16
> +#define OMAP1510_GPIO_BANK_CNT		2
> +#define OMAP1510_NON_MPUIO_GPIO_VALID	((OMAP1510_GPIO_BANK_CNT - 1) *\
> +						OMAP1510_GPIO_WIDTH)
>  
>  /* gpio1 */
>  static struct __initdata resource omap15xx_mpu_gpio_resources[] = {
> @@ -39,7 +43,7 @@ static struct __initdata resource omap15xx_mpu_gpio_resources[] = {
>  static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
>  	.virtual_irq_start	= IH_MPUIO_BASE,
>  	.bank_type		= METHOD_MPUIO,
> -	.bank_width		= 16,
> +	.bank_width		= OMAP1510_GPIO_WIDTH,
>  	.bank_stride		= 1,
>  };
>  
> @@ -69,7 +73,7 @@ static struct __initdata resource omap15xx_gpio_resources[] = {
>  static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE,
>  	.bank_type		= METHOD_GPIO_1510,
> -	.bank_width		= 16,
> +	.bank_width		= OMAP1510_GPIO_WIDTH,
>  };
>  
>  static struct __initdata platform_device omap15xx_gpio = {
> @@ -87,8 +91,26 @@ static int get_gpio_index(int gpio)
>  	return gpio & OMAP1510_GPIO_INDEX_MASK;
>  }
>  
> +static int gpio_valid(int gpio)
> +{
> +	if (gpio < 0)
> +		return -EINVAL;
> +
> +	if (OMAP_GPIO_IS_MPUIO(gpio)) {
> +		if (gpio >= OMAP_MAX_GPIO_LINES + OMAP1510_GPIO_WIDTH)
> +			return -EINVAL;
> +		return 0;
> +	}
> +
> +	if (gpio < OMAP1510_NON_MPUIO_GPIO_VALID)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
>  static struct omap_gpio_func gpio_fn = {
>  	.get_index = get_gpio_index,
> +	.gpio_valid = gpio_valid,
>  };
>  
>  /*
> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
> index 9d8aabc..e6bb080 100644
> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@ -25,6 +25,10 @@
>  #define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
>  
>  #define OMAP1610_GPIO_INDEX_MASK	0x0f
> +#define OMAP1610_GPIO_WIDTH		16
> +#define OMAP1610_GPIO_BANK_CNT		5
> +#define OMAP1610_NON_MPUIO_GPIO_VALID	((OMAP1610_GPIO_BANK_CNT - 1) *\
> +						OMAP1610_GPIO_WIDTH)
>  
>  /* mpu gpio */
>  static struct __initdata resource omap16xx_mpu_gpio_resources[] = {
> @@ -42,7 +46,7 @@ static struct __initdata resource omap16xx_mpu_gpio_resources[] = {
>  static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
>  	.virtual_irq_start	= IH_MPUIO_BASE,
>  	.bank_type		= METHOD_MPUIO,
> -	.bank_width		= 16,
> +	.bank_width		= OMAP1610_GPIO_WIDTH,
>  	.bank_stride		= 1,
>  };
>  
> @@ -72,7 +76,7 @@ static struct __initdata resource omap16xx_gpio1_resources[] = {
>  static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE,
>  	.bank_type		= METHOD_GPIO_1610,
> -	.bank_width		= 16,
> +	.bank_width		= OMAP1610_GPIO_WIDTH,
>  };
>  
>  static struct __initdata platform_device omap16xx_gpio1 = {
> @@ -101,7 +105,7 @@ static struct __initdata resource omap16xx_gpio2_resources[] = {
>  static struct __initdata omap_gpio_platform_data omap16xx_gpio2_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE + 16,
>  	.bank_type		= METHOD_GPIO_1610,
> -	.bank_width		= 16,
> +	.bank_width		= OMAP1610_GPIO_WIDTH,
>  };
>  
>  static struct __initdata platform_device omap16xx_gpio2 = {
> @@ -130,7 +134,7 @@ static struct __initdata resource omap16xx_gpio3_resources[] = {
>  static struct __initdata omap_gpio_platform_data omap16xx_gpio3_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE + 32,
>  	.bank_type		= METHOD_GPIO_1610,
> -	.bank_width		= 16,
> +	.bank_width		= OMAP1610_GPIO_WIDTH,
>  };
>  
>  static struct __initdata platform_device omap16xx_gpio3 = {
> @@ -159,7 +163,7 @@ static struct __initdata resource omap16xx_gpio4_resources[] = {
>  static struct __initdata omap_gpio_platform_data omap16xx_gpio4_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE + 48,
>  	.bank_type		= METHOD_GPIO_1610,
> -	.bank_width		= 16,
> +	.bank_width		= OMAP1610_GPIO_WIDTH,
>  };
>  
>  static struct __initdata platform_device omap16xx_gpio4 = {
> @@ -185,8 +189,26 @@ static int get_gpio_index(int gpio)
>  	return gpio & OMAP1610_GPIO_INDEX_MASK;
>  }
>  
> +static int gpio_valid(int gpio)
> +{
> +	if (gpio < 0)
> +		return -EINVAL;
> +
> +	if (OMAP_GPIO_IS_MPUIO(gpio)) {
> +		if (gpio >= OMAP_MAX_GPIO_LINES + OMAP1610_GPIO_WIDTH)
> +			return -EINVAL;
> +		return 0;
> +	}
> +
> +	if (gpio < OMAP1610_NON_MPUIO_GPIO_VALID)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
>  static struct omap_gpio_func gpio_fn = {
>  	.get_index = get_gpio_index,
> +	.gpio_valid = gpio_valid,
>  };
>  
>  /*
> diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
> index 74456a9..bd6fc8e 100644
> --- a/arch/arm/mach-omap1/gpio7xx.c
> +++ b/arch/arm/mach-omap1/gpio7xx.c
> @@ -28,6 +28,12 @@
>  
>  #define OMAP7XX_GPIO_INDEX_MASK		0x1f
>  
> +#define OMAP7XX_GPIO_WIDTH		32
> +#define OMAP7XX_MPUIO_GPIO_PIN_CNT	16
> +#define OMAP7XX_GPIO_BANK_CNT		7
> +#define OMAP7XX_NON_MPUIO_GPIO_VALID	((OMAP7XX_GPIO_BANK_CNT - 1) *\
> +						OMAP7XX_GPIO_WIDTH)
> +
>  /* mpu gpio */
>  static struct __initdata resource omap7xx_mpu_gpio_resources[] = {
>  	{
> @@ -44,7 +50,7 @@ static struct __initdata resource omap7xx_mpu_gpio_resources[] = {
>  static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
>  	.virtual_irq_start	= IH_MPUIO_BASE,
>  	.bank_type		= METHOD_MPUIO,
> -	.bank_width		= 32,
> +	.bank_width		= OMAP7XX_GPIO_WIDTH,
>  	.bank_stride		= 2,
>  };
>  
> @@ -74,7 +80,7 @@ static struct __initdata resource omap7xx_gpio1_resources[] = {
>  static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE,
>  	.bank_type		= METHOD_GPIO_7XX,
> -	.bank_width		= 32,
> +	.bank_width		= OMAP7XX_GPIO_WIDTH,
>  };
>  
>  static struct __initdata platform_device omap7xx_gpio1 = {
> @@ -103,7 +109,7 @@ static struct __initdata resource omap7xx_gpio2_resources[] = {
>  static struct __initdata omap_gpio_platform_data omap7xx_gpio2_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE + 32,
>  	.bank_type		= METHOD_GPIO_7XX,
> -	.bank_width		= 32,
> +	.bank_width		= OMAP7XX_GPIO_WIDTH,
>  };
>  
>  static struct __initdata platform_device omap7xx_gpio2 = {
> @@ -132,7 +138,7 @@ static struct __initdata resource omap7xx_gpio3_resources[] = {
>  static struct __initdata omap_gpio_platform_data omap7xx_gpio3_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE + 64,
>  	.bank_type		= METHOD_GPIO_7XX,
> -	.bank_width		= 32,
> +	.bank_width		= OMAP7XX_GPIO_WIDTH,
>  };
>  
>  static struct __initdata platform_device omap7xx_gpio3 = {
> @@ -161,7 +167,7 @@ static struct __initdata resource omap7xx_gpio4_resources[] = {
>  static struct __initdata omap_gpio_platform_data omap7xx_gpio4_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE + 96,
>  	.bank_type		= METHOD_GPIO_7XX,
> -	.bank_width		= 32,
> +	.bank_width		= OMAP7XX_GPIO_WIDTH,
>  };
>  
>  static struct __initdata platform_device omap7xx_gpio4 = {
> @@ -190,7 +196,7 @@ static struct __initdata resource omap7xx_gpio5_resources[] = {
>  static struct __initdata omap_gpio_platform_data omap7xx_gpio5_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE + 128,
>  	.bank_type		= METHOD_GPIO_7XX,
> -	.bank_width		= 32,
> +	.bank_width		= OMAP7XX_GPIO_WIDTH,
>  };
>  
>  static struct __initdata platform_device omap7xx_gpio5 = {
> @@ -219,7 +225,7 @@ static struct __initdata resource omap7xx_gpio6_resources[] = {
>  static struct __initdata omap_gpio_platform_data omap7xx_gpio6_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE + 160,
>  	.bank_type		= METHOD_GPIO_7XX,
> -	.bank_width		= 32,
> +	.bank_width		= OMAP7XX_GPIO_WIDTH,
>  };
>  
>  static struct __initdata platform_device omap7xx_gpio6 = {
> @@ -247,8 +253,26 @@ static int get_gpio_index(int gpio)
>  	return gpio & OMAP7XX_GPIO_INDEX_MASK;
>  }
>  
> +static int gpio_valid(int gpio)
> +{
> +	if (gpio < 0)
> +		return -EINVAL;
> +
> +	if (OMAP_GPIO_IS_MPUIO(gpio)) {
> +		if (gpio >= OMAP_MAX_GPIO_LINES + OMAP7XX_MPUIO_GPIO_PIN_CNT)
> +			return -EINVAL;
> +		return 0;
> +	}
> +
> +	if (gpio < OMAP7XX_NON_MPUIO_GPIO_VALID)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
>  static struct omap_gpio_func gpio_fn = {
>  	.get_index = get_gpio_index,
> +	.gpio_valid = gpio_valid,
>  };
>  
>  /*
> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 498ab92..08ee5f1 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -26,6 +26,8 @@
>  
>  #define OMAP2_GPIO_INDEX_MASK		0x1f
>  
> +int bank_width;
> +
>  static struct omap_device_pm_latency omap_gpio_latency[] = {
>  	[0] = {
>  		.deactivate_func = omap_device_idle_hwmods,
> @@ -39,8 +41,17 @@ static int get_gpio_index(int gpio)
>  	return gpio & OMAP2_GPIO_INDEX_MASK;
>  }
>  
> +static int gpio_valid(int gpio)
> +{
> +	if ((gpio >= 0) && (gpio < (gpio_bank_count * bank_width)))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
>  static struct omap_gpio_func gpio_fn = {
>  	.get_index = get_gpio_index,
> +	.gpio_valid = gpio_valid,
>  };
>  
>  static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
> @@ -68,7 +79,8 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  	}
>  
>  	dev_attr = (struct omap_gpio_dev_attr *)oh->dev_attr;
> -	pdata->bank_width = dev_attr->bank_width;
> +	bank_width = dev_attr->bank_width;
> +	pdata->bank_width = bank_width;
>  	pdata->dbck_flag = dev_attr->dbck_flag;
>  	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * (id - 1);
>  	pdata->gpio_fn = &gpio_fn;
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index e70bb6e..0f1dbbf 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -190,33 +190,9 @@ static int bank_width;
>  /* TODO: Analyze removing gpio_bank_count usage from driver code */
>  int gpio_bank_count;
>  
> -static inline int gpio_valid(int gpio)
> -{
> -	if (gpio < 0)
> -		return -1;
> -	if (cpu_class_is_omap1() && OMAP_GPIO_IS_MPUIO(gpio)) {
> -		if (gpio >= OMAP_MAX_GPIO_LINES + 16)
> -			return -1;
> -		return 0;
> -	}
> -	if (cpu_is_omap15xx() && gpio < 16)
> -		return 0;
> -	if ((cpu_is_omap16xx()) && gpio < 64)
> -		return 0;
> -	if (cpu_is_omap7xx() && gpio < 192)
> -		return 0;
> -	if (cpu_is_omap2420() && gpio < 128)
> -		return 0;
> -	if (cpu_is_omap2430() && gpio < 160)
> -		return 0;
> -	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && gpio < 192)
> -		return 0;
> -	return -1;
> -}
> -
>  static int check_gpio(int gpio)
>  {
> -	if (unlikely(gpio_valid(gpio) < 0)) {
> +	if (unlikely(gpio_fn.gpio_valid(gpio) < 0)) {
>  		printk(KERN_ERR "omap-gpio: invalid GPIO %d\n", gpio);
>  		dump_stack();
>  		return -1;
> @@ -1666,6 +1642,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>  			mpuio_init();
>  
>  		gpio_fn.get_index = pdata->gpio_fn->get_index;
> +		gpio_fn.gpio_valid = pdata->gpio_fn->gpio_valid;
>  	}
>  
>  	id = pdev->id;
> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
> index 1cfb01b..00586ad 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -73,6 +73,7 @@ struct omap_gpio_dev_attr {
>  
>  struct omap_gpio_func {
>  	int (*get_index)(int gpio);
> +	int (*gpio_valid)(int gpio);
>  };
>  
>  struct omap_gpio_platform_data {

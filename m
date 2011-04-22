From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 11/18] OMAP: GPIO: Remove dependency on gpio_bank_count
Date: Fri, 22 Apr 2011 09:04:18 -0700
Message-ID: <87oc3yxofx.fsf@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
	<1303470512-19671-12-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46941 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756026Ab1DVQEY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 12:04:24 -0400
Received: by mail-pw0-f51.google.com with SMTP id 9so383643pwi.10
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 09:04:21 -0700 (PDT)
In-Reply-To: <1303470512-19671-12-git-send-email-charu@ti.com> (Charulatha
	V.'s message of "Fri, 22 Apr 2011 16:38:25 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com

Charulatha V <charu@ti.com> writes:

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
> ---
>  arch/arm/mach-omap1/gpio15xx.c         |    1 -
>  arch/arm/mach-omap1/gpio16xx.c         |    2 -
>  arch/arm/mach-omap1/gpio7xx.c          |    2 -
>  arch/arm/mach-omap2/gpio.c             |    1 +
>  arch/arm/plat-omap/gpio.c              |  165 ++++++++++++++++----------------
>  arch/arm/plat-omap/include/plat/gpio.h |    3 -
>  6 files changed, 83 insertions(+), 91 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
> index 7a7a123..3763db3 100644
> --- a/arch/arm/mach-omap1/gpio15xx.c
> +++ b/arch/arm/mach-omap1/gpio15xx.c
> @@ -189,7 +189,6 @@ static int __init omap15xx_gpio_init(void)
>  	omap15xx_mpu_gpio_config.gpio_fn = &gpio_fn;
>  	platform_device_register(&omap15xx_gpio);
>  
> -	gpio_bank_count = 2;
>  	return 0;
>  }
>  postcore_initcall(omap15xx_gpio_init);
> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
> index f05e0c7..6a99b01 100644
> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@ -316,8 +316,6 @@ static int __init omap16xx_gpio_init(void)
>  		platform_device_register(omap16xx_gpio_dev[i]);
>  	}
>  
> -	gpio_bank_count = ARRAY_SIZE(omap16xx_gpio_dev);
> -
>  	return 0;
>  }
>  postcore_initcall(omap16xx_gpio_init);
> diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
> index 1103efc..cd6bad7 100644
> --- a/arch/arm/mach-omap1/gpio7xx.c
> +++ b/arch/arm/mach-omap1/gpio7xx.c
> @@ -355,8 +355,6 @@ static int __init omap7xx_gpio_init(void)
>  		platform_device_register(omap7xx_gpio_dev[i]);
>  	}
>  
> -	gpio_bank_count = ARRAY_SIZE(omap7xx_gpio_dev);
> -
>  	return 0;
>  }
>  postcore_initcall(omap7xx_gpio_init);
> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 25fe8a4..a46f4a5 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -28,6 +28,7 @@
>  #define OMAP2_GPIO_INDEX_MASK		0x1f
>  #define OMAP2_GPIO_IRQENA_MASK		0xffffffff
>  
> +int gpio_bank_count;

Why is this needed here?

>  int bank_width;
>  static u16 *reg_map;
>  static u16 omap2_gpio_reg_offsets[] = {

[...]

>  void omap2_gpio_prepare_for_idle(int off_mode)
>  {
> -	int i, c = 0;
> -	int min = 0;
> -
> -	if (cpu_is_omap34xx())
> -		min = 1;
> +	int c = 0;
> +	struct gpio_bank *bank;
>  
> -	for (i = min; i < gpio_bank_count; i++) {
> -		struct gpio_bank *bank = &gpio_bank[i];
> +	list_for_each_entry(bank, &omap_gpio_list, node) {


Note that on 34xx, this isn't an equivalent functional change, since
the for loop starts a 1 and the list traversal covers all banks.

I think your powerdomain 'can lose context' patch is needed before this
one.

Kevin


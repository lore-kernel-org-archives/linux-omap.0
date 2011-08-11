From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 12/13] ARM: gpio: consolidate gpio_to_irq
Date: Thu, 11 Aug 2011 20:58:26 +0900
Message-ID: <000101cc581d$fd45d5d0$f7d18170$%kim@samsung.com>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
 <E1QqhMM-0003aj-C7@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <E1QqhMM-0003aj-C7@rmk-PC.arm.linux.org.uk>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: 'Grant Likely' <grant.likely@secretlab.ca>, 'Nicolas Pitre' <nico@fluxnic.net>'Grant Likely' <grant.likely@secretlab.ca>'Nicolas Pitre' <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux wrote:
> 
> Many of the gpio_to_irq implementations use the gpiolib version of this
> function.  Provide the standard gpiolib gpio_to_irq() for everyone, but
> allow platforms to override it if they wish.  Add the neccessary
> overrides for those platforms which do not use the standard definition.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

on following Samsung stuff :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  arch/arm/include/asm/gpio.h                 |    9 +++++++++

>  arch/arm/mach-exynos4/include/mach/gpio.h   |    2 --

>  arch/arm/mach-s3c2410/include/mach/gpio.h   |    1 -
>  arch/arm/mach-s3c64xx/include/mach/gpio.h   |    1 -
>  arch/arm/mach-s5p64x0/include/mach/gpio.h   |    1 -
>  arch/arm/mach-s5pc100/include/mach/gpio.h   |    1 -
>  arch/arm/mach-s5pv210/include/mach/gpio.h   |    1 -
> 
> diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> index 15e8970..5032224 100644
> --- a/arch/arm/include/asm/gpio.h
> +++ b/arch/arm/include/asm/gpio.h
> @@ -14,4 +14,13 @@
>  #define gpio_cansleep   __gpio_cansleep
>  #endif
> 
> +/*
> + * Provide a default gpio_to_irq() which should satisfy every case.
> + * However, some platforms want to do this differently, so allow them
> + * to override it.
> + */
> +#ifndef gpio_to_irq
> +#define gpio_to_irq	__gpio_to_irq
> +#endif
> +
>  #endif /* _ARCH_ARM_GPIO_H */

> diff --git a/arch/arm/mach-exynos4/include/mach/gpio.h b/arch/arm/mach-
> exynos4/include/mach/gpio.h
> index b2e3595..b91e8b2 100644
> --- a/arch/arm/mach-exynos4/include/mach/gpio.h
> +++ b/arch/arm/mach-exynos4/include/mach/gpio.h
> @@ -13,8 +13,6 @@
>  #ifndef __ASM_ARCH_GPIO_H
>  #define __ASM_ARCH_GPIO_H __FILE__
> 
> -#define gpio_to_irq	__gpio_to_irq
> -
>  /* Practically, GPIO banks up to GPZ are the configurable gpio banks */
> 
>  /* GPIO bank sizes */

> diff --git a/arch/arm/mach-s3c2410/include/mach/gpio.h b/arch/arm/mach-
> s3c2410/include/mach/gpio.h
> index 998ef4c..d502d17 100644
> --- a/arch/arm/mach-s3c2410/include/mach/gpio.h
> +++ b/arch/arm/mach-s3c2410/include/mach/gpio.h
> @@ -12,7 +12,6 @@
>  */
> 
>  #define __ARM_GPIOLIB_TRIVIAL
> -#define gpio_to_irq	__gpio_to_irq
> 
>  /* some boards require extra gpio capacity to support external
>   * devices that need GPIO.
> diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio.h b/arch/arm/mach-
> s3c64xx/include/mach/gpio.h
> index 6958b3f..3a8857c 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/gpio.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/gpio.h
> @@ -13,7 +13,6 @@
>  */
> 
>  #define __ARM_GPIOLIB_TRIVIAL
> -#define gpio_to_irq	__gpio_to_irq
> 
>  /* GPIO bank sizes */
>  #define S3C64XX_GPIO_A_NR	(8)
> diff --git a/arch/arm/mach-s5p64x0/include/mach/gpio.h b/arch/arm/mach-
> s5p64x0/include/mach/gpio.h
> index a25160b..c3a6aa0 100644
> --- a/arch/arm/mach-s5p64x0/include/mach/gpio.h
> +++ b/arch/arm/mach-s5p64x0/include/mach/gpio.h
> @@ -14,7 +14,6 @@
>  #define __ASM_ARCH_GPIO_H __FILE__
> 
>  #define __ARM_GPIOLIB_TRIVIAL
> -#define gpio_to_irq	__gpio_to_irq
> 
>  /* GPIO bank sizes */
> 
> diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-
> s5pc100/include/mach/gpio.h
> index f515bfb..0e75641 100644
> --- a/arch/arm/mach-s5pc100/include/mach/gpio.h
> +++ b/arch/arm/mach-s5pc100/include/mach/gpio.h
> @@ -16,7 +16,6 @@
>  #define __ASM_ARCH_GPIO_H __FILE__
> 
>  #define __ARM_GPIOLIB_TRIVIAL
> -#define gpio_to_irq	__gpio_to_irq
> 
>  /* GPIO bank sizes */
>  #define S5PC100_GPIO_A0_NR	(8)
> diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-
> s5pv210/include/mach/gpio.h
> index 27f2139..d348ee2 100644
> --- a/arch/arm/mach-s5pv210/include/mach/gpio.h
> +++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
> @@ -14,7 +14,6 @@
>  #define __ASM_ARCH_GPIO_H __FILE__
> 
>  #define __ARM_GPIOLIB_TRIVIAL
> -#define gpio_to_irq	__gpio_to_irq
> 
>  /* Practically, GPIO banks up to MP03 are the configurable gpio banks */
>

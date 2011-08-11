From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib
 implementations
Date: Thu, 11 Aug 2011 20:47:18 +0900
Message-ID: <017101cc581c$6e277530$4a765f90$%kim@samsung.com>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
 <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-reply-to: <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Content-language: ko
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: 'Grant Likely' <grant.likely@secretlab.ca>, 'Nicolas Pitre' <nico@fluxnic.net>'Grant Likely' <grant.likely@secretlab.ca>'Nicolas Pitre' <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux wrote:
> 
> Consolidate 24 trivial gpiolib implementions out of mach/gpio.h
> into asm/gpio.h.  This is basically the include of asm-generic/gpio.h
> and the definition of gpio_get_value, gpio_set_value, and gpio_cansleep
> as described in Documentation/gpio.txt
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>
on following Samsung stuff...

As a note, there were duplicated e-mail address Grant and Nicolas in Cc ;)
I just pushed 'reply all' :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  arch/arm/include/asm/gpio.h                 |   10 ++++++++++
...
>  arch/arm/mach-exynos4/include/mach/gpio.h   |    5 +----
...
>  arch/arm/mach-s3c2410/include/mach/gpio.h   |    5 +----
>  arch/arm/mach-s3c64xx/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-s5p64x0/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-s5pc100/include/mach/gpio.h   |    6 +-----
>  arch/arm/mach-s5pv210/include/mach/gpio.h   |    6 +-----
> 
> diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> index 166a7a3..15e8970 100644
> --- a/arch/arm/include/asm/gpio.h
> +++ b/arch/arm/include/asm/gpio.h
> @@ -4,4 +4,14 @@
>  /* not all ARM platforms necessarily support this API ... */
>  #include <mach/gpio.h>
> 
> +#ifdef __ARM_GPIOLIB_TRIVIAL
> +/* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h
*/
> +#include <asm-generic/gpio.h>
> +
> +/* The trivial gpiolib dispatchers */
> +#define gpio_get_value  __gpio_get_value
> +#define gpio_set_value  __gpio_set_value
> +#define gpio_cansleep   __gpio_cansleep
> +#endif
> +
>  #endif /* _ARCH_ARM_GPIO_H */
> diff --git a/arch/arm/mach-exynos4/include/mach/gpio.h b/arch/arm/mach-
> exynos4/include/mach/gpio.h
> index be9266b..b2e3595 100644
> --- a/arch/arm/mach-exynos4/include/mach/gpio.h
> +++ b/arch/arm/mach-exynos4/include/mach/gpio.h
> @@ -13,9 +13,6 @@
>  #ifndef __ASM_ARCH_GPIO_H
>  #define __ASM_ARCH_GPIO_H __FILE__
> 
> -#define gpio_get_value	__gpio_get_value
> -#define gpio_set_value	__gpio_set_value
> -#define gpio_cansleep	__gpio_cansleep
>  #define gpio_to_irq	__gpio_to_irq
> 
>  /* Practically, GPIO banks up to GPZ are the configurable gpio banks */
> @@ -151,6 +148,6 @@ enum s5p_gpio_number {
>  #define ARCH_NR_GPIOS
> 	(EXYNOS4_GPZ(EXYNOS4_GPIO_Z_NR) +	\
>  				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
> 
> -#include <asm-generic/gpio.h>
> +#define __ARM_GPIOLIB_TRIVIAL
> 
>  #endif /* __ASM_ARCH_GPIO_H */

> diff --git a/arch/arm/mach-s3c2410/include/mach/gpio.h b/arch/arm/mach-
> s3c2410/include/mach/gpio.h
> index f7f6b07..998ef4c 100644
> --- a/arch/arm/mach-s3c2410/include/mach/gpio.h
> +++ b/arch/arm/mach-s3c2410/include/mach/gpio.h
> @@ -11,9 +11,7 @@
>   * published by the Free Software Foundation.
>  */
> 
> -#define gpio_get_value	__gpio_get_value
> -#define gpio_set_value	__gpio_set_value
> -#define gpio_cansleep	__gpio_cansleep
> +#define __ARM_GPIOLIB_TRIVIAL
>  #define gpio_to_irq	__gpio_to_irq
> 
>  /* some boards require extra gpio capacity to support external
> @@ -28,7 +26,6 @@
>  #define ARCH_NR_GPIOS	(256 + CONFIG_S3C24XX_GPIO_EXTRA)
>  #endif
> 
> -#include <asm-generic/gpio.h>
>  #include <mach/gpio-nrs.h>
>  #include <mach/gpio-fns.h>
> 
> diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio.h b/arch/arm/mach-
> s3c64xx/include/mach/gpio.h
> index 0d46e99..6958b3f 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/gpio.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/gpio.h
> @@ -12,9 +12,7 @@
>   * published by the Free Software Foundation.
>  */
> 
> -#define gpio_get_value	__gpio_get_value
> -#define gpio_set_value	__gpio_set_value
> -#define gpio_cansleep	__gpio_cansleep
> +#define __ARM_GPIOLIB_TRIVIAL
>  #define gpio_to_irq	__gpio_to_irq
> 
>  /* GPIO bank sizes */
> @@ -96,5 +94,3 @@ enum s3c_gpio_number {
>  #define BOARD_NR_GPIOS 16
> 
>  #define ARCH_NR_GPIOS	(GPIO_BOARD_START + BOARD_NR_GPIOS)
> -
> -#include <asm-generic/gpio.h>
> diff --git a/arch/arm/mach-s5p64x0/include/mach/gpio.h b/arch/arm/mach-
> s5p64x0/include/mach/gpio.h
> index adb5f29..a25160b 100644
> --- a/arch/arm/mach-s5p64x0/include/mach/gpio.h
> +++ b/arch/arm/mach-s5p64x0/include/mach/gpio.h
> @@ -13,9 +13,7 @@
>  #ifndef __ASM_ARCH_GPIO_H
>  #define __ASM_ARCH_GPIO_H __FILE__
> 
> -#define gpio_get_value	__gpio_get_value
> -#define gpio_set_value	__gpio_set_value
> -#define gpio_cansleep	__gpio_cansleep
> +#define __ARM_GPIOLIB_TRIVIAL
>  #define gpio_to_irq	__gpio_to_irq
> 
>  /* GPIO bank sizes */
> @@ -134,6 +132,4 @@ enum s5p6450_gpio_number {
> 
>  #define ARCH_NR_GPIOS		(S5P64X0_GPIO_END +
> CONFIG_SAMSUNG_GPIO_EXTRA)
> 
> -#include <asm-generic/gpio.h>
> -
>  #endif /* __ASM_ARCH_GPIO_H */
> diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-
> s5pc100/include/mach/gpio.h
> index 29a8a12..f515bfb 100644
> --- a/arch/arm/mach-s5pc100/include/mach/gpio.h
> +++ b/arch/arm/mach-s5pc100/include/mach/gpio.h
> @@ -15,9 +15,7 @@
>  #ifndef __ASM_ARCH_GPIO_H
>  #define __ASM_ARCH_GPIO_H __FILE__
> 
> -#define gpio_get_value	__gpio_get_value
> -#define gpio_set_value	__gpio_set_value
> -#define gpio_cansleep	__gpio_cansleep
> +#define __ARM_GPIOLIB_TRIVIAL
>  #define gpio_to_irq	__gpio_to_irq
> 
>  /* GPIO bank sizes */
> @@ -146,6 +144,4 @@ enum s5p_gpio_number {
>  /* define the number of gpios we need to the one after the MP04() range
*/
>  #define ARCH_NR_GPIOS		(S5PC100_GPIO_END + 1)
> 
> -#include <asm-generic/gpio.h>
> -
>  #endif /* __ASM_ARCH_GPIO_H */
> diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-
> s5pv210/include/mach/gpio.h
> index a5a1e33..27f2139 100644
> --- a/arch/arm/mach-s5pv210/include/mach/gpio.h
> +++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
> @@ -13,9 +13,7 @@
>  #ifndef __ASM_ARCH_GPIO_H
>  #define __ASM_ARCH_GPIO_H __FILE__
> 
> -#define gpio_get_value	__gpio_get_value
> -#define gpio_set_value	__gpio_set_value
> -#define gpio_cansleep	__gpio_cansleep
> +#define __ARM_GPIOLIB_TRIVIAL
>  #define gpio_to_irq	__gpio_to_irq
> 
>  /* Practically, GPIO banks up to MP03 are the configurable gpio banks */
> @@ -142,6 +140,4 @@ enum s5p_gpio_number {
>  #define ARCH_NR_GPIOS
> 	(S5PV210_MP05(S5PV210_GPIO_MP05_NR) +	\
>  				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
> 
> -#include <asm-generic/gpio.h>
> -
>  #endif /* __ASM_ARCH_GPIO_H */

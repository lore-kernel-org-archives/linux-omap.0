From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 13/13] ARM: gpio: make trivial GPIOLIB implementation the
	default
Date: Thu, 11 Aug 2011 21:02:45 +0900
Message-ID: <000501cc581e$95ecf7a0$c1c6e6e0$%kim@samsung.com>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
	<E1QqhMg-0003an-GW@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <E1QqhMg-0003an-GW@rmk-PC.arm.linux.org.uk>
Content-language: ko
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: 'Grant Likely' <grant.likely@secretlab.ca>, 'Nicolas Pitre' <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux wrote:
> 
> Rather than marking the mach/gpio.h header files which want to use the
> trivial GPIOLIB implementation, mark those which do not want to use it
> instead.  This means that by default, you get the trivial implementation
> and only have to do something extra if you need to.  This should
> encourage the use of the trivial default implementation.
> 
> As an additional bonus, several gpio.h header files become empty.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Looks good to me :)

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

on following Samsung stuff...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  arch/arm/include/asm/gpio.h                 |    2 +-

>  arch/arm/mach-exynos4/include/mach/gpio.h   |    2 --

>  arch/arm/mach-s3c2410/include/mach/gpio.h   |    2 --
>  arch/arm/mach-s3c64xx/include/mach/gpio.h   |    2 --
>  arch/arm/mach-s5p64x0/include/mach/gpio.h   |    2 --
>  arch/arm/mach-s5pc100/include/mach/gpio.h   |    2 --
>  arch/arm/mach-s5pv210/include/mach/gpio.h   |    2 --
> 
> diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> index 5032224..11ad0bf 100644
> --- a/arch/arm/include/asm/gpio.h
> +++ b/arch/arm/include/asm/gpio.h
> @@ -4,7 +4,7 @@
>  /* not all ARM platforms necessarily support this API ... */
>  #include <mach/gpio.h>
> 
> -#ifdef __ARM_GPIOLIB_TRIVIAL
> +#ifndef __ARM_GPIOLIB_COMPLEX
>  /* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h
*/
>  #include <asm-generic/gpio.h>
> 

> diff --git a/arch/arm/mach-exynos4/include/mach/gpio.h b/arch/arm/mach-
> exynos4/include/mach/gpio.h
> index b91e8b2..80523ca 100644
> --- a/arch/arm/mach-exynos4/include/mach/gpio.h
> +++ b/arch/arm/mach-exynos4/include/mach/gpio.h
> @@ -146,6 +146,4 @@ enum s5p_gpio_number {
>  #define ARCH_NR_GPIOS
> 	(EXYNOS4_GPZ(EXYNOS4_GPIO_Z_NR) +	\
>  				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
> 
> -#define __ARM_GPIOLIB_TRIVIAL
> -
>  #endif /* __ASM_ARCH_GPIO_H */

> diff --git a/arch/arm/mach-s3c2410/include/mach/gpio.h b/arch/arm/mach-
> s3c2410/include/mach/gpio.h
> index d502d17..6fac70f 100644
> --- a/arch/arm/mach-s3c2410/include/mach/gpio.h
> +++ b/arch/arm/mach-s3c2410/include/mach/gpio.h
> @@ -11,8 +11,6 @@
>   * published by the Free Software Foundation.
>  */
> 
> -#define __ARM_GPIOLIB_TRIVIAL
> -
>  /* some boards require extra gpio capacity to support external
>   * devices that need GPIO.
>   */
> diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio.h b/arch/arm/mach-
> s3c64xx/include/mach/gpio.h
> index 3a8857c..6e34c2f 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/gpio.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/gpio.h
> @@ -12,8 +12,6 @@
>   * published by the Free Software Foundation.
>  */
> 
> -#define __ARM_GPIOLIB_TRIVIAL
> -
>  /* GPIO bank sizes */
>  #define S3C64XX_GPIO_A_NR	(8)
>  #define S3C64XX_GPIO_B_NR	(7)
> diff --git a/arch/arm/mach-s5p64x0/include/mach/gpio.h b/arch/arm/mach-
> s5p64x0/include/mach/gpio.h
> index c3a6aa0..06cd3c9 100644
> --- a/arch/arm/mach-s5p64x0/include/mach/gpio.h
> +++ b/arch/arm/mach-s5p64x0/include/mach/gpio.h
> @@ -13,8 +13,6 @@
>  #ifndef __ASM_ARCH_GPIO_H
>  #define __ASM_ARCH_GPIO_H __FILE__
> 
> -#define __ARM_GPIOLIB_TRIVIAL
> -
>  /* GPIO bank sizes */
> 
>  #define S5P6440_GPIO_A_NR	(6)
> diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-
> s5pc100/include/mach/gpio.h
> index 0e75641..5e1a924 100644
> --- a/arch/arm/mach-s5pc100/include/mach/gpio.h
> +++ b/arch/arm/mach-s5pc100/include/mach/gpio.h
> @@ -15,8 +15,6 @@
>  #ifndef __ASM_ARCH_GPIO_H
>  #define __ASM_ARCH_GPIO_H __FILE__
> 
> -#define __ARM_GPIOLIB_TRIVIAL
> -
>  /* GPIO bank sizes */
>  #define S5PC100_GPIO_A0_NR	(8)
>  #define S5PC100_GPIO_A1_NR	(5)
> diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-
> s5pv210/include/mach/gpio.h
> index d348ee2..6c8b903 100644
> --- a/arch/arm/mach-s5pv210/include/mach/gpio.h
> +++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
> @@ -13,8 +13,6 @@
>  #ifndef __ASM_ARCH_GPIO_H
>  #define __ASM_ARCH_GPIO_H __FILE__
> 
> -#define __ARM_GPIOLIB_TRIVIAL
> -
>  /* Practically, GPIO banks up to MP03 are the configurable gpio banks */
> 
>  /* GPIO bank sizes */

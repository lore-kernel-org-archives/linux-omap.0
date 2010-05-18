From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/11] OMAP: GPIO: Modify init() in preparation for
 platform device implementation
Date: Tue, 18 May 2010 16:41:00 -0700
Message-ID: <20100518234100.GU5818@atomide.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
 <1274194260-16401-2-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50347 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0ERXlF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 19:41:05 -0400
Content-Disposition: inline
In-Reply-To: <1274194260-16401-2-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, khilman@deeprootsystems.com

* Charulatha V <charu@ti.com> [100518 07:44]:
> This is in prepartion for implementing GPIO as a platform device.
> gpio bank's base addresses are moved from gpio.c to plat/gpio.h.
> 
> This patch also modifies omap_gpio_init() to make use of
> omap_gpio_chip_init() and omap_gpio_mod_init(). omap_gpio_mod_init() does
> the module init by clearing the status register and initializing the
> GPIO control register. omap_gpio_chip_init() initializes the chip request,
> free, get, set and other function pointers and sets the gpio irq handler.

<snip>

> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
> index de7c547..a06acb6 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -29,7 +29,8 @@
>  #include <linux/io.h>
>  #include <mach/irqs.h>
>  
> -#define OMAP1_MPUIO_BASE			0xfffb5000
> +#define OMAP1_MPUIO_BASE		0xfffb5000
> +#define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
>  
>  #if (defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850))
>  
> @@ -62,8 +63,73 @@
>  #define OMAP_MPUIO_LATCH		0x34
>  #endif
>  
> +/*
> + * OMAP1510 GPIO base addresses
> + */
> +#define OMAP1510_GPIO_BASE		0xfffce000
> +#define OMAP1510_IH_GPIO_BASE		64
> +
> +/*
> + * OMAP1610 GPIO base addresses
> + */
> +#define OMAP1610_GPIO1_BASE		0xfffbe400
> +#define OMAP1610_GPIO2_BASE		0xfffbec00
> +#define OMAP1610_GPIO3_BASE		0xfffbb400
> +#define OMAP1610_GPIO4_BASE		0xfffbbc00
> +
> +/*
> + * OMAP7XX GPIO base addresses
> + */
> +#define OMAP7XX_GPIO1_BASE		0xfffbc000
> +#define OMAP7XX_GPIO2_BASE		0xfffbc800
> +#define OMAP7XX_GPIO3_BASE		0xfffbd000
> +#define OMAP7XX_GPIO4_BASE		0xfffbd800
> +#define OMAP7XX_GPIO5_BASE		0xfffbe000
> +#define OMAP7XX_GPIO6_BASE		0xfffbe800

Please move these into the mach-omap1/gpio1xxx.c instead,
they should not be needed anywhere else. We don't want
to have the GPIO registers available in the common headers
as otherwise we'll get tons of drivers that suddenly
start tinkering with these registers directly..

> +/*
> + * omap24xx GPIO base addresses
> + */
> +#define OMAP242X_GPIO1_BASE		0x48018000
> +#define OMAP242X_GPIO2_BASE		0x4801a000
> +#define OMAP242X_GPIO3_BASE		0x4801c000
> +#define OMAP242X_GPIO4_BASE		0x4801e000
> +
> +#define OMAP243X_GPIO1_BASE		0x4900C000
> +#define OMAP243X_GPIO2_BASE		0x4900E000
> +#define OMAP243X_GPIO3_BASE		0x49010000
> +#define OMAP243X_GPIO4_BASE		0x49012000
> +#define OMAP243X_GPIO5_BASE		0x480B6000

These should go into mach-omap2/gpioxxxx.c. The same
for the others.

Regards,

Tony

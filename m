From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH] OMAP: GPIO: Fix OMAP4 GPIO reg access issues
Date: Tue, 6 Apr 2010 13:51:46 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4C3370A@dbde02.ent.ti.com>
References: <1269268704-31347-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57133 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab0DFIVu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 04:21:50 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o368Ll0d019980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 6 Apr 2010 03:21:49 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o368LkGU018829
	for <linux-omap@vger.kernel.org>; Tue, 6 Apr 2010 13:51:47 +0530 (IST)
In-Reply-To: <1269268704-31347-1-git-send-email-charu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,

If there are no review comments, can you please push this patch?

-V Charulatha

> -----Original Message-----
> From: Varadarajan, Charulatha
> Sent: Monday, March 22, 2010 8:08 PM
> To: linux-omap@vger.kernel.org
> Cc: Varadarajan, Charulatha
> Subject: [PATCH] OMAP: GPIO: Fix OMAP4 GPIO reg access issues
> 
> Access to some of the OMAP4 GPIO registers are not properly handled.
> This patch fixes it.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/plat-omap/gpio.c |   61 +++++++++++++++++++++++++++++++++++---------
>  1 files changed, 55 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 76a347b..3a9891c 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -137,7 +137,11 @@
>  #define OMAP4_GPIO_IRQSTATUSCLR1	0x0040
>  #define OMAP4_GPIO_IRQWAKEN0		0x0044
>  #define OMAP4_GPIO_IRQWAKEN1		0x0048
> -#define OMAP4_GPIO_SYSSTATUS		0x0104
> +#define OMAP4_GPIO_SYSSTATUS		0x0114
> +#define OMAP4_GPIO_IRQENABLE1		0x011c
> +#define OMAP4_GPIO_WAKE_EN		0x0120
> +#define OMAP4_GPIO_IRQSTATUS2		0x0128
> +#define OMAP4_GPIO_IRQENABLE2		0x012c
>  #define OMAP4_GPIO_CTRL			0x0130
>  #define OMAP4_GPIO_OE			0x0134
>  #define OMAP4_GPIO_DATAIN		0x0138
> @@ -148,6 +152,10 @@
>  #define OMAP4_GPIO_FALLINGDETECT	0x014c
>  #define OMAP4_GPIO_DEBOUNCENABLE	0x0150
>  #define OMAP4_GPIO_DEBOUNCINGTIME	0x0154
> +#define OMAP4_GPIO_CLEARIRQENABLE1	0x0160
> +#define OMAP4_GPIO_SETIRQENABLE1	0x0164
> +#define OMAP4_GPIO_CLEARWKUENA		0x0180
> +#define OMAP4_GPIO_SETWKUENA		0x0184
>  #define OMAP4_GPIO_CLEARDATAOUT		0x0190
>  #define OMAP4_GPIO_SETDATAOUT		0x0194
>  /*
> @@ -591,12 +599,16 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int
> gpio)
>  		reg += OMAP7XX_GPIO_DATA_OUTPUT;
>  		break;
>  #endif
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>  	case METHOD_GPIO_24XX:
> -	case METHOD_GPIO_44XX:
>  		reg += OMAP24XX_GPIO_DATAOUT;
>  		break;
>  #endif
> +#ifdef CONFIG_ARCH_OMAP4
> +	case METHOD_GPIO_44XX:
> +		reg += OMAP4_GPIO_DATAOUT;
> +		break;
> +#endif
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1200,11 +1215,17 @@ static int omap_gpio_request(struct gpio_chip *chip,
> unsigned offset)
>  #endif
>  	if (!cpu_class_is_omap1()) {
>  		if (!bank->mod_usage) {
> +			void __iomem *reg = bank->base;
>  			u32 ctrl;
> -			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
> -			ctrl &= 0xFFFFFFFE;
> +
> +			if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +				reg += OMAP24XX_GPIO_CTRL;
> +			else if (cpu_is_omap44xx())
> +				reg += OMAP4_GPIO_CTRL;
> +			ctrl = __raw_readl(reg);
>  			/* Module is enabled, clocks are not gated */
> -			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
> +			ctrl &= 0xFFFFFFFE;
> +			__raw_writel(ctrl, reg);
>  		}
>  		bank->mod_usage |= 1 << offset;
>  	}
> @@ -1226,22 +1247,34 @@ static void omap_gpio_free(struct gpio_chip *chip,
> unsigned offset)
>  		__raw_writel(1 << offset, reg);
>  	}
>  #endif
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -	if ((bank->method == METHOD_GPIO_24XX) ||
> -			(bank->method == METHOD_GPIO_44XX)) {
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +	if (bank->method == METHOD_GPIO_24XX) {
>  		/* Disable wake-up during idle for dynamic tick */
>  		void __iomem *reg = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
>  		__raw_writel(1 << offset, reg);
>  	}
>  #endif
> +#ifdef CONFIG_ARCH_OMAP4
> +	if (bank->method == METHOD_GPIO_44XX) {
> +		/* Disable wake-up during idle for dynamic tick */
> +		void __iomem *reg = bank->base + OMAP4_GPIO_IRQWAKEN0;
> +		__raw_writel(1 << offset, reg);
> +	}
> +#endif
>  	if (!cpu_class_is_omap1()) {
>  		bank->mod_usage &= ~(1 << offset);
>  		if (!bank->mod_usage) {
> +			void __iomem *reg = bank->base;
>  			u32 ctrl;
> -			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
> +
> +			if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +				reg += OMAP24XX_GPIO_CTRL;
> +			else if (cpu_is_omap44xx())
> +				reg += OMAP4_GPIO_CTRL;
> +			ctrl = __raw_readl(reg);
>  			/* Module is disabled, clocks are gated */
>  			ctrl |= 1;
> -			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
> +			__raw_writel(ctrl, reg);
>  		}
>  	}
>  	_reset_gpio(bank, bank->chip.base + offset);
> @@ -1570,9 +1603,14 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
>  		reg += OMAP7XX_GPIO_DIR_CONTROL;
>  		break;
>  	case METHOD_GPIO_24XX:
> -	case METHOD_GPIO_44XX:
>  		reg += OMAP24XX_GPIO_OE;
>  		break;
> +	case METHOD_GPIO_44XX:
> +		reg += OMAP4_GPIO_OE;
> +		break;
> +	default:
> +		WARN_ON(1);
> +		return -EINVAL;
>  	}
>  	return __raw_readl(reg) & mask;
>  }
> --
> 1.6.3.3


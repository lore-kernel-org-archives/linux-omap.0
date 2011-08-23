From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 12/22] gpio/omap: cleanup set_gpio_triggering function
Date: Tue, 23 Aug 2011 18:51:27 +0530
Message-ID: <4E53A957.3010004@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-13-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:34221 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753316Ab1HWNVg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 09:21:36 -0400
Received: by mail-gy0-f173.google.com with SMTP id 12so84699gyd.4
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 06:21:34 -0700 (PDT)
In-Reply-To: <1312455893-14922-13-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> Getting rid of ifdefs within the function by adding register offset intctrl
> and associating OMAPXXXX_GPIO_INT_CONTROL in respective SoC specific files.
> Also, use wkup_status register consistently instead of referring to wakeup
> clear and wakeup set register offsets.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
Good. Some comments.

>   arch/arm/mach-omap1/gpio15xx.c         |    2 +
>   arch/arm/mach-omap1/gpio16xx.c         |    3 +
>   arch/arm/mach-omap1/gpio7xx.c          |    2 +
>   arch/arm/plat-omap/include/plat/gpio.h |    3 +
>   drivers/gpio/gpio-omap.c               |  159 ++++++++-----------------------
>   5 files changed, 51 insertions(+), 118 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
> index f8c15ea..2adfece 100644
> --- a/arch/arm/mach-omap1/gpio15xx.c
> +++ b/arch/arm/mach-omap1/gpio15xx.c
> @@ -42,6 +42,7 @@ static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
>   	.irqstatus	= OMAP_MPUIO_GPIO_INT,
>   	.irqenable	= OMAP_MPUIO_GPIO_MASKIT,
>   	.irqenable_inv	= true,
> +	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE,
>   };
>
>   static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
> @@ -83,6 +84,7 @@ static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
>   	.irqstatus	= OMAP1510_GPIO_INT_STATUS,
>   	.irqenable	= OMAP1510_GPIO_INT_MASK,
>   	.irqenable_inv	= true,
> +	.irqctrl	= OMAP1510_GPIO_INT_CONTROL,
>   };
>
>   static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
> index ed9f285..f619805 100644
> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@ -45,6 +45,7 @@ static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
>   	.irqstatus	= OMAP_MPUIO_GPIO_INT,
>   	.irqenable	= OMAP_MPUIO_GPIO_MASKIT,
>   	.irqenable_inv	= true,
> +	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE,
>   };
>
>   static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
> @@ -90,6 +91,8 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
>   	.set_irqenable	= OMAP1610_GPIO_SET_IRQENABLE1,
>   	.clr_irqenable	= OMAP1610_GPIO_CLEAR_IRQENABLE1,
>   	.wkup_status	= OMAP1610_GPIO_WAKEUPENABLE,
> +	.edgectrl1	= OMAP1610_GPIO_EDGE_CTRL1,
> +	.edgectrl2	= OMAP1610_GPIO_EDGE_CTRL2,
>   };
>
>   static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
> diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
> index 923eaa1..cb083c5 100644
> --- a/arch/arm/mach-omap1/gpio7xx.c
> +++ b/arch/arm/mach-omap1/gpio7xx.c
> @@ -47,6 +47,7 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
>   	.irqstatus	= OMAP_MPUIO_GPIO_INT / 2,
>   	.irqenable	= OMAP_MPUIO_GPIO_MASKIT / 2,
>   	.irqenable_inv	= true,
> +	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE / 2,

Shift operator would have been better here.

[...]

> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index e7c9fe5..21cb0d4 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c

[..]

> +			trigger != 0);
> +
> +	/* This part needs to be executed always for OMAP34xx */
> +	if (cpu_is_omap34xx() || (bank->non_wakeup_gpios&  gpio_bit)) {
Why ? You might want handle this special case with some flag instead.

>   		/*
>   		 * Log the edge gpio and manually trigger the IRQ
>   		 * after resume if the input level changes
> @@ -261,7 +236,6 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>   		__raw_readl(bank->base + bank->regs->leveldetect0) |
>   		__raw_readl(bank->base + bank->regs->leveldetect1);
>   }
> -#endif
>
>   #ifdef CONFIG_ARCH_OMAP1
>   /*

[...]

> -#endif
> -	default:
> -		goto bad;
> +
> +		_gpio_rmw(base, bank->regs->wkup_status, 1<<  gpio, trigger);
> +
Avoid this extra line.

Rest of the changes looks good to me.

Regards
Santosh

From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 11/18] GPIO: OMAP: Clean set_gpio_triggering function
Date: Thu, 16 Jun 2011 10:40:39 -0700
Message-ID: <87mxhhn088.fsf@ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
	<1308111806-29152-2-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44278 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757906Ab1FPRkm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 13:40:42 -0400
Received: by mail-pv0-f182.google.com with SMTP id 11so1685992pvg.13
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 10:40:41 -0700 (PDT)
In-Reply-To: <1308111806-29152-2-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 15 Jun 2011 09:53:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Getting rid of ifdefs within the function by adding register offset intctrl
> and associating OMAPXXXX_GPIO_INT_CONTROL in respective SoC specific files.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

[...]

> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 0a8f637..3c96855 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -83,6 +83,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  		return -ENOMEM;
>  	}
>  
> +	pdata->regs->irqctrl = USHRT_MAX;
> +	pdata->regs->edgectrl1 = USHRT_MAX;
> +	pdata->regs->edgectrl2 = USHRT_MAX;

As with all the other undefined values, please use zero.  

The driver check is checking for non-zero values which would be true
with USHRT_MAX.  You don't happen to see this because of the OMAP1 #ifdef.

[...]

>  	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
>  		if (cpu_is_omap44xx()) {
> -			MOD_REG_BIT(OMAP4_GPIO_IRQWAKEN0, gpio_bit,
> +			MOD_REG_BIT(bank->regs->wkup_status, gpio_bit,
>  				trigger != 0);
>  		} else {
>  			/*
> @@ -233,10 +222,10 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>  			 */
>  			if (trigger & IRQ_TYPE_EDGE_BOTH)
>  				__raw_writel(1 << gpio, bank->base
> -					+ OMAP24XX_GPIO_SETWKUENA);
> +					+ bank->regs->wkup_set);
>  			else
>  				__raw_writel(1 << gpio, bank->base
> -					+ OMAP24XX_GPIO_CLEARWKUENA);
> +					+ bank->regs->wkup_clear);
>  		}

Probably should be done in an additional patch, but the cpu_is_44xx()
above could be removed too.  

The 44xx TRM recommends using the wkup_status only (not using set/clear
registers) and the same could be done for the other SoCs.

Kevin

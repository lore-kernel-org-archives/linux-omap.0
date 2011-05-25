From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 12/15] OMAP: GPIO: Fix: use wake set/clear regs
Date: Wed, 25 May 2011 16:14:06 -0700
Message-ID: <87zkmal6f5.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-13-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51356 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754231Ab1EYXOK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 19:14:10 -0400
Received: by mail-pv0-f170.google.com with SMTP id 21so64098pvh.29
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 16:14:09 -0700 (PDT)
In-Reply-To: <1306247094-25372-13-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:51 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> In set_24xx_gpio_triggering(), for OMAP4, GPIO wakeup request
> is set for all type of GPIO triggers whereas as per TRM the GPIO
> wakeup request can only be generated on edge transitions. Fix this.

OK.  Please make a dedicated patch for this part.

Subject: GPIO: OMAP: IRQ triggering: use wake set/clear regs

> In set_24xx_gpio_triggering(), OMAP4_GPIO_IRQWAKEN0 register
> is used for wakeup request and the GPIO set/clear wakeup registers
> are not used in OMAP4 but is handled without retaining it's old
> value. This would corrupt the contents of OMAP4_GPIO_IRQWAKEN0
> register by writing the value of the last requested GPIO pin in
> a given bank. This can be avoided by making use of GPIO set/clear
> wakeup registers.

And this should be a separate patch too, or probably folded into PATCH
09/15 with an updated changelog of course.

Kevin

> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/mach-omap2/gpio.c |    4 ++--
>  drivers/gpio/gpio_omap.c   |   32 ++++++++++----------------------
>  2 files changed, 12 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 5c888dd..fbedbbb 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -142,8 +142,8 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  		pdata->regs->risingdetect = OMAP4_GPIO_RISINGDETECT;
>  		pdata->regs->fallingdetect = OMAP4_GPIO_FALLINGDETECT;
>  		pdata->regs->wkupstatus = OMAP4_GPIO_IRQWAKEN0;
> -		pdata->regs->wkupclear = OMAP4_GPIO_IRQWAKEN0;
> -		pdata->regs->wkupset = OMAP4_GPIO_IRQWAKEN0;
> +		pdata->regs->wkupclear = OMAP4_GPIO_CLEARWKUENA;
> +		pdata->regs->wkupset = OMAP4_GPIO_SETWKUENA;
>  		break;
>  	default:
>  		WARN(1, "Invalid gpio bank_type\n");
> diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
> index 05c2857..762d73c 100644
> --- a/drivers/gpio/gpio_omap.c
> +++ b/drivers/gpio/gpio_omap.c
> @@ -229,30 +229,18 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>  		MOD_REG_BIT(OMAP24XX_GPIO_FALLINGDETECT, gpio_bit,
>  			trigger & IRQ_TYPE_EDGE_FALLING);
>  	}
> +
>  	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
> -		if (cpu_is_omap44xx()) {
> -			if (trigger != 0)
> -				__raw_writel(1 << gpio, bank->base+
> -						OMAP4_GPIO_IRQWAKEN0);
> -			else {
> -				val = __raw_readl(bank->base +
> -							OMAP4_GPIO_IRQWAKEN0);
> -				__raw_writel(val & (~(1 << gpio)), bank->base +
> -							 OMAP4_GPIO_IRQWAKEN0);
> -			}
> -		} else {
> -			/*
> -			 * GPIO wakeup request can only be generated on edge
> -			 * transitions
> -			 */
> -			if (trigger & IRQ_TYPE_EDGE_BOTH)
> -				__raw_writel(1 << gpio, bank->base
> -					+ OMAP24XX_GPIO_SETWKUENA);
> -			else
> -				__raw_writel(1 << gpio, bank->base
> -					+ OMAP24XX_GPIO_CLEARWKUENA);
> -		}
> +		/*
> +		 * GPIO wakeup request can only be generated on edge
> +		 * transitions
> +		 */
> +		if (trigger & IRQ_TYPE_EDGE_BOTH)
> +			__raw_writel(1 << gpio, bank->wake_set);
> +		else
> +			__raw_writel(1 << gpio, bank->wake_clear);
>  	}
> +
>  	/* This part needs to be executed always for OMAP34xx */
>  	if (cpu_is_omap34xx() || (bank->non_wakeup_gpios & gpio_bit)) {
>  		/*

From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 08/10] OMAP: GPIO: cleanup prepare-for and resume-after idle functions
Date: Thu, 19 May 2011 18:10:20 +0200
Message-ID: <87mxii7jtf.fsf@ti.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
	<1305546104-1511-9-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:49929 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751831Ab1ESQKY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 12:10:24 -0400
Received: by mail-ww0-f46.google.com with SMTP id 28so2310532wwb.27
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 09:10:23 -0700 (PDT)
In-Reply-To: <1305546104-1511-9-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Mon, 16 May 2011 17:11:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> By adding level and edge detection register offsets and then initializing them
> correctly according to OMAP versions during device registrations we can now remove
> lot of revision checks in these functions.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Charulatha V <charu@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Looks great... a couple very minor comments below...

> ---
>  arch/arm/mach-omap2/gpio.c             |    8 +++
>  arch/arm/plat-omap/gpio.c              |   91 ++++++++------------------------
>  arch/arm/plat-omap/include/plat/gpio.h |    4 ++
>  3 files changed, 35 insertions(+), 68 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 7e79999..0f8782f 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -111,6 +111,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  		pdata->regs->debounce = OMAP24XX_GPIO_DEBOUNCE_VAL;
>  		pdata->regs->debounce_en = OMAP24XX_GPIO_DEBOUNCE_EN;
>  		pdata->regs->ctrl = OMAP24XX_GPIO_CTRL;
> +		pdata->regs->leveldetect0 = OMAP24XX_GPIO_LEVELDETECT0;
> +		pdata->regs->leveldetect1 = OMAP24XX_GPIO_LEVELDETECT1;
> +		pdata->regs->risingdetect = OMAP24XX_GPIO_RISINGDETECT;
> +		pdata->regs->fallingdetect = OMAP24XX_GPIO_FALLINGDETECT;
>  		pdata->regs->wkupstatus = OMAP24XX_GPIO_WAKE_EN;
>  		pdata->regs->wkupclear = OMAP24XX_GPIO_CLEARWKUENA;
>  		pdata->regs->wkupset = OMAP24XX_GPIO_SETWKUENA;
> @@ -131,6 +135,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  		pdata->regs->debounce = OMAP4_GPIO_DEBOUNCINGTIME;
>  		pdata->regs->debounce_en = OMAP4_GPIO_DEBOUNCENABLE;
>  		pdata->regs->ctrl = OMAP4_GPIO_CTRL;
> +		pdata->regs->leveldetect0 = OMAP4_GPIO_LEVELDETECT0;
> +		pdata->regs->leveldetect1 = OMAP4_GPIO_LEVELDETECT1;
> +		pdata->regs->risingdetect = OMAP4_GPIO_RISINGDETECT;
> +		pdata->regs->fallingdetect = OMAP4_GPIO_FALLINGDETECT;
>  		pdata->regs->wkupstatus = OMAP4_GPIO_IRQWAKEN0;
>  		pdata->regs->wkupclear = OMAP4_GPIO_IRQWAKEN0;
>  		pdata->regs->wkupset = OMAP4_GPIO_IRQWAKEN0;
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 1a6789d..da72856 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -1291,6 +1291,7 @@ void omap2_gpio_prepare_for_idle(int off_mode)
>  	list_for_each_entry(bank, &omap_gpio_list, node) {
>  		u32 l1 = 0, l2 = 0;
>  		int j;
> +		struct omap_gpio_reg_offs *offset = bank->regs;

Please just use bank->regs directly below.

>  		if (!bank->loses_context)
>  			continue;
> @@ -1307,40 +1308,17 @@ void omap2_gpio_prepare_for_idle(int off_mode)
>  		if (!(bank->enabled_non_wakeup_gpios))
>  			continue;
>  
> -		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> -			bank->saved_datain = __raw_readl(bank->base +
> -					OMAP24XX_GPIO_DATAIN);
> -			l1 = __raw_readl(bank->base +
> -					OMAP24XX_GPIO_FALLINGDETECT);
> -			l2 = __raw_readl(bank->base +
> -					OMAP24XX_GPIO_RISINGDETECT);
> -		}
> -
> -		if (cpu_is_omap44xx()) {
> -			bank->saved_datain = __raw_readl(bank->base +
> -						OMAP4_GPIO_DATAIN);
> -			l1 = __raw_readl(bank->base +
> -						OMAP4_GPIO_FALLINGDETECT);
> -			l2 = __raw_readl(bank->base +
> -						OMAP4_GPIO_RISINGDETECT);
> -		}
> +		bank->saved_datain = __raw_readl(bank->base + offset->datain);
> +		l1 = __raw_readl(bank->base + offset->fallingdetect);
> +		l2 = __raw_readl(bank->base + offset->risingdetect);
>  
>  		bank->saved_fallingdetect = l1;
>  		bank->saved_risingdetect = l2;
>  		l1 &= ~bank->enabled_non_wakeup_gpios;
>  		l2 &= ~bank->enabled_non_wakeup_gpios;
>  
> -		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> -			__raw_writel(l1, bank->base +
> -					OMAP24XX_GPIO_FALLINGDETECT);
> -			__raw_writel(l2, bank->base +
> -					OMAP24XX_GPIO_RISINGDETECT);
> -		}
> -
> -		if (cpu_is_omap44xx()) {
> -			__raw_writel(l1, bank->base + OMAP4_GPIO_FALLINGDETECT);
> -			__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
> -		}
> +		__raw_writel(l1, bank->base + offset->fallingdetect);
> +		__raw_writel(l2, bank->base + offset->risingdetect);
>  
>  		c++;
>  	}
> @@ -1358,6 +1336,7 @@ void omap2_gpio_resume_after_idle(void)
>  	list_for_each_entry(bank, &omap_gpio_list, node) {
>  		u32 l = 0, gen, gen0, gen1;
>  		int j;
> +		struct omap_gpio_reg_offs *offset = bank->regs;

ditto

>  		if (!bank->loses_context)
>  			continue;
> @@ -1371,21 +1350,11 @@ void omap2_gpio_resume_after_idle(void)
>  		if (!(bank->enabled_non_wakeup_gpios))
>  			continue;
>  
> -		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> -			__raw_writel(bank->saved_fallingdetect,
> -				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
> -			__raw_writel(bank->saved_risingdetect,
> -				 bank->base + OMAP24XX_GPIO_RISINGDETECT);
> -			l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
> -		}
> -
> -		if (cpu_is_omap44xx()) {
> -			__raw_writel(bank->saved_fallingdetect,
> -				 bank->base + OMAP4_GPIO_FALLINGDETECT);
> -			__raw_writel(bank->saved_risingdetect,
> -				 bank->base + OMAP4_GPIO_RISINGDETECT);
> -			l = __raw_readl(bank->base + OMAP4_GPIO_DATAIN);
> -		}
> +		__raw_writel(bank->saved_fallingdetect,
> +				bank->base + offset->fallingdetect);
> +		__raw_writel(bank->saved_risingdetect,
> +				bank->base + offset->risingdetect);
> +		l = __raw_readl(bank->base + offset->datain);
>  
>  		/* Check if any of the non-wakeup interrupt GPIOs have changed
>  		 * state.  If so, generate an IRQ by software.  This is
> @@ -1413,38 +1382,24 @@ void omap2_gpio_resume_after_idle(void)
>  		if (gen) {
>  			u32 old0, old1;
>  
> +			old0 = __raw_readl(bank->base + offset->leveldetect0);
> +			old1 = __raw_readl(bank->base + offset->leveldetect1);
> +
> +			__raw_writel(old0, bank->base + offset->leveldetect0);
> +			__raw_writel(old1, bank->base + offset->leveldetect1);
>  			if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> -				old0 = __raw_readl(bank->base +
> -					OMAP24XX_GPIO_LEVELDETECT0);
> -				old1 = __raw_readl(bank->base +
> -					OMAP24XX_GPIO_LEVELDETECT1);
> -				__raw_writel(old0 | gen, bank->base +
> -					OMAP24XX_GPIO_LEVELDETECT0);
> -				__raw_writel(old1 | gen, bank->base +
> -					OMAP24XX_GPIO_LEVELDETECT1);
> -				__raw_writel(old0, bank->base +
> -					OMAP24XX_GPIO_LEVELDETECT0);
> -				__raw_writel(old1, bank->base +
> -					OMAP24XX_GPIO_LEVELDETECT1);
> +				old0 |= gen;
> +				old1 |= gen;
>  			}
>  
>  			if (cpu_is_omap44xx()) {
> -				old0 = __raw_readl(bank->base +
> -						OMAP4_GPIO_LEVELDETECT0);
> -				old1 = __raw_readl(bank->base +
> -						OMAP4_GPIO_LEVELDETECT1);
> -				__raw_writel(old0 | l, bank->base +
> -						OMAP4_GPIO_LEVELDETECT0);
> -				__raw_writel(old1 | l, bank->base +
> -						OMAP4_GPIO_LEVELDETECT1);
> -				__raw_writel(old0, bank->base +
> -						OMAP4_GPIO_LEVELDETECT0);
> -				__raw_writel(old1, bank->base +
> -						OMAP4_GPIO_LEVELDETECT1);
> +				old0 |= l;
> +				old1 |= l;
>  			}
> +			__raw_writel(old0, bank->base + offset->leveldetect0);
> +			__raw_writel(old1, bank->base + offset->leveldetect1);
>  		}
>  	}
> -
>  }
>  
>  #endif
> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
> index 81ba1f0..d4e9f3c 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -189,6 +189,10 @@ struct omap_gpio_reg_offs {
>  	u16 debounce;
>  	u16 debounce_en;
>  	u16 ctrl;
> +	u16 leveldetect0;
> +	u16 leveldetect1;
> +	u16 risingdetect;
> +	u16 fallingdetect;
>  	u16 wkupstatus;
>  	u16 wkupclear;
>  	u16 wkupset;

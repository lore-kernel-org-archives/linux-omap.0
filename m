From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 08/18] GPIO: OMAP: Use wkup regs off/suspend support flag
Date: Thu, 16 Jun 2011 10:38:43 -0700
Message-ID: <87pqmdn0bg.fsf@ti.com>
References: <1308111776-29130-1-git-send-email-tarun.kanti@ti.com>
	<1308111776-29130-7-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:47311 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757906Ab1FPRit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 13:38:49 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1356190pzk.15
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 10:38:47 -0700 (PDT)
In-Reply-To: <1308111776-29130-7-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 15 Jun 2011 09:52:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Wakeup register offsets are initialized according to OMAP versions
> during device registration. These explicit checks are no longer needed.
>
> mpuio_init() function is defined under #ifdefs. It is required only in case
> of MPUIO bank type and only when PM operations are supported by it.
> This is applicable only in case of OMAP16xx SoC's MPUIO GPIO bank type.
> For all the other cases it is a dummy function. Hence clean up the same
> and remove all the OMAP SoC specific #ifdefs.
>
> bank_is_mpuio() is defined as a check to identify if the bank type is MPUIO.
> It is not required to define it separately as zero for OMAP2plus. Remove this.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>

[...]

> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index cdbc728..ea1556b 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -72,6 +72,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  
>  	dev_attr = (struct omap_gpio_dev_attr *)oh->dev_attr;
>  	pdata->bank_width = dev_attr->bank_width;
> +	pdata->suspend_support = true;
>  	pdata->dbck_flag = dev_attr->dbck_flag;
>  	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * (id - 1);
>  	pdata->get_context_loss_count = omap_gpio_get_context_loss;
> @@ -108,6 +109,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  		pdata->regs->debounce = OMAP24XX_GPIO_DEBOUNCE_VAL;
>  		pdata->regs->debounce_en = OMAP24XX_GPIO_DEBOUNCE_EN;
>  		pdata->regs->ctrl = OMAP24XX_GPIO_CTRL;
> +		pdata->regs->wkup_status = OMAP24XX_GPIO_WAKE_EN;
> +		pdata->regs->wkup_clear = OMAP24XX_GPIO_CLEARWKUENA;
> +		pdata->regs->wkup_set = OMAP24XX_GPIO_SETWKUENA;
>  		break;
>  	case 2:
>  		pdata->bank_type = METHOD_GPIO_44XX;
> @@ -125,6 +129,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  		pdata->regs->debounce = OMAP4_GPIO_DEBOUNCINGTIME;
>  		pdata->regs->debounce_en = OMAP4_GPIO_DEBOUNCENABLE;
>  		pdata->regs->ctrl = OMAP4_GPIO_CTRL;
> +		pdata->regs->wkup_status = OMAP4_GPIO_IRQWAKEN0;
> +		pdata->regs->wkup_clear = OMAP4_GPIO_IRQWAKEN0;
> +		pdata->regs->wkup_set = OMAP4_GPIO_IRQWAKEN0;
>  		break;

This is wrong for OMAP4.

The wkup_clear & wkup_set registers offsets are for the registers
*dedicated* to set and clear.    Any usage of these offets assumes that
a single write will either set or clear the register, which is clearly
not the case with IRQWAKEN, which requires a read/modify/write.

For example, in suspend this is done:

	__raw_writel(0xffffffff, wake_clear);
	__raw_writel(bank->suspend_wakeup, wake_set);

As both the set & clear are set to IRQWAKEN on OMAP4, this means that
wakeups are actually enabled for *all* GPIOs in every bank during
suspend.  This is clearly not what's intended.  Also, since resume does
something similar, wakeups for *all* GPIOs are left enabled after resume
as well.

Also, the 44xx TRMs recommend not using the set/clear registers at all
for OMAP4, so they should be left blank.

Instead, any usage of the wake set/clear registers in the code should
probably be converted to just use read/modify/writes on wake_status so
it's the same for all SoCs.

Kevin

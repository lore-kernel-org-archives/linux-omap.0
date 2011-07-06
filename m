From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 08/20] GPIO: OMAP: Use wkup regs off/suspend support flag
Date: Wed, 06 Jul 2011 12:51:17 -0700
Message-ID: <871uy3i3wq.fsf@ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
	<1309513634-20971-9-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:43678 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755484Ab1GFTvV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 15:51:21 -0400
Received: by mail-pz0-f50.google.com with SMTP id 2so234175pzk.9
        for <linux-omap@vger.kernel.org>; Wed, 06 Jul 2011 12:51:20 -0700 (PDT)
In-Reply-To: <1309513634-20971-9-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Fri, 1 Jul 2011 15:17:02 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
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

The MPUIO stuff should really be separated from the wkup register stuff.

[...]

> @@ -596,27 +594,11 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&bank->lock, flags);
> -#ifdef CONFIG_ARCH_OMAP16XX
> -	if (bank->method == METHOD_GPIO_1610) {
> -		/* Disable wake-up during idle for dynamic tick */
> -		void __iomem *reg = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
> -		__raw_writel(1 << offset, reg);
> -	}
> -#endif
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> -	if (bank->method == METHOD_GPIO_24XX) {
> -		/* Disable wake-up during idle for dynamic tick */
> -		void __iomem *reg = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
> -		__raw_writel(1 << offset, reg);
> -	}
> -#endif
> -#ifdef CONFIG_ARCH_OMAP4
> -	if (bank->method == METHOD_GPIO_44XX) {
> +
> +	if (bank->regs->wkup_clear)
>  		/* Disable wake-up during idle for dynamic tick */
> -		void __iomem *reg = bank->base + OMAP4_GPIO_IRQWAKEN0;
> -		__raw_writel(1 << offset, reg);
> -	}
> -#endif
> +		__raw_writel(1 << offset, bank->base + bank->regs->wkup_clear);
> +

Note that this is not an equivalent change.  The current code is using
IRQWAKEN0 register and you're changing it to use the CLEARWKUPENA
register.

While the current code is clearly broken since it's not doing a
read/modify/write, this change is not very clear either, and not
documented in the changelog.

I think a better approach is to just drop the parts of this patch where
the wkup_set and wkup_clear registers are added.  Since they are removed
in patch 12/20 anyways, maybe moving 12/20 earlier in the series
would make this clearer and avoid unnessary additions followed by
removals.

Kevin

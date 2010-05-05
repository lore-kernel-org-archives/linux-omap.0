From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: ARCH_OMAP34XX usage in gpio PM code
Date: Wed, 05 May 2010 14:20:09 -0700
Message-ID: <87tyqm3v1y.fsf@deeprootsystems.com>
References: <4BE14EBB.3060205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:61302 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756299Ab0EEVUN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 17:20:13 -0400
Received: by pzk42 with SMTP id 42so1642920pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 14:20:12 -0700 (PDT)
In-Reply-To: <4BE14EBB.3060205@ti.com> (Ranjith Lohithakshan's message of "Wed\, 05 May 2010 16\:25\:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ranjith Lohithakshan <ranjithl@ti.com> writes:

> Kevin,
>
> Most of the ARCH_OMAP34XX usage has been converted to ARCH_OMAP3,
> however there is still a piece of code in gpio on PM branch that refers
> ARCH_OMAP34XX
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 7b2178c..0c84aae 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -2095,7 +2095,7 @@ static int omap_gpio_suspend(struct sys_device
> *dev, pm_me
>                 __raw_writel(bank->suspend_wakeup, wake_set);
>                 spin_unlock_irqrestore(&bank->lock, flags);
>
> -#ifdef CONFIG_ARCH_OMAP34XX
> +#ifdef CONFIG_ARCH_OMAP3
>                 if (bank->method == METHOD_GPIO_24XX) {
>                         int j;
>                         for (j = 0; j < 32; j++) {
>
> Shouldn't we be making this change? Let me know and I will include it in
> the ads7846 wakeup series.

You're right.  Good catch.

Please submit this fix as a separate patch and I will add it to the
pm-gpio branch.

Thanks,

Kevin


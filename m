From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 09/20] GPIO: OMAP: Use level/edge detect reg offsets
Date: Wed, 06 Jul 2011 12:57:46 -0700
Message-ID: <87hb6zgp1h.fsf@ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
	<1309513634-20971-10-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:35020 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755435Ab1GFT5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 15:57:52 -0400
Received: by iyb3 with SMTP id 3so294502iyb.32
        for <linux-omap@vger.kernel.org>; Wed, 06 Jul 2011 12:57:51 -0700 (PDT)
In-Reply-To: <1309513634-20971-10-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Fri, 1 Jul 2011 15:17:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> By adding level and edge detection register offsets and then initializing them
> correctly according to OMAP versions during device registrations we can now remove
> lot of revision checks in these functions.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>

Looks good.   One very minor nit below...

[...]

> @@ -1247,40 +1240,18 @@ void omap2_gpio_prepare_for_idle(int off_mode)
>  		if (!(bank->enabled_non_wakeup_gpios))
>  			goto save_gpio_ctx;
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
> +		bank->saved_datain = __raw_readl(bank->base +
> +							bank->regs->datain);
> +		l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
> +		l2 = __raw_readl(bank->base + bank->regs->risingdetect);

The l1 = 0, l2 = 0 assignments can now be removed at the beginning of
this function also.  Similarily for the 'l = 0' assignment in the
runtime_resume function.

Kevin

From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/6] gpio/omap: remove saved_wakeup field from struct gpio_bank
Date: Mon, 27 Feb 2012 15:50:24 -0800
Message-ID: <87aa43vnsv.fsf@ti.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
	<1329999031-6914-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:48577 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754672Ab2B0Xud (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Feb 2012 18:50:33 -0500
Received: by mail-pw0-f52.google.com with SMTP id um15so8841016pbc.25
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 15:50:26 -0800 (PST)
In-Reply-To: <1329999031-6914-3-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Thu, 23 Feb 2012 17:40:27 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, grant.likely@secretlab.ca, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> There is no more need to have saved_wakeup. Instead we can use
> context.wake_en which holds the current wakeup enable register
> context. This also means that the read from wakeup enable register
> is not needed.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Looks right, but one question below...

> ---
>  drivers/gpio/gpio-omap.c |   13 ++++---------
>  1 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 40a1fb2..64f15d5 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -54,7 +54,6 @@ struct gpio_bank {
>  	u16 irq;
>  	u16 virtual_irq_start;
>  	u32 suspend_wakeup;
> -	u32 saved_wakeup;
>  	u32 non_wakeup_gpios;
>  	u32 enabled_non_wakeup_gpios;
>  	struct gpio_regs context;
> @@ -772,7 +771,7 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
>  	unsigned long		flags;
>  
>  	spin_lock_irqsave(&bank->lock, flags);
> -	bank->saved_wakeup = __raw_readl(mask_reg);
> +	bank->context.wake_en = __raw_readl(mask_reg);

Why is this read needed?

Kevin

>  	__raw_writel(0xffff & ~bank->suspend_wakeup, mask_reg);
>  	spin_unlock_irqrestore(&bank->lock, flags);
>  

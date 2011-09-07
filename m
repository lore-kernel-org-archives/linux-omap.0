From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 24/25] gpio/omap: restore OE only after setting the output level
Date: Tue, 06 Sep 2011 17:06:33 -0700
Message-ID: <87ty8pusfq.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-25-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:58377 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750760Ab1IGAGi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 20:06:38 -0400
Received: by mail-yx0-f174.google.com with SMTP id 19so3439862yxj.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 17:06:37 -0700 (PDT)
In-Reply-To: <1314798161-19523-25-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 31 Aug 2011 19:12:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> Setup the dataout register before setting the GPIO to output mode
> in restore path.

Please summarize why.  (again, it may seem obvious now, but may not be for
those not familiar with the driver or when coming back to it after a few
months looking at other code.

Kevin

> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index db22df8..a629498 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1326,7 +1326,6 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>  	__raw_writel(bank->context.wake_en,
>  				bank->base + bank->regs->wkup_en);
>  	__raw_writel(bank->context.ctrl, bank->base + bank->regs->ctrl);
> -	__raw_writel(bank->context.oe, bank->base + bank->regs->direction);
>  	__raw_writel(bank->context.leveldetect0,
>  				bank->base + bank->regs->leveldetect0);
>  	__raw_writel(bank->context.leveldetect1,
> @@ -1336,6 +1335,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>  	__raw_writel(bank->context.fallingdetect,
>  				bank->base + bank->regs->fallingdetect);
>  	__raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
> +	__raw_writel(bank->context.oe, bank->base + bank->regs->direction);
>  
>  	if (bank->dbck_enable_mask) {
>  		__raw_writel(bank->context.debounce, bank->base +

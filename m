From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 22/25] gpio/omap: save and restore debounce registers
Date: Tue, 06 Sep 2011 17:03:10 -0700
Message-ID: <877h5lw75t.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-23-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:56443 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755419Ab1IGADO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 20:03:14 -0400
Received: by mail-gx0-f174.google.com with SMTP id 21so4912974gxk.5
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 17:03:13 -0700 (PDT)
In-Reply-To: <1314798161-19523-23-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 31 Aug 2011 19:12:38 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Nishant Menon <nm@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Nishant Menon <nm@ti.com>

Check spelling of first name (I believe version in signed-off-by below
is the correct one.)

> GPIO debounce registers need to be saved and restored for proper functioning
> of driver. To save the registers, we cannot cut the clock before the save,
> hence move the clk disable after the save.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |   22 +++++++++++++++++++---
>  1 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index dc382f6..67e08e9 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -41,6 +41,8 @@ struct gpio_regs {
>  	u32 risingdetect;
>  	u32 fallingdetect;
>  	u32 dataout;
> +	u32 debounce;
> +	u32 debounce_en;
>  };
>  
>  struct gpio_bank {
> @@ -1158,9 +1160,6 @@ static int omap_gpio_runtime_suspend(struct device *dev)
>  	u32 l1 = 0, l2 = 0;
>  	int j;
>  
> -	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
> -		clk_disable(bank->dbck);
> -
>  	if (!bank->mod_usage)
>  		return 0;
>  
> @@ -1192,6 +1191,16 @@ update_gpio_context_count:
>  		bank->context_loss_count =
>  				bank->get_context_loss_count(bank->dev);
>  
> +	if (bank->dbck_enable_mask) {
> +		bank->context.debounce = __raw_readl(bank->base +
> +						bank->regs->debounce);
> +		bank->context.debounce_en = __raw_readl(bank->base +
> +						bank->regs->debounce_en);

Here you're taking a step backwards from the goal of not having to read
registers in the runtime suspend callback.

Rather than reading the registers here, the values should be saved into
bank->context when they are initially written (_set_gpio_debounce()), so
you don't have the overhead of reading the registers in ->runtime_suspend.

> +	}
> +
> +	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
> +		clk_disable(bank->dbck);
> +
>  	return 0;
>  }
>  
> @@ -1331,6 +1340,13 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>  	__raw_writel(bank->context.fallingdetect,
>  				bank->base + bank->regs->fallingdetect);
>  	__raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
> +
> +	if (bank->dbck_enable_mask) {
> +		__raw_writel(bank->context.debounce, bank->base +
> +					bank->regs->debounce);
> +		__raw_writel(bank->context.debounce_en,
> +					bank->base + bank->regs->debounce_en);
> +	}
>  }
>  #else
>  #define omap_gpio_runtime_suspend NULL

Kevin

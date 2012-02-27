From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/6] gpio/omap: remove suspend_wakeup field from struct gpio_bank
Date: Mon, 27 Feb 2012 15:54:37 -0800
Message-ID: <87ty2bu91e.fsf@ti.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
	<1329999031-6914-4-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1329999031-6914-4-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Thu, 23 Feb 2012 17:40:28 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, grant.likely@secretlab.ca, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Since we already have bank->context.wake_en to keep track
> of gpios which are wakeup enabled, there is no need to have
> this field any more.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

I'm not crazy about this change...

> ---
>  drivers/gpio/gpio-omap.c |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 64f15d5..b62e861 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -53,7 +53,6 @@ struct gpio_bank {
>  	void __iomem *base;
>  	u16 irq;
>  	u16 virtual_irq_start;
> -	u32 suspend_wakeup;
>  	u32 non_wakeup_gpios;
>  	u32 enabled_non_wakeup_gpios;
>  	struct gpio_regs context;
> @@ -497,9 +496,9 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
>  
>  	spin_lock_irqsave(&bank->lock, flags);
>  	if (enable)
> -		bank->suspend_wakeup |= gpio_bit;
> +		bank->context.wake_en |= gpio_bit;
>  	else
> -		bank->suspend_wakeup &= ~gpio_bit;
> +		bank->context.wake_en &= ~gpio_bit;

The bank->context values are expected to be copies of the actual
register contents, and here that is clearly not the case.

With this change, you're using the context register to track changes
that you *might* eventually write to the register.

IMO, this is more confusing than having a separate field to track this.

Kevin

>  	spin_unlock_irqrestore(&bank->lock, flags);
>  
> @@ -772,7 +771,7 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
>  
>  	spin_lock_irqsave(&bank->lock, flags);
>  	bank->context.wake_en = __raw_readl(mask_reg);
> -	__raw_writel(0xffff & ~bank->suspend_wakeup, mask_reg);
> +	__raw_writel(0xffff & ~bank->context.wake_en, mask_reg);
>  	spin_unlock_irqrestore(&bank->lock, flags);
>  
>  	return 0;
> @@ -1137,12 +1136,12 @@ static int omap_gpio_suspend(struct device *dev)
>  	if (!bank->mod_usage || !bank->loses_context)
>  		return 0;
>  
> -	if (!bank->regs->wkup_en || !bank->suspend_wakeup)
> +	if (!bank->regs->wkup_en || !bank->context.wake_en)
>  		return 0;
>  
>  	spin_lock_irqsave(&bank->lock, flags);
>  	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
> -	_gpio_rmw(base, bank->regs->wkup_en, bank->suspend_wakeup, 1);
> +	_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
>  	spin_unlock_irqrestore(&bank->lock, flags);
>  
>  	return 0;

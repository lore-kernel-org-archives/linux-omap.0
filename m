From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH omap-fixes] OMAP2/3: GPIO: remove recursion in IRQ wakeup path
Date: Mon, 02 Feb 2009 09:51:29 -0800
Message-ID: <87bptkenha.fsf@deeprootsystems.com>
References: <1233167723-12026-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:39302 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757515AbZBBRvd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 12:51:33 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1782501wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 02 Feb 2009 09:51:32 -0800 (PST)
In-Reply-To: <1233167723-12026-1-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 28 Jan 2009 10\:35\:23 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Now that the generic IRQ and GPIO frameworks are used for enabling and
> disabling GPIO IRQ wakeup sources, there is no longer a need to call
> [enable|disable]_irq_wake() in the low-level code.  Doing so results
> in recursive calls to [enable|disable]_irq_wake().
>
> This was discovered in the suspend/resume path on OMAP3/Beagle using
> the gpio-keys driver which disables/re-enables GPIO IRQ wakeups in the
> suspend/resume path.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Tony,

Not sure if it's too late, but this could go into omap-fixes too.

Kevin


> ---
>  arch/arm/plat-omap/gpio.c |   14 ++++----------
>  1 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index f856a90..798a8cd 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -837,13 +837,10 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
>  	case METHOD_MPUIO:
>  	case METHOD_GPIO_1610:
>  		spin_lock_irqsave(&bank->lock, flags);
> -		if (enable) {
> +		if (enable)
>  			bank->suspend_wakeup |= (1 << gpio);
> -			enable_irq_wake(bank->irq);
> -		} else {
> -			disable_irq_wake(bank->irq);
> +		else
>  			bank->suspend_wakeup &= ~(1 << gpio);
> -		}
>  		spin_unlock_irqrestore(&bank->lock, flags);
>  		return 0;
>  #endif
> @@ -856,13 +853,10 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
>  			return -EINVAL;
>  		}
>  		spin_lock_irqsave(&bank->lock, flags);
> -		if (enable) {
> +		if (enable)
>  			bank->suspend_wakeup |= (1 << gpio);
> -			enable_irq_wake(bank->irq);
> -		} else {
> -			disable_irq_wake(bank->irq);
> +		else
>  			bank->suspend_wakeup &= ~(1 << gpio);
> -		}
>  		spin_unlock_irqrestore(&bank->lock, flags);
>  		return 0;
>  #endif
> -- 
> 1.6.1

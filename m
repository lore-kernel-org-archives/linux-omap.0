From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH omap-fixes] OMAP2/3: GPIO: remove recursion in IRQ wakeup path
Date: Sun, 8 Feb 2009 20:39:32 -0800
Message-ID: <200902082039.32157.david-b@pacbell.net>
References: <1233167723-12026-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:22077 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753836AbZBIEje (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Feb 2009 23:39:34 -0500
In-Reply-To: <1233167723-12026-1-git-send-email-khilman@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 28 January 2009, Kevin Hilman wrote:
> Now that the generic IRQ and GPIO frameworks are used for enabling and
> disabling GPIO IRQ wakeup sources, there is no longer a need to call
> [enable|disable]_irq_wake() in the low-level code.  Doing so results
> in recursive calls to [enable|disable]_irq_wake().

Could you clarify what actually made that requirement go away?

The recursion was introduced -- using the generic IRQ framework! -- as
a simple way to ensure the parent IRQ was properly wake-enabled.  Is
the issue that something changed, so that something else wake-enables
the parent?

- Dave


> This was discovered in the suspend/resume path on OMAP3/Beagle using
> the gpio-keys driver which disables/re-enables GPIO IRQ wakeups in the
> suspend/resume path.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
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
> 
> 

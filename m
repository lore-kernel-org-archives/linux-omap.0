From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: GPIO: Added dynamic control logic for pad wakeups
Date: Mon, 08 Mar 2010 09:06:04 -0800
Message-ID: <873a0awxoj.fsf@deeprootsystems.com>
References: <1255695824-17523-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62223 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab0CHRGI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 12:06:08 -0500
Received: by pvb32 with SMTP id 32so1468194pvb.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 09:06:07 -0800 (PST)
In-Reply-To: <1255695824-17523-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 16 Oct 2009 15\:23\:44 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Pad wakeups are now enabled if the corresponding GPIO interrupt is enabled.
>
> Applies on top of PM branch.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

I just discovered this one in patchwork... sorry for the delay.

Changes in wakeup state should not be directly correlated to interrupt
enabled GPIOs.  Rather, this should only be done for GPIOs that are
explicitly wakeup enabled (via enable_irq_wake(), which in turn
calls gpio_wake_enable()).

A couple other minor comments below...

> ---
>  arch/arm/plat-omap/gpio.c |   22 +++++++++++++++++++++-
>  1 files changed, 21 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index e242112..fa79db2 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -267,6 +267,7 @@ static struct gpio_bank gpio_bank_34xx[6] = {
>  #define OMAP34XX_PAD_SAFE_MODE 0x7
>  #define OMAP34XX_PAD_IN_PU_GPIO 0x11c
>  #define OMAP34XX_PAD_IN_PD_GPIO 0x10c
> +#define OMAP34XX_PAD_WAKE_EN (1 << 14)

Can use BIT(14) here

>  struct omap3_gpio_regs {
>  	u32 sysconfig;
> @@ -713,6 +714,8 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>  {
>  	void __iomem *base = bank->base;
>  	u32 gpio_bit = 1 << gpio;
> +	struct gpio_pad *pad;
> +	int gpio_num;
>  	u32 val;
>  
>  	if (cpu_is_omap44xx()) {
> @@ -750,6 +753,23 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>  			 * GPIO wakeup request can only be generated on edge
>  			 * transitions
>  			 */

The comment above needs to stay with the original code.

> +			pad = gpio_pads;
> +
> +			gpio_num = bank->virtual_irq_start - IH_GPIO_BASE +
> +				gpio;
> +			/* Find the pad corresponding the GPIO */
> +			while (pad->gpio >= 0 && pad->gpio != gpio_num)
> +				pad++;
> +			/* Enable / disable pad wakeup */
> +			if (pad->gpio == gpio_num) {
> +				val = omap_ctrl_readw(pad->offset);
> +				if (trigger & IRQ_TYPE_EDGE_BOTH)
> +					val |= OMAP34XX_PAD_WAKE_EN;
> +				else
> +					val &= ~(u16)OMAP34XX_PAD_WAKE_EN;
> +				omap_ctrl_writew(val, pad->offset);
> +			}
> +
>  			if (trigger & IRQ_TYPE_EDGE_BOTH)
>  				__raw_writel(1 << gpio, bank->base
>  					+ OMAP24XX_GPIO_SETWKUENA);
> @@ -1654,7 +1674,7 @@ static int __init omap3_gpio_pads_init(void)
>  	gpio_pads[gpio_amt].gpio = -1;
>  	return 0;
>  }
> -late_initcall(omap3_gpio_pads_init);
> +early_initcall(omap3_gpio_pads_init);

This change isn't explained in the changelog and appears unrelated to
this patch.


Kevin

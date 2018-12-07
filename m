From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP4430 SDP with KS8851: very slow networking
Date: Fri, 7 Dec 2018 10:14:20 -0800
Message-ID: <20181207181420.GS6707@atomide.com>
References: <20181206132256.GT30658@n2100.armlinux.org.uk>
 <20181206163154.GK6707@atomide.com>
 <20181206180806.GV6920@n2100.armlinux.org.uk>
 <20181206221447.GM6707@atomide.com>
 <20181207180020.GA9507@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181207180020.GA9507@n2100.armlinux.org.uk>
Sender: netdev-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Russell King - ARM Linux <linux@armlinux.org.uk> [181207 18:01]:
> Hi Tony,
> 
> You know most of what's been going on from IRC, but here's the patch
> which gets me:
> 
> 1) working interrupts for networking
> 2) solves the stuck-wakeup problem
> 
> It also contains some of the debug bits I added.

This is excellent news :) Will test today.

> I think what this means is that we should strip out ec0daae685b2
> ("gpio: omap: Add level wakeup handling for omap4 based SoCs").

Yes the only reason for the wakeup quirk was the stuck wakeup
state seen on omap4, it can be just dropped if this works.
Adding Grygorii to Cc too.

Regards,

Tony

> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 3d021f648c5d..528ffd1b9832 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -11,7 +11,7 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> -
> +#define DEBUG
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
> @@ -366,10 +366,14 @@ static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
>  		      trigger & IRQ_TYPE_LEVEL_LOW);
>  	omap_gpio_rmw(base, bank->regs->leveldetect1, gpio_bit,
>  		      trigger & IRQ_TYPE_LEVEL_HIGH);
> +	/*
> +	 * We need the edge detect enabled for the idle mode detection
> +	 * to function on OMAP4430.
> +	 */
>  	omap_gpio_rmw(base, bank->regs->risingdetect, gpio_bit,
> -		      trigger & IRQ_TYPE_EDGE_RISING);
> +		      trigger & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_LEVEL_HIGH));
>  	omap_gpio_rmw(base, bank->regs->fallingdetect, gpio_bit,
> -		      trigger & IRQ_TYPE_EDGE_FALLING);
> +		      trigger & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_LEVEL_LOW));
>  
>  	bank->context.leveldetect0 =
>  			readl_relaxed(bank->base + bank->regs->leveldetect0);
> @@ -910,14 +914,16 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
>  	if (trigger)
>  		omap_set_gpio_triggering(bank, offset, trigger);
>  
> +	omap_set_gpio_irqenable(bank, offset, 1);
> +
>  	/* For level-triggered GPIOs, the clearing must be done after
> -	 * the HW source is cleared, thus after the handler has run */
> -	if (bank->level_mask & BIT(offset)) {
> -		omap_set_gpio_irqenable(bank, offset, 0);
> +	 * the HW source is cleared, thus after the handler has run.
> +	 * OMAP4 needs this done _after_ enabing the interrupt to clear
> +	 * the wakeup status.
> +	 */
> +	if (bank->level_mask & BIT(offset))
>  		omap_clear_gpio_irqstatus(bank, offset);
> -	}
>  
> -	omap_set_gpio_irqenable(bank, offset, 1);
>  	raw_spin_unlock_irqrestore(&bank->lock, flags);
>  }
>  
> @@ -1520,6 +1526,10 @@ static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
>  	struct device *dev = bank->chip.parent;
>  	u32 l1 = 0, l2 = 0;
>  
> +	dev_dbg(dev, "%s(): ld 0x%08x 0x%08x we 0x%08x\n", __func__,
> +		bank->context.leveldetect0, bank->context.leveldetect1,
> +		bank->context.wake_en);
> +
>  	if (bank->funcs.idle_enable_level_quirk)
>  		bank->funcs.idle_enable_level_quirk(bank);
>  
> @@ -1553,6 +1563,10 @@ static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
>  				bank->get_context_loss_count(dev);
>  
>  	omap_gpio_dbck_disable(bank);
> +
> +	dev_dbg(dev, "%s(): ld 0x%08x 0x%08x we 0x%08x\n", __func__,
> +		bank->context.leveldetect0, bank->context.leveldetect1,
> +		bank->context.wake_en);
>  }
>  
>  static void omap_gpio_init_context(struct gpio_bank *p);
> @@ -1563,6 +1577,10 @@ static void omap_gpio_unidle(struct gpio_bank *bank)
>  	u32 l = 0, gen, gen0, gen1;
>  	int c;
>  
> +	dev_dbg(dev, "%s(): ld 0x%08x 0x%08x we 0x%08x\n", __func__,
> +		bank->context.leveldetect0, bank->context.leveldetect1,
> +		bank->context.wake_en);
> +
>  	/*
>  	 * On the first resume during the probe, the context has not
>  	 * been initialised and so initialise it now. Also initialise
> @@ -1648,6 +1666,10 @@ static void omap_gpio_unidle(struct gpio_bank *bank)
>  	}
>  
>  	bank->workaround_enabled = false;
> +
> +	dev_dbg(dev, "%s(): ld 0x%08x 0x%08x we 0x%08x\n", __func__,
> +		bank->context.leveldetect0, bank->context.leveldetect1,
> +		bank->context.wake_en);
>  }
>  
>  static void omap_gpio_init_context(struct gpio_bank *p)
> @@ -1720,6 +1742,7 @@ static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
>  		error = -EBUSY;
>  		goto unlock;
>  	}
> +	dev_dbg(dev, "%s()\n", __func__);
>  	omap_gpio_idle(bank, true);
>  	bank->is_suspended = true;
>  unlock:
> @@ -1741,6 +1764,7 @@ static int __maybe_unused omap_gpio_runtime_resume(struct device *dev)
>  		error = -EBUSY;
>  		goto unlock;
>  	}
> +	dev_dbg(dev, "%s()\n", __func__);
>  	omap_gpio_unidle(bank);
>  	bank->is_suspended = false;
>  unlock:
> @@ -1827,8 +1851,8 @@ static const struct omap_gpio_platform_data omap4_pdata = {
>  	.regs = &omap4_gpio_regs,
>  	.bank_width = 32,
>  	.dbck_flag = true,
> -	.quirks = OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER |
> -		  OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN,
> +	.quirks = OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER /* |
> +		  OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN */,
>  };
>  
>  static const struct of_device_id omap_gpio_match[] = {
> 
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

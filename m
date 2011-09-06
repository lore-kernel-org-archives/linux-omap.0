From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 17/25] gpio/omap: use pm-runtime framework
Date: Tue, 06 Sep 2011 16:49:51 -0700
Message-ID: <87ehztxmcg.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-18-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39285 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755407Ab1IFXt4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 19:49:56 -0400
Received: by mail-gy0-f175.google.com with SMTP id 4so4957458gyg.34
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 16:49:55 -0700 (PDT)
In-Reply-To: <1314798161-19523-18-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 31 Aug 2011 19:12:33 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Call runtime pm APIs pm_runtime_get_sync() and pm_runtime_put_sync()
> for enabling/disabling clocks appropriately. Remove syscore_ops and
> instead use dev_pm_ops now.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |   89 ++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 67 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 6e7399c..f36931a 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -79,6 +79,8 @@ struct gpio_bank {
>  	struct omap_gpio_reg_offs *regs;
>  };
>  
> +static void omap_gpio_mod_init(struct gpio_bank *bank);
> +
>  #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
>  #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
>  #define GPIO_MOD_CTRL_BIT	BIT(0)
> @@ -476,6 +478,19 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
>  
>  	spin_lock_irqsave(&bank->lock, flags);
>  
> +	/*
> +	 * If this is the first gpio_request for the bank,
> +	 * enable the bank module.
> +	 */
> +	if (!bank->mod_usage)
> +		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {

All of the IS_ERR_VALUE() usage is wrong here.  You're checking if the
result of IS_ERR_VALUE() is < 0 which will never happen.

> +			dev_err(bank->dev, "%s: GPIO bank %d "
> +					"pm_runtime_get_sync failed\n",
> +					__func__, bank->id);
> +			spin_unlock_irqrestore(&bank->lock, flags);

Rather than take the lock and have to unlock it here, just move the
get_sync before the spinlock.  There's no reason to hold the spinlock
across the get_sync.

In fact, holding the spinlock across a get sync means that the
->runtime_resume callback does not have proper locking around register
access, which is also probably wrong.

The locking in this driver is only around device register accesses, and
should be kept minimal and to very small critical sections.

> +			return -EINVAL;
> +		}
> +
>  	/* Set trigger to none. You need to enable the desired trigger with
>  	 * request_irq() or set_irq_type().
>  	 */
> @@ -530,6 +545,19 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>  	}
>  
>  	_reset_gpio(bank, bank->chip.base + offset);
> +
> +	/*
> +	 * If this is the last gpio to be freed in the bank,
> +	 * disable the bank module.
> +	 */
> +	if (!bank->mod_usage) {
> +		if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0)) {
> +			dev_err(bank->dev, "%s: GPIO bank %d "
> +					"pm_runtime_put_sync failed\n",
> +					__func__, bank->id);
> +		}
> +	}
> +

same here, this should be after unlocking the spinlock, and register
accesses inside the ->runtime_resume() callback need their own
protection.

>  	spin_unlock_irqrestore(&bank->lock, flags);
>  }
>  
> @@ -556,6 +584,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  
>  	bank = irq_get_handler_data(irq);
>  	isr_reg = bank->base + bank->regs->irqstatus;
> +	pm_runtime_get_sync(bank->dev);
>  
>  	if (WARN_ON(!isr_reg))
>  		goto exit;
> @@ -617,6 +646,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  exit:
>  	if (!unmasked)
>  		chained_irq_exit(chip, desc);
> +	pm_runtime_put_sync_suspend(bank->dev);

Why use _put_sync_suspend()? 

Why does this need to be synchronous?  I think it should use the
asynchronous pm_runtime_put(). 

>  }
>  
>  static void gpio_irq_shutdown(struct irq_data *d)
> @@ -1018,7 +1048,13 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>  	}
>  
>  	pm_runtime_enable(bank->dev);
> -	pm_runtime_get_sync(bank->dev);
> +	pm_runtime_irq_safe(bank->dev);
> +	if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
> +		dev_err(bank->dev, "%s: GPIO bank %d pm_runtime_get_sync "
> +				"failed\n", __func__, bank->id);
> +		iounmap(bank->base);
> +		return -EINVAL;
> +	}
>  
>  	if (bank->is_mpuio)
>  		mpuio_init(bank);
> @@ -1027,6 +1063,13 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>  	omap_gpio_chip_init(bank);
>  	omap_gpio_show_rev(bank);
>  
> +	if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0)) {
> +		dev_err(bank->dev, "%s: GPIO bank %d pm_runtime_put_sync "
> +				"failed\n", __func__, bank->id);
> +		iounmap(bank->base);
> +		return -EINVAL;
> +	}
> +
>  	list_add_tail(&bank->node, &omap_gpio_list);
>  
>  	return ret;
> @@ -1037,7 +1080,7 @@ err_exit:
>  	return ret;
>  }
>  
> -static int omap_gpio_suspend(void)
> +static int omap_gpio_suspend(struct device *dev)
>  {
>  	struct gpio_bank *bank;
>  
> @@ -1055,12 +1098,13 @@ static int omap_gpio_suspend(void)
>  		bank->saved_wakeup = __raw_readl(wake_status);
>  		MOD_REG_BIT(bank->regs->wkup_en, bank->suspend_wakeup, 1);
>  		spin_unlock_irqrestore(&bank->lock, flags);
> +		pm_runtime_put_sync(dev);
>  	}
>  
>  	return 0;
>  }
>  
> -static void omap_gpio_resume(void)
> +static int omap_gpio_resume(struct device *dev)
>  {
>  	struct gpio_bank *bank;
>  
> @@ -1069,18 +1113,16 @@ static void omap_gpio_resume(void)
>  		unsigned long flags;
>  
>  		if (!bank->regs->wkup_en)
> -			return;
> +			return 0;
>  
> +		pm_runtime_get_sync(dev);
>  		spin_lock_irqsave(&bank->lock, flags);
>  		MOD_REG_BIT(bank->regs->wkup_en, bank->saved_wakeup, 1);
>  		spin_unlock_irqrestore(&bank->lock, flags);
>  	}
> -}
>  
> -static struct syscore_ops omap_gpio_syscore_ops = {
> -	.suspend	= omap_gpio_suspend,
> -	.resume		= omap_gpio_resume,
> -};
> +	return 0;
> +}
>  
>  #ifdef CONFIG_ARCH_OMAP2PLUS
>  
> @@ -1104,6 +1146,11 @@ void omap2_gpio_prepare_for_idle(int off_mode)
>  		if (!off_mode)
>  			continue;
>  
> +		if (IS_ERR_VALUE(pm_runtime_put_sync_suspend(bank->dev) < 0))

_put_sync()

> +			dev_err(bank->dev, "%s: GPIO bank %d "
> +					"pm_runtime_put_sync_suspend failed\n",
> +					__func__, bank->id);
> +
>  		/* If going to OFF, remove triggering for all
>  		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
>  		 * generated.  See OMAP2420 Errata item 1.101. */
> @@ -1144,6 +1191,11 @@ void omap2_gpio_resume_after_idle(void)
>  		if (!bank->loses_context)
>  			continue;
>  
> +		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0))
> +			dev_err(bank->dev, "%s: GPIO bank %d "
> +					"pm_runtime_get_sync failed\n",
> +					__func__, bank->id);
> +
>  		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
>  			clk_enable(bank->dbck);
>  
> @@ -1258,10 +1310,16 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>  }
>  #endif
>  
> +static const struct dev_pm_ops gpio_pm_ops = {
> +	.suspend		= omap_gpio_suspend,
> +	.resume			= omap_gpio_resume,
> +};

Please use SET_SYSTEM_SLEEP_PM_OPS().  See <linux/pm.h>

>  static struct platform_driver omap_gpio_driver = {
>  	.probe		= omap_gpio_probe,
>  	.driver		= {
>  		.name	= "omap_gpio",
> +		.pm	= &gpio_pm_ops,
>  	},
>  };
>  
> @@ -1275,16 +1333,3 @@ static int __init omap_gpio_drv_reg(void)
>  	return platform_driver_register(&omap_gpio_driver);
>  }
>  postcore_initcall(omap_gpio_drv_reg);
> -
> -static int __init omap_gpio_sysinit(void)
> -{
> -
> -#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
> -	if (cpu_is_omap16xx() || cpu_class_is_omap2())
> -		register_syscore_ops(&omap_gpio_syscore_ops);
> -#endif
> -
> -	return 0;
> -}
> -
> -arch_initcall(omap_gpio_sysinit);

Kevin

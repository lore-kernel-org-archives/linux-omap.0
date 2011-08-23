From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 18/22] gpio/omap: use pm-runtime framework
Date: Tue, 23 Aug 2011 20:04:40 +0530
Message-ID: <4E53BA80.7030200@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-19-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42377 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752330Ab1HWOet (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 10:34:49 -0400
Received: by mail-gw0-f41.google.com with SMTP id a20so158748gwa.14
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 07:34:48 -0700 (PDT)
In-Reply-To: <1312455893-14922-19-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

+ Rajendra and Benoit to comment on optional clock
handling.

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> Call runtime pm APIs pm_runtime_get_sync() and pm_runtime_put_sync()
> for enabling/disabling clocks appropriately. Remove syscore_ops and
> instead use dev_pm_ops now.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
>   drivers/gpio/gpio-omap.c |   89 ++++++++++++++++++++++++++++++++++-----------
>   1 files changed, 67 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 0545d8f..bca6dcd 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -79,6 +79,8 @@ struct gpio_bank {
>   	struct omap_gpio_reg_offs *regs;
>   };
>
> +static void omap_gpio_mod_init(struct gpio_bank *bank);
> +
>   #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
>   #define GPIO_BIT(bank, gpio) (1<<  GPIO_INDEX(bank, gpio))
>   #define GPIO_MOD_CTRL_BIT	BIT(0)
> @@ -481,6 +483,19 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
>
>   	spin_lock_irqsave(&bank->lock, flags);
>
> +	/*
> +	 * If this is the first gpio_request for the bank,
> +	 * enable the bank module.
> +	 */
> +	if (!bank->mod_usage)
> +		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev)<  0)) {
> +			dev_err(bank->dev, "%s: GPIO bank %d "
> +					"pm_runtime_get_sync failed\n",
> +					__func__, bank->id);
> +			spin_unlock_irqrestore(&bank->lock, flags);
> +			return -EINVAL;
> +		}
> +
>   	/* Set trigger to none. You need to enable the desired trigger with
>   	 * request_irq() or set_irq_type().
>   	 */
> @@ -535,6 +550,19 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>   	}
>
>   	_reset_gpio(bank, bank->chip.base + offset);
> +
> +	/*
> +	 * If this is the last gpio to be freed in the bank,
> +	 * disable the bank module.
> +	 */
> +	if (!bank->mod_usage) {
> +		if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev)<  0)) {
> +			dev_err(bank->dev, "%s: GPIO bank %d "
> +					"pm_runtime_put_sync failed\n",
> +					__func__, bank->id);
> +		}
> +	}
> +
>   	spin_unlock_irqrestore(&bank->lock, flags);
>   }
>
> @@ -561,6 +589,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>
>   	bank = irq_get_handler_data(irq);
>   	isr_reg = bank->base + bank->regs->irqstatus;
> +	pm_runtime_get_sync(bank->dev);
>
>   	if (WARN_ON(!isr_reg))
>   		goto exit;
> @@ -622,6 +651,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>   exit:
>   	if (!unmasked)
>   		chained_irq_exit(chip, desc);
> +	pm_runtime_put_sync_suspend(bank->dev);
>   }
>
>   static void gpio_irq_shutdown(struct irq_data *d)
> @@ -1023,7 +1053,13 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>   	}
>
>   	pm_runtime_enable(bank->dev);
> -	pm_runtime_get_sync(bank->dev);
> +	pm_runtime_irq_safe(bank->dev);
> +	if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev)<  0)) {
> +		dev_err(bank->dev, "%s: GPIO bank %d pm_runtime_get_sync "
> +				"failed\n", __func__, bank->id);
> +		iounmap(bank->base);
> +		return -EINVAL;
> +	}
>
>   	if (bank->is_mpuio) {
>   		if (bank->regs->wkup_status)
> @@ -1034,6 +1070,13 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>   	omap_gpio_chip_init(bank);
>   	omap_gpio_show_rev(bank);
>
> +	if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev)<  0)) {
> +		dev_err(bank->dev, "%s: GPIO bank %d pm_runtime_put_sync "
> +				"failed\n", __func__, bank->id);
> +		iounmap(bank->base);
> +		return -EINVAL;
> +	}
> +
>   	list_add_tail(&bank->node,&omap_gpio_list);
>
>   	return ret;
> @@ -1044,7 +1087,7 @@ err_exit:
>   	return ret;
>   }
>
> -static int omap_gpio_suspend(void)
> +static int omap_gpio_suspend(struct device *dev)
>   {
>   	struct gpio_bank *bank;
>
> @@ -1063,12 +1106,13 @@ static int omap_gpio_suspend(void)
>   		_gpio_rmw(base, bank->regs->wkup_status,
>   					bank->suspend_wakeup, 1);
>   		spin_unlock_irqrestore(&bank->lock, flags);
> +		pm_runtime_put_sync(dev);
>   	}
>
>   	return 0;
>   }
>
> -static void omap_gpio_resume(void)
> +static int omap_gpio_resume(struct device *dev)
>   {
>   	struct gpio_bank *bank;
>
> @@ -1077,18 +1121,16 @@ static void omap_gpio_resume(void)
>   		unsigned long flags;
>
>   		if (!bank->regs->wkup_status)
> -			return;
> +			return 0;
>
> +		pm_runtime_get_sync(dev);
>   		spin_lock_irqsave(&bank->lock, flags);
>   		_gpio_rmw(base, bank->regs->wkup_status, bank->saved_wakeup, 1);
>   		spin_unlock_irqrestore(&bank->lock, flags);
>   	}
> -}
>
> -static struct syscore_ops omap_gpio_syscore_ops = {
> -	.suspend	= omap_gpio_suspend,
> -	.resume		= omap_gpio_resume,
> -};
> +	return 0;
> +}
>
>   #ifdef CONFIG_ARCH_OMAP2PLUS
>
> @@ -1112,6 +1154,11 @@ void omap2_gpio_prepare_for_idle(int off_mode)
>   		if (!off_mode)
>   			continue;
>
> +		if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev)<  0))
> +			dev_err(bank->dev, "%s: GPIO bank %d "
> +					"pm_runtime_put_sync failed\n",
> +					__func__, bank->id);
> +
>   		/* If going to OFF, remove triggering for all
>   		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
>   		 * generated.  See OMAP2420 Errata item 1.101. */
> @@ -1152,6 +1199,11 @@ void omap2_gpio_resume_after_idle(void)
>   		if (!bank->loses_context)
>   			continue;
>
> +		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev)<  0))
> +			dev_err(bank->dev, "%s: GPIO bank %d "
> +					"pm_runtime_get_sync failed\n",
> +					__func__, bank->id);
> +
>   		for (j = 0; j<  hweight_long(bank->dbck_enable_mask); j++)
>   			clk_enable(bank->dbck);
Optional clock handling also should been addressed using runtime hooks,
isn't it ?

We still seems to use clock framework here?

Regards
Santosh



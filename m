From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2 17/18] GPIO: OMAP: Use PM runtime framework
Date: Fri, 17 Jun 2011 10:30:14 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037B9AC54F@dbde02.ent.ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
	<1308111806-29152-8-git-send-email-tarun.kanti@ti.com>
 <87r56tlkm4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53780 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422Ab1FQFJU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 01:09:20 -0400
In-Reply-To: <87r56tlkm4.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, June 16, 2011 11:33 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; tony@atomide.com
> Subject: Re: [PATCH v2 17/18] GPIO: OMAP: Use PM runtime framework
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > From: Charulatha V <charu@ti.com>
> >
> > Call runtime pm APIs pm_runtime_get_sync() and pm_runtime_put_sync()
> > for enabling/disabling clocks appropriately. Remove syscore_ops and
> > instead use dev_pm_ops now.
> >
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> 
> Approach is fine.  some minor comments below..
> 
> > ---
> >  drivers/gpio/gpio-omap.c |  100 ++++++++++++++++++++++++++++++++++++---
> ------
> >  1 files changed, 80 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > index ea984fd..f5bb469 100644
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -80,6 +80,8 @@ struct gpio_bank {
> >  	struct omap_gpio_reg_offs *regs;
> >  };
> >
> > +static void omap_gpio_mod_init(struct gpio_bank *bank);
> > +
> >  #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
> >  #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
> >  #define GPIO_MOD_CTRL_BIT	BIT(0)
> > @@ -492,6 +494,22 @@ static int omap_gpio_request(struct gpio_chip
> *chip, unsigned offset)
> >  	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
> >  	unsigned long flags;
> >
> > +	/*
> > +	 * If this is the first gpio_request for the bank,
> > +	 * enable the bank module.
> > +	 */
> > +	if (!bank->mod_usage) {
> > +		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
> > +			dev_err(bank->dev, "%s: GPIO bank %d "
> > +					"pm_runtime_get_sync failed\n",
> > +					__func__, bank->id);
> > +			return -EINVAL;
> > +		}
> > +
> > +		/* Initialize the gpio bank registers to init time value */
> > +		omap_gpio_mod_init(bank);
> > +	}
> > +
> >  	spin_lock_irqsave(&bank->lock, flags);
> >
> >  	/* Set trigger to none. You need to enable the desired trigger with
> > @@ -548,6 +566,18 @@ static void omap_gpio_free(struct gpio_chip *chip,
> unsigned offset)
> >
> >  	_reset_gpio(bank, bank->chip.base + offset);
> >  	spin_unlock_irqrestore(&bank->lock, flags);
> > +
> > +	/*
> > +	 * If this is the last gpio to be freed in the bank,
> > +	 * disable the bank module.
> > +	 */
> > +	if (!bank->mod_usage) {
> > +		if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0)) {
> > +			dev_err(bank->dev, "%s: GPIO bank %d "
> > +					"pm_runtime_put_sync failed\n",
> > +					__func__, bank->id);
> > +		}
> > +	}
> >  }
> >
> >  /*
> > @@ -572,6 +602,9 @@ static void gpio_irq_handler(unsigned int irq,
> struct irq_desc *desc)
> >  	chained_irq_enter(chip, desc);
> >
> >  	bank = irq_get_handler_data(irq);
> > +
> > +	pm_runtime_get_sync(bank->dev);
> > +
> >  	isr_reg = bank->base + bank->regs->irqstatus;
> >
> >  	if (WARN_ON(!isr_reg))
> > @@ -640,6 +673,8 @@ static void gpio_irq_handler(unsigned int irq,
> struct irq_desc *desc)
> >  exit:
> >  	if (!unmasked)
> >  		chained_irq_exit(chip, desc);
> > +
> > +	pm_runtime_put_sync(bank->dev);
> >  }
> >
> >  static void gpio_irq_shutdown(struct irq_data *d)
> > @@ -1120,12 +1155,25 @@ static int __devinit omap_gpio_probe(struct
> platform_device *pdev)
> >  	}
> >
> >  	pm_runtime_enable(bank->dev);
> > -	pm_runtime_get_sync(bank->dev);
> > +	pm_runtime_irq_safe(bank->dev);
> > +	if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
> > +		dev_err(bank->dev, "%s: GPIO bank %d pm_runtime_get_sync "
> > +				"failed\n", __func__, bank->id);
> > +		iounmap(bank->base);
> > +		return -EINVAL;
> > +	}
> >
> >  	omap_gpio_mod_init(bank);
> >  	omap_gpio_chip_init(bank);
> >  	omap_gpio_show_rev(bank);
> >
> > +	if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0)) {
> > +		dev_err(bank->dev, "%s: GPIO bank %d pm_runtime_put_sync "
> > +				"failed\n", __func__, bank->id);
> > +		iounmap(bank->base);
> > +		return -EINVAL;
> > +	}
> > +
> >  	list_add_tail(&bank->node, &omap_gpio_list);
> >
> >  	return ret;
> > @@ -1136,7 +1184,7 @@ err_exit:
> >  	return ret;
> >  }
> >
> > -static int omap_gpio_suspend(void)
> > +static int omap_gpio_suspend(struct device *dev)
> >  {
> >  	struct gpio_bank *bank;
> >
> > @@ -1163,7 +1211,7 @@ static int omap_gpio_suspend(void)
> >  	return 0;
> >  }
> >
> > -static void omap_gpio_resume(void)
> > +static int omap_gpio_resume(struct device *dev)
> >  {
> >  	struct gpio_bank *bank;
> >
> > @@ -1173,7 +1221,7 @@ static void omap_gpio_resume(void)
> >  		unsigned long flags;
> >
> >  		if (!bank->suspend_support)
> > -			return;
> > +			return 0;
> >
> >  		wake_clear = bank->base + bank->regs->wkup_clear;
> >  		wake_set = bank->base + bank->regs->wkup_set;
> > @@ -1183,12 +1231,18 @@ static void omap_gpio_resume(void)
> >  		__raw_writel(bank->saved_wakeup, wake_set);
> >  		spin_unlock_irqrestore(&bank->lock, flags);
> >  	}
> > +	return 0;
> >  }
> >
> > -static struct syscore_ops omap_gpio_syscore_ops = {
> > -	.suspend	= omap_gpio_suspend,
> > -	.resume		= omap_gpio_resume,
> > -};
> > +static int omap_gpio_pm_runtime_suspend(struct device *dev)
> 
> Please drop the 'pm_' in these function names.
OK.

> 
> > +{
> > +	return 0;
> > +}
> > +
> > +static int omap_gpio_pm_runtime_resume(struct device *dev)
> > +{
> > +	return 0;
> > +}
> 
> Actually,  empty functions should not even be added.  Just add them in
> the patch that uses them.
OK.
--
Tarun
> 
> Kevin

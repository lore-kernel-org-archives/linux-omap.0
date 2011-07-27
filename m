From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v4 REPOST 18/20] gpio/omap: use pm-runtime framework
Date: Wed, 27 Jul 2011 17:14:58 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037C202D59@dbde02.ent.ti.com>
References: <1310804152-9243-1-git-send-email-tarun.kanti@ti.com>
 <1310804152-9243-19-git-send-email-tarun.kanti@ti.com>
 <20110716190734.GB990@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45001 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099Ab1G0LpL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jul 2011 07:45:11 -0400
In-Reply-To: <20110716190734.GB990@google.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>

Todd,
[...]
> > +		/* Initialize the gpio bank registers to init time value */
> > +		omap_gpio_mod_init(bank);
> 
> omap_gpio_mod_init calls mpuio_init calls platform_driver_register
> which can't be called in an IRQs off and spinlocked atomic context,
> for example, device_private_init calls kzalloc with GFP_KERNEL.
> 
> Concurrency protection for this will need to happen prior to the
> spinlock (assuming it really does need to be an IRQ saving spinlock
> and not a mutex).   Possibly a new mutex is needed to protect the
> check for first usage and init'ing the bank (and blocking a racing
> second caller until the init is done).
I have isolated mpuio_init() from omap_gpio_mod_init().
mpuio_init() is now called once in omap_gpio_probe().

> 
> The omap_gpio_mod_init may be unbalanced with the code performed below
> on last free of a GPIO for the bank?  If all GPIOs are freed and then
> a new GPIO used, does omap_gpio_mod_init do the right thing?  Need a
> separate flag to indicate whether one-time init has ever been
> performed, vs. needing runtime PM enable/disable?
With the above changes I am seeing omap_gpio_mod_init() is balanced.
Let me know if I am still missing something.
--
Tarun
> 
> > +	}
> > +
> >  	/* Set trigger to none. You need to enable the desired trigger with
> >  	 * request_irq() or set_irq_type().
> >  	 */
> > @@ -517,7 +535,6 @@ static void omap_gpio_free(struct gpio_chip *chip,
> unsigned offset)
> >  	unsigned long flags;
> >
> >  	spin_lock_irqsave(&bank->lock, flags);
> > -
> >  	if (bank->regs->wkup_status)
> >  		/* Disable wake-up during idle for dynamic tick */
> >  		_gpio_rmw(base, bank->regs->wkup_status, 1 << offset, 0);
> > @@ -535,6 +552,18 @@ static void omap_gpio_free(struct gpio_chip *chip,
> unsigned offset)
> >  	}
> >
> >  	_reset_gpio(bank, bank->chip.base + offset);
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
> >  	spin_unlock_irqrestore(&bank->lock, flags);
> 
> 
> Todd

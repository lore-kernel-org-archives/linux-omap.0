From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v4 18/20] gpio/omap: use pm-runtime framework
Date: Thu, 14 Jul 2011 12:52:26 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037BFD2B50@dbde02.ent.ti.com>
References: <1310565259-31267-1-git-send-email-tarun.kanti@ti.com>
 <1310565259-31267-19-git-send-email-tarun.kanti@ti.com>
 <20110714060939.GB22467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38213 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab1GNHWl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jul 2011 03:22:41 -0400
In-Reply-To: <20110714060939.GB22467@google.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>

> -----Original Message-----
> From: Todd Poynor [mailto:toddpoynor@google.com]
> Sent: Thursday, July 14, 2011 11:40 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Hilman, Kevin; Shilimkar, Santosh;
> tony@atomide.com; linux-arm-kernel@lists.infradead.org; Varadarajan,
> Charulatha
> Subject: Re: [PATCH v4 18/20] gpio/omap: use pm-runtime framework
> 
> On Wed, Jul 13, 2011 at 07:24:17PM +0530, Tarun Kanti DebBarma wrote:
> > From: Charulatha V <charu@ti.com>
> >
> > Call runtime pm APIs pm_runtime_get_sync() and pm_runtime_put_sync()
> > for enabling/disabling clocks appropriately. Remove syscore_ops and
> > instead use dev_pm_ops now.
> >
> ...
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
> 
> Does the check for first gpio_request and omap_gpio_mod_init() call
> need concurrency protection, possibly moved under the spinlock?
I believe, with pm_runtime_irq_safe() already in place, we could move
them including *_get_sync() under spinlock.

> 
> >
> >  	/* Set trigger to none. You need to enable the desired trigger with
> > @@ -536,6 +554,18 @@ static void omap_gpio_free(struct gpio_chip *chip,
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
> 
> And need mutual exclusion here?
Yes.
I will verify and take action. Thanks.
--
Tarun
> 
> 
> Todd


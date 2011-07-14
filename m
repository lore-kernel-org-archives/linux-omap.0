From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH v4 18/20] gpio/omap: use pm-runtime framework
Date: Wed, 13 Jul 2011 23:09:39 -0700
Message-ID: <20110714060939.GB22467@google.com>
References: <1310565259-31267-1-git-send-email-tarun.kanti@ti.com>
 <1310565259-31267-19-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:25874 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab1GNGLS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jul 2011 02:11:18 -0400
Content-Disposition: inline
In-Reply-To: <1310565259-31267-19-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Wed, Jul 13, 2011 at 07:24:17PM +0530, Tarun Kanti DebBarma wrote:
> From: Charulatha V <charu@ti.com>
> 
> Call runtime pm APIs pm_runtime_get_sync() and pm_runtime_put_sync()
> for enabling/disabling clocks appropriately. Remove syscore_ops and
> instead use dev_pm_ops now.
> 
...
> +	/*
> +	 * If this is the first gpio_request for the bank,
> +	 * enable the bank module.
> +	 */
> +	if (!bank->mod_usage) {
> +		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
> +			dev_err(bank->dev, "%s: GPIO bank %d "
> +					"pm_runtime_get_sync failed\n",
> +					__func__, bank->id);
> +			return -EINVAL;
> +		}
> +
> +		/* Initialize the gpio bank registers to init time value */
> +		omap_gpio_mod_init(bank);
> +	}
> +
>  	spin_lock_irqsave(&bank->lock, flags);

Does the check for first gpio_request and omap_gpio_mod_init() call
need concurrency protection, possibly moved under the spinlock?

>  
>  	/* Set trigger to none. You need to enable the desired trigger with
> @@ -536,6 +554,18 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>  
>  	_reset_gpio(bank, bank->chip.base + offset);
>  	spin_unlock_irqrestore(&bank->lock, flags);
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

And need mutual exclusion here?


Todd


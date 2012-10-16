From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] twl4030: Fix chained irq handling on resume from suspend
Date: Tue, 16 Oct 2012 16:52:49 -0700
Message-ID: <87ipaam0tq.fsf@deeprootsystems.com>
References: <1350399575-13240-1-git-send-email-kalle.jokiniemi@jollamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39201 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab2JPXwh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 19:52:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so6421917pad.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Oct 2012 16:52:36 -0700 (PDT)
In-Reply-To: <1350399575-13240-1-git-send-email-kalle.jokiniemi@jollamobile.com>
	(Kalle Jokiniemi's message of "Tue, 16 Oct 2012 17:59:35 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>
Cc: tony@atomide.com, sameo@linux.intel.com, omaplinuxkernel@gmail.com, linux-i2c@vger.kernel.org, w.sang@pengutronix.de, linux-omap@vger.kernel.org, grygorii.strashko@ti.com, shubhrajyoti@ti.com, huzefank@ti.com, nm@ti.com

Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com> writes:

> The irqs are enabled one-by-one in pm core resume_noirq phase.
> This leads to situation where the twl4030 primary interrupt
> handler (PIH) is enabled before the chained secondary handlers
> (SIH). As the PIH cannot clear the pending interrupt, and
> SIHs have not been enabled yet, a flood of interrupts hangs
> the device.
>
> Fixed the issue by setting the SIH irqs with IRQF_EARLY_RESUME
> flags, so they get enabled before the PIH.
>
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>

Acked-by: Kevin Hilman <khilman@ti.com>

Thanks, I like this better than the I2C driver fix.  

Samuel, feel free to take this for v3.7

Kevin

> ---
>  drivers/mfd/twl4030-irq.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index ad733d7..cdd1173 100644
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -672,7 +672,8 @@ int twl4030_sih_setup(struct device *dev, int module, int irq_base)
>  	irq = sih_mod + twl4030_irq_base;
>  	irq_set_handler_data(irq, agent);
>  	agent->irq_name = kasprintf(GFP_KERNEL, "twl4030_%s", sih->name);
> -	status = request_threaded_irq(irq, NULL, handle_twl4030_sih, 0,
> +	status = request_threaded_irq(irq, NULL, handle_twl4030_sih,
> +				      IRQF_EARLY_RESUME,
>  				      agent->irq_name ?: sih->name, NULL);
>  
>  	dev_info(dev, "%s (irq %d) chaining IRQs %d..%d\n", sih->name,

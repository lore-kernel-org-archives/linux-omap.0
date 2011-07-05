From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 09/20] GPIO: OMAP: Use level/edge detect reg offsets
Date: Tue, 05 Jul 2011 16:51:39 -0700
Message-ID: <87d3hop9pw.fsf@ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
	<1309513634-20971-10-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:42229 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751750Ab1GEXvo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 19:51:44 -0400
Received: by iwn8 with SMTP id 8so6165740iwn.28
        for <linux-omap@vger.kernel.org>; Tue, 05 Jul 2011 16:51:43 -0700 (PDT)
In-Reply-To: <1309513634-20971-10-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Fri, 1 Jul 2011 15:17:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> By adding level and edge detection register offsets and then initializing them
> correctly according to OMAP versions during device registrations we can now remove
> lot of revision checks in these functions.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>

Found the bug causing GPIO IRQ triggering failures for Blaze and Zoom3
GPIO-based network IRQs...

> @@ -400,12 +394,12 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
>  	if (type & ~IRQ_TYPE_SENSE_MASK)
>  		return -EINVAL;
>  
> -	/* OMAP1 allows only only edge triggering */
> -	if (!cpu_class_is_omap2()
> -			&& (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
> +	bank = irq_data_get_irq_chip_data(d);
> +
> +	if (bank->regs->leveldetect0 && (type &
> +			(IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))

This check is not the same as the one it replaced.  This check should
be:

	if (!bank->regs->leveldetect0 &&
	    (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH)))
		return -EINVAL;

Note the formatting changes also for readability, but the bugfix is just
adding the '!' before regs->leveldetect0.

Kevin

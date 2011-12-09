From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv10 06/14] omap3: pm: use prcm chain handler
Date: Fri, 09 Dec 2011 15:23:13 -0800
Message-ID: <87hb19jpni.fsf@ti.com>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
	<1323440857-385-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39767 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751244Ab1LIXXR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 18:23:17 -0500
Received: by iakc1 with SMTP id c1so6616073iak.33
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 15:23:15 -0800 (PST)
In-Reply-To: <1323440857-385-7-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Fri, 9 Dec 2011 16:27:29 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com

Tero Kristo <t-kristo@ti.com> writes:

> PM interrupt handling is now done through the PRCM chain handler. The
> interrupt handling logic is also split in two parts, to serve IO and
> WKUP events separately. This allows us to handle IO chain events in a
> clean way.

Also, elaborate that this means this core event code should no longer
clear the IO events since they are now handled by their own handlers.

> Signed-off-by: Tero Kristo <t-kristo@ti.com>

[...]

> @@ -880,12 +848,20 @@ static int __init omap3_pm_init(void)
>  	 * supervised mode for powerdomains */
>  	prcm_setup_regs();
>  
> -	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
> -			  (irq_handler_t)prcm_interrupt_handler,
> -			  IRQF_DISABLED, "prcm", NULL);
> +	ret = request_irq(omap_prcm_event_to_irq("wkup"),
> +		_prcm_int_handle_wakeup, 0, "pm_wkup", NULL);
> +
> +	if (ret) {
> +		printk(KERN_ERR "Failed to request pm_wkup irq\n");
> +		goto err1;
> +	}
> +
> +	/* IO interrupt is shared with mux code */
> +	ret = request_irq(omap_prcm_event_to_irq("io"),
> +		_prcm_int_handle_io, IRQF_SHARED, "pm_io", omap3_pm_init);
> +

Why does the "hwmod_io" use IRQF_NO_SUSPEND and this one doesn't?

Kevin

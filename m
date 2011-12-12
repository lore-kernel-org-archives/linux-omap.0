From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv10 06/14] omap3: pm: use prcm chain handler
Date: Mon, 12 Dec 2011 11:55:43 +0200
Message-ID: <1323683743.31914.21.camel@sokoban>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
	 <1323440857-385-7-git-send-email-t-kristo@ti.com>  <87hb19jpni.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46589 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097Ab1LLJzr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 04:55:47 -0500
In-Reply-To: <87hb19jpni.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com

On Fri, 2011-12-09 at 15:23 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > PM interrupt handling is now done through the PRCM chain handler. The
> > interrupt handling logic is also split in two parts, to serve IO and
> > WKUP events separately. This allows us to handle IO chain events in a
> > clean way.
> 
> Also, elaborate that this means this core event code should no longer
> clear the IO events since they are now handled by their own handlers.

Okay.

> 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> [...]
> 
> > @@ -880,12 +848,20 @@ static int __init omap3_pm_init(void)
> >  	 * supervised mode for powerdomains */
> >  	prcm_setup_regs();
> >  
> > -	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
> > -			  (irq_handler_t)prcm_interrupt_handler,
> > -			  IRQF_DISABLED, "prcm", NULL);
> > +	ret = request_irq(omap_prcm_event_to_irq("wkup"),
> > +		_prcm_int_handle_wakeup, 0, "pm_wkup", NULL);
> > +
> > +	if (ret) {
> > +		printk(KERN_ERR "Failed to request pm_wkup irq\n");
> > +		goto err1;
> > +	}
> > +
> > +	/* IO interrupt is shared with mux code */
> > +	ret = request_irq(omap_prcm_event_to_irq("io"),
> > +		_prcm_int_handle_io, IRQF_SHARED, "pm_io", omap3_pm_init);
> > +
> 
> Why does the "hwmod_io" use IRQF_NO_SUSPEND and this one doesn't?

Hmm, good question. Must have been a remain from some old tweak, I'll
take a look at what the flags should actually be.

-Tero



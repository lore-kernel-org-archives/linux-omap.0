From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCHv5 01/11] OMAP: prcm: switch to a chained IRQ handler
 mechanism
Date: Fri, 15 Jul 2011 09:40:46 -0700
Message-ID: <20110715164046.GA16552@google.com>
References: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
 <1309861677-2769-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:23005 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650Ab1GOQlG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jul 2011 12:41:06 -0400
Content-Disposition: inline
In-Reply-To: <1309861677-2769-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Avinash.H.M" <avinashhm@ti.com>, Kevin Hilman <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, Felipe Balbi <balbi@ti.com>

On Tue, Jul 05, 2011 at 01:27:47PM +0300, Tero Kristo wrote:
> Introduce a chained interrupt handler mechanism for the PRCM
> interrupt, so that individual PRCM event can cleanly be handled by
> handlers in separate drivers. We do this by introducing PRCM event
> names, which are then matched to the particular PRCM interrupt bit
> depending on the specific OMAP SoC being used.
> 
> arch/arm/mach-omap2/prcm.c implements the chained interrupt mechanism
> itself, with individual PRCM events for OMAP3 and OMAP4 being
> described in arch/arm/mach-omap2/prcm3xxx.c and
> arch/arm/mach-omap2/prcm4xxx.c respectively. At initialization time,
> the set of PRCM events is filtered against the SoC on which we are
> running, keeping only the ones that are actually useful. All the logic
> is written to be generic with regard to OMAP3/OMAP4, even though OMAP3
> has single PRCM event registers and OMAP4 has two PRCM event
> registers.
> 
...
> +
> +	prcm_wkup_irq = omap_prcm_event_to_irq("wkup");
> +	prcm_io_irq = omap_prcm_event_to_irq("io");


Should check error return for both.

> +
> +	ret = request_irq(prcm_wkup_irq, _prcm_int_handle_wakeup,
> +			IRQF_NO_SUSPEND | IRQF_DISABLED, "prcm_wkup", NULL);
>  

...
> +	for (i = 0; i <= max_irq / 32; i++) {
> +		gc = irq_alloc_generic_chip("PRCM", 1,
> +			irq_setup->base_irq + i * 32, NULL, handle_level_irq);
> +

Should check NULL return for out of memory.

> +		ct = gc->chip_types;

...
> +	/* Copy setup from __initdata section */
> +	irq_setup = kmalloc(sizeof(struct omap_prcm_irq_setup), GFP_KERNEL);


Check NULL return.

> +	memcpy(irq_setup, setup, sizeof(struct omap_prcm_irq_setup));
> +
> +	irqs = kmalloc(sizeof(struct omap_prcm_irq) *
> +		setup->num_irqs, GFP_KERNEL);

Check NULL return.

> +	memcpy(irqs, setup->irqs, sizeof(struct omap_prcm_irq) *
> +		setup->num_irqs);


Todd

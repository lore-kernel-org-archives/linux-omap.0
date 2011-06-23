From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 1/6] omap: prcm: switch to a chained IRQ handler
 mechanism
Date: Thu, 23 Jun 2011 01:19:40 -0700
Message-ID: <20110623081940.GW23145@atomide.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
 <1308760934-9757-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:38164 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751486Ab1FWITo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 04:19:44 -0400
Content-Disposition: inline
In-Reply-To: <1308760934-9757-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Avinash.H.M" <avinashhm@ti.com>, Kevin Hilman <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

* Tero Kristo <t-kristo@ti.com> [110622 09:38]:
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

Nice, this makes things more generic. Some comments below.
 
> +int omap_prcm_irq_init(void)
> +{
> +	int i, j;
> +	struct omap_prcm_irq *unfiltered_irqs;
> +	unsigned unfiltered_irqs_nr;
> +
> +	if (cpu_is_omap34xx() || cpu_is_omap3630()) {
> +		unfiltered_irqs          = omap_prcm_3xxx_irqs;
> +		unfiltered_irqs_nr       = omap_prcm_3xxx_irqs_nr;
> +		omap_prcm_mask_event     = omap3_prcm_mask_event;
> +		omap_prcm_unmask_event   = omap3_prcm_unmask_event;
> +		omap_prcm_ack_event      = omap3_prcm_ack_event;
> +		omap_prcm_pending_events = omap3_prcm_pending_events;
> +		irq_set_chained_handler(INT_34XX_PRCM_MPU_IRQ,
> +					prcm_irq_handler);
> +	} else if (cpu_is_omap44xx()) {
> +		unfiltered_irqs          = omap_prcm_4xxx_irqs;
> +		unfiltered_irqs_nr       = omap_prcm_4xxx_irqs_nr;
> +		omap_prcm_mask_event     = omap4_prcm_mask_event;
> +		omap_prcm_unmask_event   = omap4_prcm_unmask_event;
> +		omap_prcm_ack_event      = omap4_prcm_ack_event;
> +		omap_prcm_pending_events = omap4_prcm_pending_events;
> +		irq_set_chained_handler(OMAP44XX_IRQ_PRCM, prcm_irq_handler);
> +	} else {
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i < unfiltered_irqs_nr; i++)
> +		if (omap_chip_is(unfiltered_irqs[i].omap_chip))
> +			omap_prcm_irqs_nr++;
> +
> +	omap_prcm_irqs = kmalloc(omap_prcm_irqs_nr *
> +				 sizeof(struct omap_prcm_irq),
> +				 GFP_KERNEL);
> +	if (!omap_prcm_irqs)
> +		return -ENOMEM;
> +
> +	for (i = 0, j = 0; i < unfiltered_irqs_nr; i++)
> +		if (omap_chip_is(unfiltered_irqs[i].omap_chip)) {
> +			memcpy(&omap_prcm_irqs[j], &unfiltered_irqs[i],
> +			       sizeof(struct omap_prcm_irq));
> +			j++;
> +		}
> +
> +	for (i = OMAP_PRCM_IRQ_BASE; i < OMAP_PRCM_IRQ_END; i++) {
> +		irq_set_chip(i, &prcm_irq_chip);
> +		irq_set_handler(i, handle_level_irq);
> +		set_irq_flags(i, IRQF_VALID);
> +	}
> +
> +	return 0;
> +}

Please make omap_prcm_irq_init generic so you pass it the configuration.
Otherwise you have to add more else if cpu_is_omap code for each new omap.
Then you can add just an arch_initcall for each new omap to call
omap_prcm_irq_init. This will also make it easier to add support for
initializing things from device tree for omap_prcm_irq_init.

> +/*
> + * Reverses memory allocated and other setups done by
> + * omap_prcm_irq_init().
> + */
> +void omap_prcm_irq_cleanup(void)
> +{
> +	int i;
> +
> +	for (i = OMAP_PRCM_IRQ_BASE; i < OMAP_PRCM_IRQ_END; i++) {
> +		irq_set_chip(i, NULL);
> +		irq_set_handler(i, NULL);
> +		set_irq_flags(i, 0);
> +	}
> +
> +	kfree(omap_prcm_irqs);
> +
> +	if (cpu_is_omap34xx() || cpu_is_omap3630()) {
> +		irq_set_chained_handler(INT_34XX_PRCM_MPU_IRQ, NULL);
> +	} else {
> +		irq_set_chained_handler(OMAP44XX_IRQ_PRCM, NULL);
> +	}
> +}

Please get rid of the cpu_is_omap tests here too so prcm.c is
generic for the new code added.

> +struct omap_prcm_irq  __initdata omap_prcm_3xxx_irqs[] = {
> +	OMAP_PRCM_IRQ("wkup",                  0,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("evgenon",               2,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("evgenoff",              3,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
...

Please note consider that this data will be coming from device
tree and will disappear from here. We won't be merging any new
data after v3.1 unless it comes from device tree. So this too
will need to be converted because we won't be able to add support
for new omaps otherwise.

Also, please Cc linux-arm-kernel too.

Regards,

Tony

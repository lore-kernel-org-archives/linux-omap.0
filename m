From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 2/6] PRCM: Add support for PAD wakeup interrupts
Date: Fri, 24 Jun 2011 14:21:00 -0700
Message-ID: <87fwmzylhf.fsf@ti.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
	<1308760934-9757-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:51042 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753951Ab1FXVVD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 17:21:03 -0400
Received: by mail-pz0-f48.google.com with SMTP id 10so2597493pzk.21
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 14:21:03 -0700 (PDT)
In-Reply-To: <1308760934-9757-3-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Wed, 22 Jun 2011 19:42:10 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> PRCM interrupt handler will now parse registered pads to see whether there
> is an active wakeup event. If this is the case, the corresponding interrupt
> will be triggered. This can be used for example with UART driver to register
> PAD wakeup event for the UART RX pin, and when this happens, UART interrupt
> will be triggered.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/prcm.c             |   50 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/prcm.h |    1 +
>  2 files changed, 51 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index 362c59c..cc92064 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -53,6 +53,15 @@ static struct omap_prcm_irq *omap_prcm_irqs;
>  /* Number of entries in omap_prcm_irqs */
>  static int omap_prcm_irqs_nr;
>  
> +/* PAD handlers list */
> +struct pad_def {
> +	u32 pad;
> +	unsigned int irq;
> +	struct list_head node;
> +};
> +
> +static LIST_HEAD(pad_handler_list);
> +
>  /* Pointers to either OMAP3 or OMAP4 specific functions */
>  static void (*omap_prcm_mask_event)(unsigned event);
>  static void (*omap_prcm_unmask_event)(unsigned event);
> @@ -84,6 +93,25 @@ static struct irq_chip prcm_irq_chip = {
>  	.irq_unmask	= prcm_irq_unmask,
>  };
>  
> +
> +/*
> + * Handler for PAD irqs, called from PRCM interrupt handler
> + */
> +static void omap_prcm_handle_pad_irqs(void)
> +{
> +	struct pad_def *def;
> +	u16 val = 0;

minor: insert blank line between variables and code

> +	list_for_each_entry(def, &pad_handler_list, node) {
> +		/* Read padconf value based on cpu type */
> +		if (cpu_is_omap34xx())
> +			val = omap_ctrl_readw(def->pad);

We need to avoid cpu_is_* checks in driver code.

What we'll need is another control-module API for reading a padconf, and
the SoC-specific implementation can be managed by the control module code.

> +		/* if pad wakeupevent is active, fire registered IRQ */
> +		if (val & OMAP3_PADCONF_WAKEUPEVENT0)

Does this need to be masked with the wakeup enable?  IOW, is it possible
to find an pad with a masked wakeup event?  Might be worth double
checking the TRM on that one, but masking with the enable would not hurt
here.

> +			generic_handle_irq(def->irq);

Nice, I wish I thought of that!  I was trying to figure out how to SW
trigger a hard IRQ, but this is much better and doesn't rely on any
hardware feature.   Sometimes the simplest solution is the best. :)

> +	}
> +}
> +
>  /*
>   * PRCM Interrupt Handler
>   *
> @@ -106,6 +134,9 @@ static void prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
>  	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  
> +	/* Handle PAD events first, we don't want to ack them before parse */
> +	omap_prcm_handle_pad_irqs();
> +

Handling here is fine, but it's not terribly clear on first read where
the events are eventually cleared.  

I see now that they are cleared upon entry into the idle path, but I
think it would help readability if they were cleared after this handler
runs.

>  	/*
>  	 * Loop until all pending irqs are handled, since
>  	 * generic_handle_irq(), called by prcm_irq_handle_virtirqs()
> @@ -153,6 +184,25 @@ int omap_prcm_event_to_irq(const char *name)
>  }
>  
>  /*
> + * Register interrupt handler for a given pad. When the PRCM interrupt
> + * handler detects wakeupevent on the corresponding pad, the IRQ will
> + * be triggered.

This comment needs a minor change: technically, it's not the IRQ that is
triggered but the ISR for that IRQ will be called.

The same change should be made in the changelog.

> + */
> +int omap_prcm_register_pad_irq(u32 pad, unsigned int irq)
> +{
> +	struct pad_def *def;
> +
> +	def = kmalloc(sizeof(struct pad_def), GFP_ATOMIC);
> +	if (!def)
> +		return -ENOMEM;
> +
> +	def->pad = pad;
> +	def->irq = irq;
> +	list_add(&def->node, &pad_handler_list);
> +	return 0;
> +}

This wants an unregister counterpart.

> +/*
>   * Prepare the array of PRCM events corresponding to the current SoC,
>   * and set-up the chained interrupt handler mechanism.
>   */
> diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
> index 5785555..789eb17 100644
> --- a/arch/arm/plat-omap/include/plat/prcm.h
> +++ b/arch/arm/plat-omap/include/plat/prcm.h
> @@ -72,6 +72,7 @@ void omap4_prcm_pending_events(unsigned long *pending);
>  int omap_prcm_event_to_irq(const char *name);
>  int omap_prcm_irq_init(void);
>  void omap_prcm_irq_cleanup(void);
> +int omap_prcm_register_pad_irq(u32 pad, unsigned int irq);
>  u32 omap_prcm_get_reset_sources(void);
>  int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
>  			 const char *name);

Kevin

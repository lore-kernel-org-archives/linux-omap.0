From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 1/6] omap: prcm: switch to a chained IRQ handler mechanism
Date: Wed, 22 Jun 2011 16:53:24 -0700
Message-ID: <87fwn1h18r.fsf@ti.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
	<1308760934-9757-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53878 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758184Ab1FVXx3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jun 2011 19:53:29 -0400
Received: by mail-pw0-f54.google.com with SMTP id 7so1550081pwi.27
        for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 16:53:28 -0700 (PDT)
In-Reply-To: <1308760934-9757-2-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Wed, 22 Jun 2011 19:42:09 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Avinash.H.M" <avinashhm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi Tero,

Tero Kristo <t-kristo@ti.com> writes:

> Introduce a chained interrupt handler mechanism for the PRCM
> interrupt, so that individual PRCM event can cleanly be handled by
> handlers in separate drivers. We do this by introducing PRCM event
> names, which are then matched to the particular PRCM interrupt bit
> depending on the specific OMAP SoC being used.

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
> The wakeup and I/O PRCM events are now handled as two separate
> interrupts, and their handler is registered with IRQF_NO_SUSPEND,
> otherwise the IRQ gets disabled during suspend, which prevents resume.
>
> Patch tested on OMAP4 blaze board, no testing done on OMAP3.

Is this still true?

> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Avinash.H.M <avinashhm@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>

Thanks for working on this.  So far, I've only had time for a cosmetic
review of this code.  I should have some more time later this week for a
more detailed review.

First some general comments:

This series introduces a few section mismatch warnings.  Please build
with CONFIG_DEBUG_SECTION_MISMATCH=y for details and fixup.

> ---
>  arch/arm/mach-omap2/Makefile           |    4 +
>  arch/arm/mach-omap2/pm34xx.c           |  104 ++++++------------
>  arch/arm/mach-omap2/prcm.c             |  187 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prcm3xxx.c         |  117 ++++++++++++++++++++
>  arch/arm/mach-omap2/prcm4xxx.c         |  146 +++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/irqs.h |    9 ++-
>  arch/arm/plat-omap/include/plat/prcm.h |   45 ++++++++
>  7 files changed, 541 insertions(+), 71 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/prcm3xxx.c
>  create mode 100644 arch/arm/mach-omap2/prcm4xxx.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 5024064..339d2d4 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -39,6 +39,10 @@ AFLAGS_sram242x.o			:=-Wa,-march=armv6
>  AFLAGS_sram243x.o			:=-Wa,-march=armv6
>  AFLAGS_sram34xx.o			:=-Wa,-march=armv7-a
>  
> +# PRCM
> +obj-$(CONFIG_ARCH_OMAP3)                += prcm3xxx.o
> +obj-$(CONFIG_ARCH_OMAP4)                += prcm4xxx.o
> +
>  # Pin multiplexing
>  obj-$(CONFIG_SOC_OMAP2420)		+= mux2420.o
>  obj-$(CONFIG_SOC_OMAP2430)		+= mux2430.o
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 96a7624..adab4d5 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -240,7 +240,7 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
>  	return c;
>  }
>  
> -static int _prcm_int_handle_wakeup(void)
> +static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
>  {
>  	int c;
>  
> @@ -252,64 +252,10 @@ static int _prcm_int_handle_wakeup(void)
>  		c += prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
>  	}
>  
> -	return c;
> -}
> -
> -/*
> - * PRCM Interrupt Handler
> - *
> - * The PRM_IRQSTATUS_MPU register indicates if there are any pending
> - * interrupts from the PRCM for the MPU. These bits must be cleared in
> - * order to clear the PRCM interrupt. The PRCM interrupt handler is
> - * implemented to simply clear the PRM_IRQSTATUS_MPU in order to clear
> - * the PRCM interrupt. Please note that bit 0 of the PRM_IRQSTATUS_MPU
> - * register indicates that a wake-up event is pending for the MPU and
> - * this bit can only be cleared if the all the wake-up events latched
> - * in the various PM_WKST_x registers have been cleared. The interrupt
> - * handler is implemented using a do-while loop so that if a wake-up
> - * event occurred during the processing of the prcm interrupt handler
> - * (setting a bit in the corresponding PM_WKST_x register and thus
> - * preventing us from clearing bit 0 of the PRM_IRQSTATUS_MPU register)
> - * this would be handled.
> - */
> -static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
> -{
> -	u32 irqenable_mpu, irqstatus_mpu;
> -	int c = 0;
> -
> -	irqenable_mpu = omap2_prm_read_mod_reg(OCP_MOD,
> -					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
> -	irqstatus_mpu = omap2_prm_read_mod_reg(OCP_MOD,
> -					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> -	irqstatus_mpu &= irqenable_mpu;
> -
> -	do {
> -		if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
> -				     OMAP3430_IO_ST_MASK)) {
> -			c = _prcm_int_handle_wakeup();
> -
> -			/*
> -			 * Is the MPU PRCM interrupt handler racing with the
> -			 * IVA2 PRCM interrupt handler ?
> -			 */
> -			WARN(c == 0, "prcm: WARNING: PRCM indicated MPU wakeup "
> -			     "but no wakeup sources are marked\n");
> -		} else {
> -			/* XXX we need to expand our PRCM interrupt handler */
> -			WARN(1, "prcm: WARNING: PRCM interrupt received, but "
> -			     "no code to handle it (%08x)\n", irqstatus_mpu);
> -		}
> -
> -		omap2_prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
> -					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> -
> -		irqstatus_mpu = omap2_prm_read_mod_reg(OCP_MOD,
> -					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> -		irqstatus_mpu &= irqenable_mpu;
> -
> -	} while (irqstatus_mpu);
> -
> -	return IRQ_HANDLED;
> +	if (c)
> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;
>  }
>  
>  /* Function to restore the table entry that was modified for enabling MMU */
> @@ -880,20 +826,32 @@ static int __init omap3_pm_init(void)
>  	/* XXX prcm_setup_regs needs to be before enabling hw
>  	 * supervised mode for powerdomains */
>  	prcm_setup_regs();
> +	ret = omap_prcm_irq_init();
> +	if (ret) {
> +		pr_err("omap_prcm_irq_init() failed with %d\n", ret);
> +		goto err_prcm_irq_init;
> +	}
> +
> +	ret = request_irq(omap_prcm_event_to_irq("wkup"),
> +			  _prcm_int_handle_wakeup,
> +			  IRQF_NO_SUSPEND, "prcm_wkup", NULL);

Do you need to register a handler for this if all the handler does is
'return IRQ_HANDLED'  ?

Since you're now clearing all the events in every idle path, this
doesn't seem to be necessary.

> +	if (ret) {
> +		pr_err("request_irq failed to register for PRCM wakeup\n");
> +		goto err_prcm_irq_wkup;
> +	}
>  
> -	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
> -			  (irq_handler_t)prcm_interrupt_handler,
> -			  IRQF_DISABLED, "prcm", NULL);
> +	ret = request_irq(omap_prcm_event_to_irq("io"),
> +			  _prcm_int_handle_wakeup,
> +			  IRQF_NO_SUSPEND, "prcm_io", NULL);

ditto

>  	if (ret) {
> -		printk(KERN_ERR "request_irq failed to register for 0x%x\n",
> -		       INT_34XX_PRCM_MPU_IRQ);
> -		goto err1;
> +		pr_err("request_irq failed to register for PRCM io\n");
> +		goto err_prcm_irq_io;
>  	}
>  
>  	ret = pwrdm_for_each(pwrdms_setup, NULL);
>  	if (ret) {
>  		printk(KERN_ERR "Failed to setup powerdomains\n");
> -		goto err2;
> +		goto err_pwrdms_setup;
>  	}
>  
>  	(void) clkdm_for_each(clkdms_setup, NULL);
> @@ -901,7 +859,7 @@ static int __init omap3_pm_init(void)
>  	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
>  	if (mpu_pwrdm == NULL) {
>  		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
> -		goto err2;
> +		goto err_pwrdms_setup;
>  	}
>  
>  	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
> @@ -950,14 +908,20 @@ static int __init omap3_pm_init(void)
>  	}
>  
>  	omap3_save_scratchpad_contents();
> -err1:
> +
>  	return ret;
> -err2:
> -	free_irq(INT_34XX_PRCM_MPU_IRQ, NULL);
> +
> + err_pwrdms_setup:
> +	free_irq(omap_prcm_event_to_irq("io"), NULL);
>  	list_for_each_entry_safe(pwrst, tmp, &pwrst_list, node) {
>  		list_del(&pwrst->node);
>  		kfree(pwrst);
>  	}
> + err_prcm_irq_io:
> +	free_irq(omap_prcm_event_to_irq("wkup"), NULL);
> + err_prcm_irq_wkup:
> +	omap_prcm_irq_cleanup();
> + err_prcm_irq_init:
>  	return ret;
>  }
>  
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index 6be1438..362c59c 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -23,6 +23,8 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <linux/slab.h>
>  
>  #include <mach/system.h>
>  #include <plat/common.h>
> @@ -45,6 +47,191 @@ void __iomem *cm2_base;
>  
>  #define MAX_MODULE_ENABLE_WAIT		100000
>  
> +/* Array of valid PRCM events for the current OMAP */
> +static struct omap_prcm_irq *omap_prcm_irqs;
> +
> +/* Number of entries in omap_prcm_irqs */
> +static int omap_prcm_irqs_nr;
> +
> +/* Pointers to either OMAP3 or OMAP4 specific functions */
> +static void (*omap_prcm_mask_event)(unsigned event);
> +static void (*omap_prcm_unmask_event)(unsigned event);
> +static void (*omap_prcm_ack_event)(unsigned event);
> +static void (*omap_prcm_pending_events)(unsigned long *pending);
> +
> +static void prcm_irq_ack(struct irq_data *data)
> +{
> +	unsigned int prcm_irq = data->irq - OMAP_PRCM_IRQ_BASE;
> +	omap_prcm_ack_event(prcm_irq);
> +}
> +
> +static void prcm_irq_mask(struct irq_data *data)
> +{
> +	unsigned int prcm_irq = data->irq - OMAP_PRCM_IRQ_BASE;
> +	omap_prcm_mask_event(prcm_irq);
> +}
> +
> +static void prcm_irq_unmask(struct irq_data *data)
> +{
> +	unsigned int prcm_irq = data->irq - OMAP_PRCM_IRQ_BASE;
> +	omap_prcm_unmask_event(prcm_irq);
> +}
> +
> +static struct irq_chip prcm_irq_chip = {
> +	.name		= "PRCM",
> +	.irq_ack	= prcm_irq_ack,
> +	.irq_mask	= prcm_irq_mask,
> +	.irq_unmask	= prcm_irq_unmask,
> +};

You can probably use the new generic IRQ chip framework to handle this
(c.f. kernel/irq/generic-chip.c and usage in mach-omap2/irq.c.)

> +/*
> + * PRCM Interrupt Handler
> + *
> + * The PRM_IRQSTATUS_MPU register indicates if there are any pending
> + * interrupts from the PRCM for the MPU. These bits must be cleared in
> + * order to clear the PRCM interrupt. The PRCM interrupt handler is
> + * implemented to simply clear the PRM_IRQSTATUS_MPU in order to clear
> + * the PRCM interrupt. Please note that bit 0 of the PRM_IRQSTATUS_MPU
> + * register indicates that a wake-up event is pending for the MPU and
> + * this bit can only be cleared if the all the wake-up events latched
> + * in the various PM_WKST_x registers have been cleared. The interrupt
> + * handler is implemented using a do-while loop so that if a wake-up
> + * event occurred during the processing of the prcm interrupt handler
> + * (setting a bit in the corresponding PM_WKST_x register and thus
> + * preventing us from clearing bit 0 of the PRM_IRQSTATUS_MPU register)
> + * this would be handled.
> + */
> +static void prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
> +{
> +	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	/*
> +	 * Loop until all pending irqs are handled, since
> +	 * generic_handle_irq(), called by prcm_irq_handle_virtirqs()
> +	 * can cause new irqs to come
> +	 */
> +	while (1) {
> +		unsigned int virtirq;
> +
> +		chip->irq_ack(&desc->irq_data);
> +
> +		memset(pending, 0, sizeof(pending));
> +		omap_prcm_pending_events(pending);
> +
> +		/* No bit set, then all IRQs are handled */
> +		if (find_first_bit(pending, OMAP_PRCM_NR_IRQS)
> +		    >= OMAP_PRCM_NR_IRQS) {
> +			chip->irq_unmask(&desc->irq_data);
> +			break;
> +		}
> +
> +		/*
> +		 * Loop on all currently pending irqs so that new irqs
> +		 * cannot starve previously pending irqs
> +		 */
> +		for_each_set_bit(virtirq, pending, OMAP_PRCM_NR_IRQS)
> +			generic_handle_irq(OMAP_PRCM_IRQ_BASE + virtirq);
> +
> +		chip->irq_unmask(&desc->irq_data);
> +	}
> +}
> +
> +/*
> + * Given a PRCM event name, returns the corresponding IRQ on which the
> + * handler should be registered.
> + */
> +int omap_prcm_event_to_irq(const char *name)
> +{
> +	int i;
> +
> +	for (i = 0; i < omap_prcm_irqs_nr; i++)
> +		if (!strcmp(omap_prcm_irqs[i].name, name))
> +			return OMAP_PRCM_IRQ_BASE + omap_prcm_irqs[i].offset;
> +
> +	return -ENOENT;
> +}
> +
> +/*
> + * Prepare the array of PRCM events corresponding to the current SoC,
> + * and set-up the chained interrupt handler mechanism.
> + */
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

Minor nit: rather than use cpu_is_* here,  some sort of struct of func
ptrs should be defined that is filled out by the prcm[34]xxx.c code and
registered with the common code.  

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
> +
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
> +
>  u32 omap_prcm_get_reset_sources(void)
>  {
>  	/* XXX This presumably needs modification for 34XX */
> diff --git a/arch/arm/mach-omap2/prcm3xxx.c b/arch/arm/mach-omap2/prcm3xxx.c
> new file mode 100644
> index 0000000..a57fe69
> --- /dev/null
> +++ b/arch/arm/mach-omap2/prcm3xxx.c
> @@ -0,0 +1,117 @@
> +/*
> + * linux/arch/arm/mach-omap2/prcm3xxx.c
> + *
> + * OMAP 3xxx Power Reset and Clock Management (PRCM) interrupt
> + * definitions
> + *
> + * Written by Thomas Petazzoni <t-petazzoni@ti.com>
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +
> +#include <plat/prcm.h>
> +
> +#include "prm-regbits-24xx.h"
> +
> +struct omap_prcm_irq  __initdata omap_prcm_3xxx_irqs[] = {
> +	OMAP_PRCM_IRQ("wkup",                  0,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("evgenon",               2,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("evgenoff",              3,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("transition",            4,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("core_dpll_recal",       5,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("periph_dpll_recal",     6,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("mpu_dpll_recal",        7,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("iva2_dpll_recal",       8,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("io",	            9,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vp1_oppchangedone",    10,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vp1_minvdd",           11,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vp1_maxvdd",           12,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vp1_nosmpsack",        13,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vp1_eqvalue",          14,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vp1_tranxdone",        15,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vp2_oppchangedone",    16,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vp2_minvdd",           17,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vp2_maxvdd",           18,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vp2_nosmpsack",        19,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vp2_eqvalue",          20,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vp2_tranxdone",        21,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vc_saerr",             22,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vc_raerr",             23,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vc_timeout_err",       24,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("snd_periph_recal",     25,
> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("abb_ldo_tranxdone",    26,
> +		      CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vc_vp1_ack",           27,
> +		      CHIP_GE_OMAP3630ES1_1),
> +	OMAP_PRCM_IRQ("vc_bypass_ack",        28,
> +		      CHIP_GE_OMAP3630ES1_1),
> +};
> +
> +unsigned int __initdata
> +omap_prcm_3xxx_irqs_nr = ARRAY_SIZE(omap_prcm_3xxx_irqs);
> +
> +void omap3_prcm_mask_event(unsigned event)
> +{
> +	unsigned int bit = BIT(event);
> +
> +	omap2_prm_rmw_mod_reg_bits(bit, 0, OCP_MOD,
> +				   OMAP3_PRM_IRQENABLE_MPU_OFFSET);
> +}
> +
> +void omap3_prcm_unmask_event(unsigned event)
> +{
> +	unsigned int bit = BIT(event);
> +
> +	omap2_prm_rmw_mod_reg_bits(0, bit, OCP_MOD,
> +				   OMAP3_PRM_IRQENABLE_MPU_OFFSET);
> +}
> +
> +void omap3_prcm_ack_event(unsigned event)
> +{
> +	unsigned int bit = BIT(event);
> +
> +	omap2_prm_write_mod_reg(bit, OCP_MOD,
> +				OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> +}
> +
> +void omap3_prcm_pending_events(unsigned long *events)
> +{
> +	u32 irqenable_mpu =
> +		omap2_prm_read_mod_reg(OCP_MOD,
> +				       OMAP3_PRM_IRQENABLE_MPU_OFFSET);
> +	u32 irqstatus_mpu =
> +		omap2_prm_read_mod_reg(OCP_MOD,
> +				       OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> +	events[0] = irqenable_mpu & irqstatus_mpu;
> +}
> diff --git a/arch/arm/mach-omap2/prcm4xxx.c b/arch/arm/mach-omap2/prcm4xxx.c
> new file mode 100644
> index 0000000..e70f267
> --- /dev/null
> +++ b/arch/arm/mach-omap2/prcm4xxx.c
> @@ -0,0 +1,146 @@
> +/*
> + * linux/arch/arm/mach-omap2/prcm4xxx.c

Minor: filenames are not needed in headers.  Files tend to move around
and these comments don't get updated.

> + * OMAP 4xxx Power Reset and Clock Management (PRCM) interrupt
> + * definitions
> + *
> + * Written by Thomas Petazzoni <t-petazzoni@ti.com>
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +
> +#include <plat/prcm.h>
> +
> +#include "prcm44xx.h"
> +#include "prm44xx.h"
> +
> +struct omap_prcm_irq __initdata omap_prcm_4xxx_irqs[] = {
> +	OMAP_PRCM_IRQ("dpll_core_recal",       0,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("dpll_mpu_recal",        1,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("dpll_iva_recal",        2,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("dpll_per_recal",        3,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("dpll_abe_recal",        4,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("dpll_usb_recal",        5,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("dpll_unipro_recal",     7,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("transition",            8,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("io",                    9,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vc_saerr",              11,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vc_raerr",              12,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vc_toerr",              13,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vc_bypassack",          14,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_core_oppchangedone", 16,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_core_minvdd",        17,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_core_maxvdd",        18,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_core_nosmpsack",     19,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_core_eqvalue",       20,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_core_tranxdone",     21,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_iva_oppchangedone",  24,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_iva_minvdd",         25,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_iva_maxvdd",         26,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_iva_nosmpsack",      27,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_iva_eqvalue",        28,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_iva_tranxdone",      29,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_iva_vpack",          30,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("abb_iva_done",          31,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_mpu_oppchangedone",  32,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_mpu_minvdd",         33,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_mpu_maxvdd",         34,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_mpu_nosmpsack",      35,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_mpu_eqvalue",        36,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_mpu_tranxdone",      37,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("vp_mpu_vpack",          38,
> +		      CHIP_IS_OMAP4430),
> +	OMAP_PRCM_IRQ("abb_mpu_done",          39,
> +		      CHIP_IS_OMAP4430),
> +};
> +
> +unsigned int __initdata
> +omap_prcm_4xxx_irqs_nr = ARRAY_SIZE(omap_prcm_4xxx_irqs);
> +
> +void omap4_prcm_mask_event(unsigned event)
> +{
> +	unsigned int bit = BIT(event % 32);
> +	unsigned int off = (event / 32) * 4;
> +
> +	omap4_prm_rmw_inst_reg_bits(bit, 0,
> +				    OMAP4430_PRM_OCP_SOCKET_INST,
> +				    OMAP4_PRM_IRQENABLE_MPU_OFFSET + off);
> +}
> +
> +void omap4_prcm_unmask_event(unsigned event)
> +{
> +	unsigned int bit = BIT(event % 32);
> +	unsigned int off = (event / 32) * 4;
> +
> +	omap4_prm_rmw_inst_reg_bits(0, bit,
> +				    OMAP4430_PRM_OCP_SOCKET_INST,
> +				    OMAP4_PRM_IRQENABLE_MPU_OFFSET + off);
> +}
> +
> +void omap4_prcm_ack_event(unsigned event)
> +{
> +	unsigned int bit = BIT(event % 32);
> +	unsigned int off = (event / 32) * 4;
> +
> +	omap4_prm_write_inst_reg(bit,
> +				 OMAP4430_PRM_OCP_SOCKET_INST,
> +				 OMAP4_PRM_IRQSTATUS_MPU_OFFSET + off);
> +}
> +
> +void omap4_prcm_pending_events(unsigned long *events)
> +{
> +	u32 irqenable_mpu, irqstatus_mpu;
> +	int i;
> +
> +	/* OMAP4 has two enable/status registers for the PRCM */
> +	for (i = 0; i < 2; i++) {
> +		irqenable_mpu =
> +			omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
> +						OMAP4_PRM_IRQENABLE_MPU_OFFSET
> +						+ i * 4);
> +		irqstatus_mpu =
> +			omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
> +						OMAP4_PRM_IRQSTATUS_MPU_OFFSET
> +						+ i * 4);
> +		events[i] = irqenable_mpu & irqstatus_mpu;
> +	}
> +}
> diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
> index 5a25098..23b9680 100644
> --- a/arch/arm/plat-omap/include/plat/irqs.h
> +++ b/arch/arm/plat-omap/include/plat/irqs.h
> @@ -366,7 +366,14 @@
>  #define OMAP_MAX_GPIO_LINES	192
>  #define IH_GPIO_BASE		(128 + IH2_BASE)
>  #define IH_MPUIO_BASE		(OMAP_MAX_GPIO_LINES + IH_GPIO_BASE)
> -#define OMAP_IRQ_END		(IH_MPUIO_BASE + 16)
> +#define OMAP_MPUIO_IRQ_END	(IH_MPUIO_BASE + 16)
> +
> +/* 64 IRQs for the PRCM (32 are needed on OMAP3, 64 on OMAP4) */
> +#define OMAP_PRCM_IRQ_BASE      (OMAP_MPUIO_IRQ_END)
> +#define OMAP_PRCM_NR_IRQS       64
> +#define OMAP_PRCM_IRQ_END       (OMAP_PRCM_IRQ_BASE + OMAP_PRCM_NR_IRQS)
> +
> +#define OMAP_IRQ_END            (OMAP_PRCM_IRQ_END)
>  
>  /* External FPGA handles interrupts on Innovator boards */
>  #define	OMAP_FPGA_IRQ_BASE	(OMAP_IRQ_END)
> diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
> index 267f43b..5785555 100644
> --- a/arch/arm/plat-omap/include/plat/prcm.h
> +++ b/arch/arm/plat-omap/include/plat/prcm.h
> @@ -27,6 +27,51 @@
>  #ifndef __ASM_ARM_ARCH_OMAP_PRCM_H
>  #define __ASM_ARM_ARCH_OMAP_PRCM_H
>  
> +#include <plat/cpu.h>
> +
> +/*
> + * Structure describing the interrupt corresponding to each PRCM event
> + */
> +struct omap_prcm_irq {
> +	/* Logical name for the interrupt */
> +	const char *name;
> +
> +	/*
> +	 * Corresponding offset in the status/enable register. The
> +	 * offset can be greater than 32, in which case it spans over
> +	 * the second status register
> +	 */
> +	unsigned int offset;
> +
> +	/* OMAP chip for which this PRCM event exists */
> +	const struct omap_chip_id omap_chip;
> +};
> +
> +#define OMAP_PRCM_IRQ(_name, _offset, _chip)   \
> +	{ .name = _name,                       \
> +	  .offset = _offset,                   \
> +	  .omap_chip = OMAP_CHIP_INIT(_chip) }
> +
> +/* Maximum number of PRCM interrupt status registers */
> +#define OMAP_PRCM_MAX_NR_PENDING_REG 2
> +
> +extern struct omap_prcm_irq omap_prcm_3xxx_irqs[];
> +extern unsigned int omap_prcm_3xxx_irqs_nr;
> +void omap3_prcm_mask_event(unsigned event);
> +void omap3_prcm_unmask_event(unsigned event);
> +void omap3_prcm_ack_event(unsigned event);
> +void omap3_prcm_pending_events(unsigned long *pending);
> +
> +extern struct omap_prcm_irq omap_prcm_4xxx_irqs[];
> +extern unsigned int omap_prcm_4xxx_irqs_nr;
> +void omap4_prcm_mask_event(unsigned event);
> +void omap4_prcm_unmask_event(unsigned event);
> +void omap4_prcm_ack_event(unsigned event);
> +void omap4_prcm_pending_events(unsigned long *pending);

Defining a struct of func ptrs and filling it out in the prcm[34]xxx.c
file would also mean you wouldn't need all the omap3_ and omap4_
functions in the header.

> +int omap_prcm_event_to_irq(const char *name);
> +int omap_prcm_irq_init(void);
> +void omap_prcm_irq_cleanup(void);
>  u32 omap_prcm_get_reset_sources(void);
>  int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
>  			 const char *name);

Kevin

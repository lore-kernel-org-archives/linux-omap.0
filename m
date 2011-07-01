From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 1/9] omap: prcm: switch to a chained IRQ handler mechanism
Date: Fri, 01 Jul 2011 14:58:29 -0700
Message-ID: <87ei29u0hm.fsf@ti.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
	<1309338303-2086-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:53275 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757769Ab1GAV6e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 17:58:34 -0400
Received: by mail-pz0-f49.google.com with SMTP id 28so3722362pzk.8
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 14:58:33 -0700 (PDT)
In-Reply-To: <1309338303-2086-2-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Wed, 29 Jun 2011 12:04:55 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Avinash.H.M" <avinashhm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

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
> Patch tested on OMAP3 beagleboard.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Avinash.H.M <avinashhm@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile           |    4 +
>  arch/arm/mach-omap2/pm34xx.c           |  116 ++++++++--------------
>  arch/arm/mach-omap2/prcm.c             |  163 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prcm3xxx.c         |  141 ++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prcm4xxx.c         |  170 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/irqs.h |    9 ++-
>  arch/arm/plat-omap/include/plat/prcm.h |   43 ++++++++
>  7 files changed, 569 insertions(+), 77 deletions(-)
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
> index 96a7624..89cf027 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -64,6 +64,9 @@ static inline bool is_suspending(void)
>  }
>  #endif
>  
> +static int prcm_io_irq;
> +static int prcm_wkup_irq;
> +
>  /* Scratchpad offsets */
>  #define OMAP343X_TABLE_ADDRESS_OFFSET	   0xc4
>  #define OMAP343X_TABLE_VALUE_OFFSET	   0xc0
> @@ -240,75 +243,16 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
>  	return c;
>  }
>  
> -static int _prcm_int_handle_wakeup(void)
> +static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
>  {
> -	int c;
> -
> -	c = prcm_clear_mod_irqs(WKUP_MOD, 1);
> -	c += prcm_clear_mod_irqs(CORE_MOD, 1);
> -	c += prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1);
> +	prcm_clear_mod_irqs(WKUP_MOD, 1);
> +	prcm_clear_mod_irqs(CORE_MOD, 1);
> +	prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1);
>  	if (omap_rev() > OMAP3430_REV_ES1_0) {
> -		c += prcm_clear_mod_irqs(CORE_MOD, 3);
> -		c += prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
> +		prcm_clear_mod_irqs(CORE_MOD, 3);
> +		prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
>  	}

Maybe we should keep the various 'c += ' counting in there, and only
return IRQ_HANDLED if (c > 0) ?

> -	return c;
> -}

[...]

> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index 6be1438..794e451 100644
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
> @@ -45,6 +47,167 @@ void __iomem *cm2_base;
>  
>  #define MAX_MODULE_ENABLE_WAIT		100000
>  
> +/* Setup for the interrupt handling based on used platform */
> +static struct omap_prcm_irq_setup *irq_setup;
> +
> +static void prcm_irq_ack(struct irq_data *data)
> +{
> +	unsigned int prcm_irq = data->irq - OMAP_PRCM_IRQ_BASE;
> +	irq_setup->ack_event(prcm_irq);
> +}
> +
> +static void prcm_irq_mask(struct irq_data *data)
> +{
> +	unsigned int prcm_irq = data->irq - OMAP_PRCM_IRQ_BASE;
> +	irq_setup->mask_event(prcm_irq);
> +}
> +
> +static void prcm_irq_unmask(struct irq_data *data)
> +{
> +	unsigned int prcm_irq = data->irq - OMAP_PRCM_IRQ_BASE;
> +	irq_setup->unmask_event(prcm_irq);
> +}

In moving to generic IRQ chip, it's all of the ack/mask/unmask functions
here that I want to get rid of, since the generic IRQ chip layer can do
all of this for you.

Instead, we can just pass in the register address(es) to the generic IRQ
chip, and use the generic irq_chip ack/mask/unmask functions.  This is
how the INTC code does it.

So, rather than have ack/mask/umask function in the prcm[34]xxx.c files,
and in prcm.c file, you can remove them all.  Instead, in the
prcm[34]xxxx files, just define the ack and mask registers (e.g. for OMAP3):

 static struct omap_prcm_irq_setup __initdata omap3_prcm_irq_setup = {
-	.mask_event = omap3_prcm_mask_event,
-	.unmask_event = omap3_prcm_unmask_event,
-	.ack_event = omap3_prcm_ack_event,
+	.ack = OMAP34XX_PRM_REGADDR(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET),
+	.mask = OMAP34XX_PRM_REGADDR(OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFSET),
 	.pending_events = omap3_prcm_pending_events,
 	.irqs = omap_prcm_3xxx_irqs,
 	.num_irqs = ARRAY_SIZE(omap_prcm_3xxx_irqs),
 	.irq = INT_34XX_PRCM_MPU_IRQ,
 };

then...

> +/*
> + * Prepare the array of PRCM events corresponding to the current SoC,
> + * and set-up the chained interrupt handler mechanism.
> + */
> +int __init omap_prcm_irq_init(void)
> +{
> +	int i;
> +	struct irq_chip_generic *gc;
> +	struct irq_chip_type *ct;
> +	u32 mask[2] = { 0, 0 };
> +	int offset;
> +	int max_irq = 0;
> +
> +	for (i = 0; i < irq_setup->num_irqs; i++)
> +		if (omap_chip_is(irq_setup->irqs[i].omap_chip)) {
> +			offset = irq_setup->irqs[i].offset;
> +			if (offset < 32)
> +				mask[0] |= 1 << offset;
> +			else
> +				mask[1] |= 1 << (offset - 32);
> +			if (offset > max_irq)
> +				max_irq = offset;
> +		}
> +
> +	irq_set_chained_handler(irq_setup->irq, prcm_irq_handler);
> +
> +	for (i = 0; i <= max_irq / 32; i++) {
> +		gc = irq_alloc_generic_chip("PRCM", 1,
> +			OMAP_PRCM_IRQ_BASE + i * 32, NULL, handle_level_irq);
> +
> +		ct = gc->chip_types;
> +		ct->chip.irq_ack = prcm_irq_ack;
> +		ct->chip.irq_mask = prcm_irq_mask;
> +		ct->chip.irq_unmask = prcm_irq_unmask;

...use the generic IRQ functions

		ct->chip.irq_ack = irq_gc_ack;
		ct->chip.irq_mask = irq_gc_mask_set_bit;
		ct->chip.irq_unmask = irq_gc_mask_clr_bit;

and pass in the register offsets configured in the SoC-specific code:

		ct->regs.ack = irq_setup->ack + (i << 2);
		ct->regs.mask = irq_setup->mask + (i << 2);

> +		irq_setup_generic_chip(gc, mask[i], 0, IRQ_NOREQUEST, 0);
> +		prcm_irq_chips[i] = gc;
> +	}
> +	return 0;
> +}
> +


[...]

> diff --git a/arch/arm/mach-omap2/prcm3xxx.c b/arch/arm/mach-omap2/prcm3xxx.c
> new file mode 100644
> index 0000000..5671650
> --- /dev/null
> +++ b/arch/arm/mach-omap2/prcm3xxx.c
> @@ -0,0 +1,141 @@
> +/*
> + * linux/arch/arm/mach-omap2/prcm3xxx.c

Minor: please remove the filename from the header.  Files move around
and these comments never get updated.

Also, I know you inherited this from previous code, but we probably
don't need new prcm*.c files.  All this IRQ stuff is part of the PRM
(not CM) and belongs in prm2xxx_3xxx.c and prm4xxx.c.

Kevin

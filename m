From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv6 01/11] omap: prcm: switch to a chained IRQ handler mechanism
Date: Tue, 26 Jul 2011 13:33:35 +0300
Message-ID: <1311676415.5826.30.camel@sokoban>
References: <1311611771-15093-1-git-send-email-t-kristo@ti.com> <1311611771-15093-2-git-send-email-t-kristo@ti.com> <20110725170300.GG18062@legolas.emea.dhcp.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48232 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848Ab1GZKds convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jul 2011 06:33:48 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110725170300.GG18062@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Mahadeva, Avinash" <avinashhm@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "R, Govindraj" <govindraj.raja@ti.com>, Paul Walmsley <paul@pwsan.com>, Thomas Gleixner <tglx@linutronix.de>

On Mon, 2011-07-25 at 19:03 +0200, Balbi, Felipe wrote:
> Hi,
> 
> On Mon, Jul 25, 2011 at 07:36:01PM +0300, Tero Kristo wrote:
> > Introduce a chained interrupt handler mechanism for the PRCM
> > interrupt, so that individual PRCM event can cleanly be handled by
> > handlers in separate drivers. We do this by introducing PRCM event
> 
> which drivers ? Are those somehow "children" of the "PRCM device" ??
> If that's the case, you shouldn't need to match against names as you
> could allocate a platform_device for your children and pass in your
> resources with correct IRQ numbers.

I am not quite sure what you mean by children in this case. There are a
couple of devices that might be interested in using these, e.g. SR and
ABB come to my mind. They are closely related to PRCM yes.

> 
> > names, which are then matched to the particular PRCM interrupt bit
> > depending on the specific OMAP SoC being used.
> > 
> > arch/arm/mach-omap2/prcm.c implements the chained interrupt mechanism
> > itself, with SoC specific support / init structure defined in
> > arch/arm/mach-omap2/prm2xxx_3xxx.c and arch/arm/mach-omap2/prm4xxx.c
> > respectively. At initialization time, the set of PRCM events is filtered
> > against the SoC on which we are running, keeping only the ones that are
> > actually useful. All the logic is written to be generic with regard to
> > OMAP3/OMAP4, even though OMAP3 has single PRCM event registers and OMAP4
> > has two PRCM event registers.
> 
> Then if OMAP5 has 3, OMAP6 4 and OMAP7 5, OMAP3 will also have an array
> of 5 PRCM events even though it only needs one, another argument for
> dynamic allocation ?
> 
> > ---
> 
> [snip]
> 
> > @@ -246,64 +249,7 @@ static int _prcm_int_handle_wakeup(void)
> >  		c += prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
> >  	}
> >  
> > -	return c;
> > -}
> > -
> > -/*
> > - * PRCM Interrupt Handler
> > - *
> > - * The PRM_IRQSTATUS_MPU register indicates if there are any pending
> > - * interrupts from the PRCM for the MPU. These bits must be cleared in
> > - * order to clear the PRCM interrupt. The PRCM interrupt handler is
> > - * implemented to simply clear the PRM_IRQSTATUS_MPU in order to clear
> > - * the PRCM interrupt. Please note that bit 0 of the PRM_IRQSTATUS_MPU
> > - * register indicates that a wake-up event is pending for the MPU and
> > - * this bit can only be cleared if the all the wake-up events latched
> > - * in the various PM_WKST_x registers have been cleared. The interrupt
> > - * handler is implemented using a do-while loop so that if a wake-up
> > - * event occurred during the processing of the prcm interrupt handler
> > - * (setting a bit in the corresponding PM_WKST_x register and thus
> > - * preventing us from clearing bit 0 of the PRM_IRQSTATUS_MPU register)
> > - * this would be handled.
> > - */
> > -static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
> > -{
> > -	u32 irqenable_mpu, irqstatus_mpu;
> > -	int c = 0;
> > -
> > -	irqenable_mpu = omap2_prm_read_mod_reg(OCP_MOD,
> > -					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
> > -	irqstatus_mpu = omap2_prm_read_mod_reg(OCP_MOD,
> > -					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> > -	irqstatus_mpu &= irqenable_mpu;
> > -
> > -	do {
> > -		if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
> > -				     OMAP3430_IO_ST_MASK)) {
> > -			c = _prcm_int_handle_wakeup();
> > -
> > -			/*
> > -			 * Is the MPU PRCM interrupt handler racing with the
> > -			 * IVA2 PRCM interrupt handler ?
> > -			 */
> > -			WARN(c == 0, "prcm: WARNING: PRCM indicated MPU wakeup "
> > -			     "but no wakeup sources are marked\n");
> > -		} else {
> > -			/* XXX we need to expand our PRCM interrupt handler */
> > -			WARN(1, "prcm: WARNING: PRCM interrupt received, but "
> > -			     "no code to handle it (%08x)\n", irqstatus_mpu);
> > -		}
> > -
> > -		omap2_prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
> > -					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> > -
> > -		irqstatus_mpu = omap2_prm_read_mod_reg(OCP_MOD,
> > -					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> > -		irqstatus_mpu &= irqenable_mpu;
> > -
> > -	} while (irqstatus_mpu);
> > -
> > -	return IRQ_HANDLED;
> > +	return c ? IRQ_HANDLED : IRQ_NONE;
> >  }
> >  
> >  static void omap34xx_save_context(u32 *save)
> > @@ -875,20 +821,35 @@ static int __init omap3_pm_init(void)
> >  	/* XXX prcm_setup_regs needs to be before enabling hw
> >  	 * supervised mode for powerdomains */
> >  	prcm_setup_regs();
> > +	ret = omap3_prcm_irq_init();
> > +	if (ret) {
> > +		pr_err("omap_prcm_irq_init() failed with %d\n", ret);
> > +		goto err_prcm_irq_init;
> > +	}
> > +
> > +	prcm_wkup_irq = omap_prcm_event_to_irq("wkup");
> > +	prcm_io_irq = omap_prcm_event_to_irq("io");
> > +
> > +	ret = request_irq(prcm_wkup_irq, _prcm_int_handle_wakeup,
> > +			IRQF_NO_SUSPEND, "prcm_wkup", NULL);
> >  
> > -	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
> > -			  (irq_handler_t)prcm_interrupt_handler,
> > -			  IRQF_DISABLED, "prcm", NULL);
> >  	if (ret) {
> > -		printk(KERN_ERR "request_irq failed to register for 0x%x\n",
> > -		       INT_34XX_PRCM_MPU_IRQ);
> > -		goto err1;
> > +		printk(KERN_ERR "Failed to request prcm_wkup irq\n");
> > +		goto err_prcm_wkup;
> > +	}
> > +
> > +	ret = request_irq(prcm_io_irq, _prcm_int_handle_wakeup,
> > +			IRQF_NO_SUSPEND, "prcm_io", NULL);
> > +
> > +	if (ret) {
> > +		printk(KERN_ERR "Failed to request prcm_io irq\n");
> > +		goto err_prcm_io;
> >  	}
> >  
> >  	ret = pwrdm_for_each(pwrdms_setup, NULL);
> >  	if (ret) {
> >  		printk(KERN_ERR "Failed to setup powerdomains\n");
> > -		goto err2;
> > +		goto err_pwrdms_setup;
> >  	}
> >  
> >  	(void) clkdm_for_each(clkdms_setup, NULL);
> > @@ -896,7 +857,7 @@ static int __init omap3_pm_init(void)
> >  	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
> >  	if (mpu_pwrdm == NULL) {
> >  		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
> > -		goto err2;
> > +		goto err_pwrdms_setup;
> >  	}
> >  
> >  	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
> > @@ -944,14 +905,19 @@ static int __init omap3_pm_init(void)
> >  	}
> >  
> >  	omap3_save_scratchpad_contents();
> > -err1:
> > +
> >  	return ret;
> > -err2:
> > -	free_irq(INT_34XX_PRCM_MPU_IRQ, NULL);
> > +
> > + err_pwrdms_setup:
> >  	list_for_each_entry_safe(pwrst, tmp, &pwrst_list, node) {
> >  		list_del(&pwrst->node);
> >  		kfree(pwrst);
> >  	}
> > + err_prcm_io:
> > +	free_irq(prcm_wkup_irq, NULL);
> > + err_prcm_wkup:
> > +	omap_prcm_irq_cleanup();
> > + err_prcm_irq_init:
> >  	return ret;
> >  }
> >  
> > diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> > index 2e40a5c..83cf8ae 100644
> > --- a/arch/arm/mach-omap2/prcm.c
> > +++ b/arch/arm/mach-omap2/prcm.c
> > @@ -45,6 +47,209 @@ void __iomem *cm2_base;
> >  
> >  #define MAX_MODULE_ENABLE_WAIT		100000
> >  
> > +/* Maximum number of PRCM interrupt status registers */
> > +#define OMAP_PRCM_MAX_NR_PENDING_REG	2
> > +
> > +/* 64 interrupts needed on OMAP4, 32 on OMAP3 */
> > +#define OMAP_PRCM_NR_IRQS		64
> > +
> > +/* Setup for the interrupt handling based on used platform */
> > +static struct omap_prcm_irq_setup *irq_setup;
> > +
> > +static struct irq_chip_generic *prcm_irq_chips[OMAP_PRCM_MAX_NR_PENDING_REG];
> 
> I still think this would be better dynamically allocated. If this
> happens to increase in OMAP6/7/8... noone will convert to dynamic
> allocation, rather will only increase the macro above.

It might increase to 3 at some point, there is lots of space in the
second register at the moment. :) And I still stand behind my reasoning
that allocating this dynamically would eat more memory.

> 
> > +/*
> > + * PRCM Interrupt Handler
> > + *
> > + * The PRM_IRQSTATUS_MPU register indicates if there are any pending
> > + * interrupts from the PRCM for the MPU. These bits must be cleared in
> > + * order to clear the PRCM interrupt. The PRCM interrupt handler is
> > + * implemented to simply clear the PRM_IRQSTATUS_MPU in order to clear
> > + * the PRCM interrupt. Please note that bit 0 of the PRM_IRQSTATUS_MPU
> > + * register indicates that a wake-up event is pending for the MPU and
> > + * this bit can only be cleared if the all the wake-up events latched
> > + * in the various PM_WKST_x registers have been cleared. The interrupt
> > + * handler is implemented using a do-while loop so that if a wake-up
> > + * event occurred during the processing of the prcm interrupt handler
> > + * (setting a bit in the corresponding PM_WKST_x register and thus
> > + * preventing us from clearing bit 0 of the PRM_IRQSTATUS_MPU register)
> > + * this would be handled.
> > + */
> > +static void prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
> > +{
> > +	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +
> > +	/*
> > +	 * Loop until all pending irqs are handled, since
> > +	 * generic_handle_irq() can cause new irqs to come
> > +	 */
> > +	while (1) {
> > +		unsigned int virtirq;
> > +
> > +		chip->irq_ack(&desc->irq_data);
> > +
> > +		memset(pending, 0, sizeof(pending));
> > +		irq_setup->pending_events(pending);
> > +
> > +		/* No bit set, then all IRQs are handled */
> > +		if (find_first_bit(pending, OMAP_PRCM_NR_IRQS)
> > +		    >= OMAP_PRCM_NR_IRQS) {
> > +			chip->irq_unmask(&desc->irq_data);
> > +			break;
> > +		}
> > +
> > +		/*
> > +		 * Loop on all currently pending irqs so that new irqs
> > +		 * cannot starve previously pending irqs
> > +		 */
> > +		for_each_set_bit(virtirq, pending, OMAP_PRCM_NR_IRQS)
> > +			generic_handle_irq(irq_setup->base_irq + virtirq);
> > +
> > +		chip->irq_unmask(&desc->irq_data);
> 
> can't the IRQ subsystem handle this for you ? I was expecting it would
> call irq_ack() and irq_unmask() automatically and you wouldn't have to
> do it yourself. Maybe Thomas can clear this out ? Thomas, should we call
> ->irq_ack() ->irq_mask ourselves here ?

These are needed, as we are using a handle and a level interrupt. If you
leave out the ack, we will return to the handler immediately as nobody
else acks it. If you leave out the unmask, we will only ever get 1
interrupt and no more.

> 
> > +/*
> > + * Given a PRCM event name, returns the corresponding IRQ on which the
> > + * handler should be registered.
> > + */
> > +int omap_prcm_event_to_irq(const char *name)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(omap_prcm_irqs); i++)
> > +		if (!strcmp(omap_prcm_irqs[i].name, name))
> > +			return irq_setup->base_irq + omap_prcm_irqs[i].offset;
> > +
> > +	return -ENOENT;
> > +}
> > +
> > +/*
> > + * Reverses memory allocated and other setups done by
> > + * omap_prcm_irq_init().
> > + */
> > +void omap_prcm_irq_cleanup(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < OMAP_PRCM_MAX_NR_PENDING_REG; i++) {
> > +		if (prcm_irq_chips[i])
> > +			irq_remove_generic_chip(prcm_irq_chips[i], 0xffffffff,
> > +						0, 0);
> > +		prcm_irq_chips[i] = NULL;
> > +	}
> > +
> > +	irq_set_chained_handler(irq_setup->irq, NULL);
> > +
> > +	if (irq_setup->base_irq > 0)
> > +		irq_free_descs(irq_setup->base_irq, OMAP_PRCM_NR_IRQS);
> > +	irq_setup->base_irq = 0;
> > +}
> > +
> > +/*
> > + * Prepare the array of PRCM events corresponding to the current SoC,
> > + * and set-up the chained interrupt handler mechanism.
> > + */
> > +static int __init omap_prcm_irq_init(void)
> > +{
> > +	int i;
> > +	struct irq_chip_generic *gc;
> > +	struct irq_chip_type *ct;
> > +	u32 mask[2] = { 0, 0 };
> > +	int offset;
> > +	int max_irq = 0;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(omap_prcm_irqs); i++)
> > +		if (omap_chip_is(omap_prcm_irqs[i].omap_chip)) {
> > +			offset = omap_prcm_irqs[i].offset;
> > +			if (offset < 32)
> > +				mask[0] |= 1 << offset;
> > +			else
> > +				mask[1] |= 1 << (offset - 32);
> > +			if (offset > max_irq)
> > +				max_irq = offset;
> > +		}
> > +
> > +	irq_set_chained_handler(irq_setup->irq, prcm_irq_handler);
> > +
> > +	irq_setup->base_irq = irq_alloc_descs(-1, 0, OMAP_PRCM_NR_IRQS, 0);
> > +
> > +	if (irq_setup->base_irq < 0) {
> > +		pr_err("PRCM: failed to allocate irq descs\n");
> > +		goto err;
> > +	}
> > +
> > +	for (i = 0; i <= max_irq / 32; i++) {
> > +		gc = irq_alloc_generic_chip("PRCM", 1,
> > +			irq_setup->base_irq + i * 32, NULL, handle_level_irq);
> > +
> > +		if (!gc) {
> > +			pr_err("PRCM: failed to allocate generic chip\n");
> > +			goto err;
> > +		}
> > +		ct = gc->chip_types;
> > +		ct->chip.irq_ack = irq_gc_ack;
> > +		ct->chip.irq_mask = irq_gc_mask_clr_bit;
> > +		ct->chip.irq_unmask = irq_gc_mask_set_bit;
> > +
> > +		ct->regs.ack = irq_setup->ack + (i << 2);
> > +		ct->regs.mask = irq_setup->mask + (i << 2);
> > +
> > +		irq_setup_generic_chip(gc, mask[i], 0, IRQ_NOREQUEST, 0);
> > +		prcm_irq_chips[i] = gc;
> > +	}
> > +	return 0;
> > +
> > +err:
> > +	omap_prcm_irq_cleanup();
> > +	return -ENOMEM;
> > +}
> > +
> > +int __init omap3_prcm_irq_init(void)
> > +{
> > +	irq_setup = &omap3_prcm_irq_setup;
> 
> if you make this a platform_driver, there would be no need for this
> trickery. You could pass this as driver data. Something like:
> 
> 
> struct omap_prcm_irq_setup omap3_prcm_irq_setup = {
> 	.ack		= (u32)OMAP3430_PRM_IRQSTATUS_MPU,
> 	.mask		= (u32)OMAP3430_PRM_IRQENABLE_MPU,
> 	.pending_events	= omap3_prm_pending_events,
> 	.irq		= INT_34XX_PRCM_MPU_IRQ,
> };
> 
> struct const struct platform_device_id prcm_id_table[] __devinitconst =
> {
> 	{
> 		.name		= "omap3-prcm",
> 		.driver_data	= &omap3_prcm_irq_setup,
> 	},
> 	{
> 		.name		= "omap4-prcm",
> 		.driver_data	= &omap4_prcm_irq_setup,
> 	},
> };
> MODULE_DEVICE_TABLE(platform, prcm_id_table);
> 
> static struct platform_driver prcm_driver = {
> 	.probe		= prcm_probe,
> 	.remove		= __devexit_p(prcm_remove),
> 	.driver		= {
> 		.name	= "prcm",
> 		.pm	= DEV_PM_OPS,
> 	},
> 	.id_table	= &prcm_id_table,
> };
> 
> or something similar. Then on probe you can make a copy of irq_setup to
> your driver's context structure, or only use temporarily to initialize
> some fields and so on...
> 

Hmm, this might be useful, however you would still need a way to
register the driver from somewhere, and you would essentially end up
with omap_chip version check somewhere. The reason for all this trickery
is that the omap chip version detection is heavily frowned upon right
now... it would be much cleaner if there was an accepted way of doing
this already in place.

-Tero



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 


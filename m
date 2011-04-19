From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] arm: omap2/3: Use generic irq chip
Date: Tue, 19 Apr 2011 02:59:58 -0700
Message-ID: <20110419095958.GD477@atomide.com>
References: <20110416211221.853079766@linutronix.de>
 <20110416211307.781114571@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:45527 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084Ab1DSKAN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 06:00:13 -0400
Content-Disposition: inline
In-Reply-To: <20110416211307.781114571@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LAK <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Lennert Buytenhek <buytenh@secretlab.ca>, Scott Branden <sbranden@broadcom.com>, Nicolas Pitre <nico@fluxnic.net>, Bryan Huntsman <bryanh@codeaurora.org>, Ben Dooks <ben-linux@fluff.org>, Daniel Walker <dwalker@fifo99.com>, linux-omap@vger.kernel.org

Use generic irq chip for omap2 & 3.

Note that this patch also leaves out the spurious IRQ warning
for omap3.

This warning should no longer be needed as the interrupt handlers
for various devices have implemented the necessayr read-back of
the posted write.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -73,83 +73,18 @@ static u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16 reg)
 	return __raw_readl(bank->base_reg + reg);
 }
 
-static int previous_irq;
-
-/*
- * On 34xx we can get occasional spurious interrupts if the ack from
- * an interrupt handler does not get posted before we unmask. Warn about
- * the interrupt handlers that need to flush posted writes.
- */
-static int omap_check_spurious(unsigned int irq)
-{
-	u32 sir, spurious;
-
-	sir = intc_bank_read_reg(&irq_banks[0], INTC_SIR);
-	spurious = sir >> 7;
-
-	if (spurious) {
-		printk(KERN_WARNING "Spurious irq %i: 0x%08x, please flush "
-					"posted write for irq %i\n",
-					irq, sir, previous_irq);
-		return spurious;
-	}
-
-	return 0;
-}
-
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
 static void omap_ack_irq(struct irq_data *d)
 {
 	intc_bank_write_reg(0x1, &irq_banks[0], INTC_CONTROL);
 }
 
-static void omap_mask_irq(struct irq_data *d)
-{
-	unsigned int irq = d->irq;
-	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
-
-	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
-		int spurious = 0;
-
-		/*
-		 * INT_34XX_GPT12_IRQ is also the spurious irq. Maybe because
-		 * it is the highest irq number?
-		 */
-		if (irq == INT_34XX_GPT12_IRQ)
-			spurious = omap_check_spurious(irq);
-
-		if (!spurious)
-			previous_irq = irq;
-	}
-
-	irq &= (IRQ_BITS_PER_REG - 1);
-
-	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);
-}
-
-static void omap_unmask_irq(struct irq_data *d)
-{
-	unsigned int irq = d->irq;
-	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
-
-	irq &= (IRQ_BITS_PER_REG - 1);
-
-	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_CLEAR0 + offset);
-}
-
 static void omap_mask_ack_irq(struct irq_data *d)
 {
-	omap_mask_irq(d);
+	irq_gc_mask_disable_reg(d);
 	omap_ack_irq(d);
 }
 
-static struct irq_chip omap_irq_chip = {
-	.name		= "INTC",
-	.irq_ack	= omap_mask_ack_irq,
-	.irq_mask	= omap_mask_irq,
-	.irq_unmask	= omap_unmask_irq,
-};
-
 static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
 {
 	unsigned long tmp;
@@ -186,11 +121,31 @@ int omap_irq_pending(void)
 	return 0;
 }
 
+static __init void
+omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
+{
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+
+	gc = irq_alloc_generic_chip("INTC", 1, irq_start, base,
+					handle_level_irq);
+	ct = gc->chip_types;
+	ct->chip.irq_ack = omap_mask_ack_irq;
+	ct->chip.irq_mask = irq_gc_mask_disable_reg;
+	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
+
+	ct->regs.ack = INTC_CONTROL;
+	ct->regs.enable = INTC_MIR_CLEAR0;
+	ct->regs.disable = INTC_MIR_SET0;
+	irq_setup_generic_chip(gc, IRQ_MSK(num),
+				IRQ_NOREQUEST | IRQ_NOPROBE, 0);
+}
+
 void __init omap_init_irq(void)
 {
 	unsigned long nr_of_irqs = 0;
 	unsigned int nr_banks = 0;
-	int i;
+	int i, j;
 
 	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
 		unsigned long base = 0;
@@ -215,17 +170,15 @@ void __init omap_init_irq(void)
 
 		omap_irq_bank_init_one(bank);
 
+		for (i = 0, j= 0; i < bank->nr_irqs; i += 32, j += 0x20)
+			omap_alloc_gc(bank->base_reg + j, i, 32);
+
 		nr_of_irqs += bank->nr_irqs;
 		nr_banks++;
 	}
 
 	printk(KERN_INFO "Total of %ld interrupts on %d active controller%s\n",
 	       nr_of_irqs, nr_banks, nr_banks > 1 ? "s" : "");
-
-	for (i = 0; i < nr_of_irqs; i++) {
-		irq_set_chip_and_handler(i, &omap_irq_chip, handle_level_irq);
-		set_irq_flags(i, IRQF_VALID);
-	}
 }
 
 #ifdef CONFIG_ARCH_OMAP3

From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP1: Switch to use generic irqchip in preparation for sparse IRQ
Date: Mon,  4 May 2015 12:52:20 -0700
Message-ID: <1430769142-3921-3-git-send-email-tony@atomide.com>
References: <1430769142-3921-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ftx-008-i775.relay.mailchannels.net ([50.61.143.75]:57538 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750943AbbEDTwj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2015 15:52:39 -0400
In-Reply-To: <1430769142-3921-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>

Let's set up things ready for enabling sparse IRQ and remove the
omap_read/write usage.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/irq.c | 118 +++++++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index a8a533d..3651b17 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -56,6 +56,7 @@
 
 struct omap_irq_bank {
 	unsigned long base_reg;
+	void __iomem *va;
 	unsigned long trigger_map;
 	unsigned long wake_enable;
 };
@@ -63,59 +64,33 @@ struct omap_irq_bank {
 u32 omap_irq_flags;
 static unsigned int irq_bank_count;
 static struct omap_irq_bank *irq_banks;
+static struct irq_domain *domain;
 
-static inline void irq_bank_writel(unsigned long value, int bank, int offset)
+static inline unsigned int irq_bank_readl(int bank, int offset)
 {
-	omap_writel(value, irq_banks[bank].base_reg + offset);
+	return readl_relaxed(irq_banks[bank].va + offset);
 }
-
-static void omap_ack_irq(struct irq_data *d)
-{
-	if (d->irq > 31)
-		omap_writel(0x1, OMAP_IH2_BASE + IRQ_CONTROL_REG_OFFSET);
-
-	omap_writel(0x1, OMAP_IH1_BASE + IRQ_CONTROL_REG_OFFSET);
-}
-
-static void omap_mask_irq(struct irq_data *d)
+static inline void irq_bank_writel(unsigned long value, int bank, int offset)
 {
-	int bank = IRQ_BANK(d->irq);
-	u32 l;
-
-	l = omap_readl(irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
-	l |= 1 << IRQ_BIT(d->irq);
-	omap_writel(l, irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
+	writel_relaxed(value, irq_banks[bank].va + offset);
 }
 
-static void omap_unmask_irq(struct irq_data *d)
+static void omap_ack_irq(int irq)
 {
-	int bank = IRQ_BANK(d->irq);
-	u32 l;
+	if (irq > 31)
+		writel_relaxed(0x1, irq_banks[1].va + IRQ_CONTROL_REG_OFFSET);
 
-	l = omap_readl(irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
-	l &= ~(1 << IRQ_BIT(d->irq));
-	omap_writel(l, irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
+	writel_relaxed(0x1, irq_banks[0].va + IRQ_CONTROL_REG_OFFSET);
 }
 
 static void omap_mask_ack_irq(struct irq_data *d)
 {
-	omap_mask_irq(d);
-	omap_ack_irq(d);
-}
-
-static int omap_wake_irq(struct irq_data *d, unsigned int enable)
-{
-	int bank = IRQ_BANK(d->irq);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 
-	if (enable)
-		irq_banks[bank].wake_enable |= IRQ_BIT(d->irq);
-	else
-		irq_banks[bank].wake_enable &= ~IRQ_BIT(d->irq);
-
-	return 0;
+	ct->chip.irq_mask(d);
+	omap_ack_irq(d->irq);
 }
 
-
 /*
  * Allows tuning the IRQ type and priority
  *
@@ -165,17 +140,30 @@ static struct omap_irq_bank omap1610_irq_banks[] = {
 };
 #endif
 
-static struct irq_chip omap_irq_chip = {
-	.name		= "MPU",
-	.irq_ack	= omap_mask_ack_irq,
-	.irq_mask	= omap_mask_irq,
-	.irq_unmask	= omap_unmask_irq,
-	.irq_set_wake	= omap_wake_irq,
-};
+static __init void
+omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
+{
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+
+	gc = irq_alloc_generic_chip("MPU", 1, irq_start, base,
+				    handle_level_irq);
+	ct = gc->chip_types;
+	ct->chip.irq_ack = omap_mask_ack_irq;
+	ct->chip.irq_mask = irq_gc_mask_set_bit;
+	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
+	ct->chip.irq_set_wake = irq_gc_set_wake;
+	ct->regs.mask = IRQ_MIR_REG_OFFSET;
+	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
+			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
+}
 
 void __init omap1_init_irq(void)
 {
-	int i, j;
+	struct irq_chip_type *ct;
+	struct irq_data *d = NULL;
+	int i, j, irq_base;
+	unsigned long nr_irqs;
 
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	if (cpu_is_omap7xx()) {
@@ -203,8 +191,26 @@ void __init omap1_init_irq(void)
 		irq_bank_count = ARRAY_SIZE(omap1610_irq_banks);
 	}
 #endif
-	printk("Total of %i interrupts in %i interrupt banks\n",
-	       irq_bank_count * 32, irq_bank_count);
+
+	for (i = 0; i < irq_bank_count; i++) {
+		irq_banks[i].va = ioremap(irq_banks[i].base_reg, 0xff);
+		if (WARN_ON(!irq_banks[i].va))
+			return;
+	}
+
+	nr_irqs = irq_bank_count * 32;
+
+	irq_base = irq_alloc_descs(-1, 0, nr_irqs, 0);
+	if (irq_base < 0) {
+		pr_warn("Couldn't allocate IRQ numbers\n");
+		irq_base = 0;
+	}
+
+	domain = irq_domain_add_legacy(NULL, nr_irqs, irq_base, 0,
+				       &irq_domain_simple_ops, NULL);
+
+	pr_info("Total of %lu interrupts in %i interrupt banks\n",
+		nr_irqs, irq_bank_count);
 
 	/* Mask and clear all interrupts */
 	for (i = 0; i < irq_bank_count; i++) {
@@ -227,19 +233,15 @@ void __init omap1_init_irq(void)
 
 			irq_trigger = irq_banks[i].trigger_map >> IRQ_BIT(j);
 			omap_irq_set_cfg(j, 0, 0, irq_trigger);
-
-			irq_set_chip_and_handler(j, &omap_irq_chip,
-						 handle_level_irq);
 			set_irq_flags(j, IRQF_VALID);
 		}
+		omap_alloc_gc(irq_banks[i].va, irq_base + i * 32, 32);
 	}
 
 	/* Unmask level 2 handler */
-
-	if (cpu_is_omap7xx())
-		omap_unmask_irq(irq_get_irq_data(INT_7XX_IH2_IRQ));
-	else if (cpu_is_omap15xx())
-		omap_unmask_irq(irq_get_irq_data(INT_1510_IH2_IRQ));
-	else if (cpu_is_omap16xx())
-		omap_unmask_irq(irq_get_irq_data(INT_1610_IH2_IRQ));
+	d = irq_get_irq_data(omap_irq_flags);
+	if (d) {
+		ct = irq_data_get_chip_type(d);
+		ct->chip.irq_unmask(d);
+	}
 }
-- 
2.1.4


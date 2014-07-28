From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 05/35] arm: omap: irq: remove rest of irq_banks usage
Date: Mon, 28 Jul 2014 16:15:53 -0500
Message-ID: <1406582183-696-6-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406582183-696-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

now we can finally remove the pointless irq_banks
array.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/irq.c | 128 +++++++++++++++++-----------------------------
 1 file changed, 47 insertions(+), 81 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 3870853..8c85c39 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -49,8 +49,8 @@
 #define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
 #define INTCPS_SIR_IRQ_OFFSET	0x0040	/* omap2/3 active interrupt offset */
 #define ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
+#define INTCPS_NR_ILR_REGS	128
 #define INTCPS_NR_MIR_REGS	3
-#define INTCPS_NR_IRQS		96
 
 /*
  * OMAP2 has a number of different interrupt controllers, each interrupt
@@ -58,15 +58,6 @@
  * fairly consistent for each bank, but not all registers are implemented
  * for each bank.. when in doubt, consult the TRM.
  */
-static struct omap_irq_bank {
-	void __iomem *base_reg;
-	unsigned int nr_irqs;
-} __attribute__ ((aligned(4))) irq_banks[] = {
-	{
-		/* MPU INTC */
-		.nr_irqs	= 96,
-	},
-};
 
 static struct irq_domain *domain;
 static void __iomem *omap_irq_base;
@@ -78,7 +69,7 @@ struct omap3_intc_regs {
 	u32 protection;
 	u32 idle;
 	u32 threshold;
-	u32 ilr[INTCPS_NR_IRQS];
+	u32 ilr[INTCPS_NR_ILR_REGS];
 	u32 mir[INTCPS_NR_MIR_REGS];
 };
 
@@ -105,13 +96,14 @@ static void omap_mask_ack_irq(struct irq_data *d)
 	omap_ack_irq(d);
 }
 
-static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
+static void __init omap_irq_soft_reset(void)
 {
 	unsigned long tmp;
 
 	tmp = intc_readl(INTC_REVISION) & 0xff;
+
 	pr_info("IRQ: Found an INTC at 0x%p (revision %ld.%ld) with %d interrupts\n",
-		bank->base_reg, tmp >> 4, tmp & 0xf, bank->nr_irqs);
+		omap_irq_base, tmp >> 4, tmp & 0xf, omap_nr_irqs);
 
 	tmp = intc_readl(INTC_SYSCONFIG);
 	tmp |= 1 << 1;	/* soft reset */
@@ -126,17 +118,12 @@ static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
 
 int omap_irq_pending(void)
 {
-	int i;
+	int irq;
 
-	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
-		struct omap_irq_bank *bank = irq_banks + i;
-		int irq;
-
-		for (irq = 0; irq < bank->nr_irqs; irq += 32)
-			if (intc_readl(INTC_PENDING_IRQ0 +
-					       ((irq >> 5) << 5)))
-				return 1;
-	}
+	for (irq = 0; irq < omap_nr_irqs; irq += 32)
+		if (intc_readl(INTC_PENDING_IRQ0 +
+					((irq >> 5) << 5)))
+			return 1;
 	return 0;
 }
 
@@ -163,9 +150,7 @@ omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 static void __init omap_init_irq(u32 base, int nr_irqs,
 				 struct device_node *node)
 {
-	unsigned long nr_of_irqs = 0;
-	unsigned int nr_banks = 0;
-	int i, j, irq_base;
+	int j, irq_base;
 
 	omap_irq_base = ioremap(base, SZ_4K);
 	if (WARN_ON(!omap_irq_base))
@@ -180,31 +165,12 @@ static void __init omap_init_irq(u32 base, int nr_irqs,
 	}
 
 	domain = irq_domain_add_legacy(node, nr_irqs, irq_base, 0,
-				       &irq_domain_simple_ops, NULL);
-
-	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
-		struct omap_irq_bank *bank = irq_banks + i;
-
-		bank->nr_irqs = nr_irqs;
-
-		/* Static mapping, never released */
-		bank->base_reg = ioremap(base, SZ_4K);
-		if (!bank->base_reg) {
-			pr_err("Could not ioremap irq bank%i\n", i);
-			continue;
-		}
-
-		omap_irq_bank_init_one(bank);
+			&irq_domain_simple_ops, NULL);
 
-		for (j = 0; j < bank->nr_irqs; j += 32)
-			omap_alloc_gc(bank->base_reg + j, j + irq_base, 32);
+	omap_irq_soft_reset();
 
-		nr_of_irqs += bank->nr_irqs;
-		nr_banks++;
-	}
-
-	pr_info("Total of %ld interrupts on %d active controller%s\n",
-		nr_of_irqs, nr_banks, nr_banks > 1 ? "s" : "");
+	for (j = 0; j < omap_nr_irqs; j += 32)
+		omap_alloc_gc(omap_irq_base + j, j + irq_base, 32);
 }
 
 void __init omap2_init_irq(void)
@@ -303,45 +269,45 @@ void __init omap_intc_of_init(void)
 }
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
-static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
+static struct omap3_intc_regs intc_context;
 
 void omap_intc_save_context(void)
 {
-	int ind = 0, i = 0;
-	for (ind = 0; ind < ARRAY_SIZE(irq_banks); ind++) {
-		intc_context[ind].sysconfig =
-			intc_readl(INTC_SYSCONFIG);
-		intc_context[ind].protection =
-			intc_readl(INTC_PROTECTION);
-		intc_context[ind].idle =
-			intc_readl(INTC_IDLE);
-		intc_context[ind].threshold =
-			intc_readl(INTC_THRESHOLD);
-		for (i = 0; i < INTCPS_NR_IRQS; i++)
-			intc_context[ind].ilr[i] =
-				intc_readl((INTC_ILR0 + 0x4 * i));
-		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
-			intc_context[ind].mir[i] =
-				intc_readl(INTC_MIR0 + (0x20 * i));
-	}
+	int i;
+
+	intc_context.sysconfig =
+		intc_readl(INTC_SYSCONFIG);
+	intc_context.protection =
+		intc_readl(INTC_PROTECTION);
+	intc_context.idle =
+		intc_readl(INTC_IDLE);
+	intc_context.threshold =
+		intc_readl(INTC_THRESHOLD);
+
+	for (i = 0; i < omap_nr_irqs; i++)
+		intc_context.ilr[i] =
+			intc_readl((INTC_ILR0 + 0x4 * i));
+	for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
+		intc_context.mir[i] =
+			intc_readl(INTC_MIR0 + (0x20 * i));
 }
 
 void omap_intc_restore_context(void)
 {
-	int ind = 0, i = 0;
-
-	for (ind = 0; ind < ARRAY_SIZE(irq_banks); ind++) {
-		intc_writel(INTC_SYSCONFIG, intc_context[ind].sysconfig);
-		intc_writel(INTC_PROTECTION, intc_context[ind].protection);
-		intc_writel(INTC_IDLE, intc_context[ind].idle);
-		intc_writel(INTC_THRESHOLD, intc_context[ind].threshold);
-		for (i = 0; i < INTCPS_NR_IRQS; i++)
-			intc_writel(INTC_ILR0 + 0x4 * i,
-					intc_context[ind].ilr[i]);
-		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
-			intc_writel(INTC_MIR0 + 0x20 * i,
-				intc_context[ind].mir[i]);
-	}
+	int i;
+
+	intc_writel(INTC_SYSCONFIG, intc_context.sysconfig);
+	intc_writel(INTC_PROTECTION, intc_context.protection);
+	intc_writel(INTC_IDLE, intc_context.idle);
+	intc_writel(INTC_THRESHOLD, intc_context.threshold);
+
+	for (i = 0; i < omap_nr_irqs; i++)
+		intc_writel(INTC_ILR0 + 0x4 * i,
+				intc_context.ilr[i]);
+
+	for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
+		intc_writel(INTC_MIR0 + 0x20 * i,
+			intc_context.mir[i]);
 	/* MIRs are saved and restore with other PRCM registers */
 }
 
-- 
2.0.1.563.g66f467c

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

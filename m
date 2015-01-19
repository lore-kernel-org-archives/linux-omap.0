From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v4 21/21] irqchip: gic: Drop support for gic_arch_extn
Date: Mon, 19 Jan 2015 09:44:15 +0000
Message-ID: <1421660655-21394-22-git-send-email-marc.zyngier@arm.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Now that the users of gic_arch_extn have been fixed, drop the
"feature" for good. This leads to the removal of some now useless
locking.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c       | 54 -----------------------------------------
 include/linux/irqchip/arm-gic.h |  2 --
 2 files changed, 56 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 23fe3be..78d4dee 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -80,19 +80,6 @@ static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 #define NR_GIC_CPU_IF 8
 static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
 
-/*
- * Supported arch specific GIC irq extension.
- * Default make them NULL.
- */
-struct irq_chip gic_arch_extn = {
-	.irq_eoi	= NULL,
-	.irq_mask	= NULL,
-	.irq_unmask	= NULL,
-	.irq_retrigger	= NULL,
-	.irq_set_type	= NULL,
-	.irq_set_wake	= NULL,
-};
-
 #ifndef MAX_GIC_NR
 #define MAX_GIC_NR	1
 #endif
@@ -155,32 +142,18 @@ static void gic_mask_irq(struct irq_data *d)
 {
 	u32 mask = 1 << (gic_irq(d) % 32);
 
-	raw_spin_lock(&irq_controller_lock);
 	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
-	if (gic_arch_extn.irq_mask)
-		gic_arch_extn.irq_mask(d);
-	raw_spin_unlock(&irq_controller_lock);
 }
 
 static void gic_unmask_irq(struct irq_data *d)
 {
 	u32 mask = 1 << (gic_irq(d) % 32);
 
-	raw_spin_lock(&irq_controller_lock);
-	if (gic_arch_extn.irq_unmask)
-		gic_arch_extn.irq_unmask(d);
 	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_irq(d) / 32) * 4);
-	raw_spin_unlock(&irq_controller_lock);
 }
 
 static void gic_eoi_irq(struct irq_data *d)
 {
-	if (gic_arch_extn.irq_eoi) {
-		raw_spin_lock(&irq_controller_lock);
-		gic_arch_extn.irq_eoi(d);
-		raw_spin_unlock(&irq_controller_lock);
-	}
-
 	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
 }
 
@@ -196,23 +169,13 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
-	raw_spin_lock(&irq_controller_lock);
-
-	if (gic_arch_extn.irq_set_type)
-		gic_arch_extn.irq_set_type(d, type);
-
 	gic_configure_irq(gicirq, type, base, NULL);
 
-	raw_spin_unlock(&irq_controller_lock);
-
 	return 0;
 }
 
 static int gic_retrigger(struct irq_data *d)
 {
-	if (gic_arch_extn.irq_retrigger)
-		return gic_arch_extn.irq_retrigger(d);
-
 	/* the genirq layer expects 0 if we can't retrigger in hardware */
 	return 0;
 }
@@ -244,21 +207,6 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 }
 #endif
 
-#ifdef CONFIG_PM
-static int gic_set_wake(struct irq_data *d, unsigned int on)
-{
-	int ret = -ENXIO;
-
-	if (gic_arch_extn.irq_set_wake)
-		ret = gic_arch_extn.irq_set_wake(d, on);
-
-	return ret;
-}
-
-#else
-#define gic_set_wake	NULL
-#endif
-
 static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
@@ -321,7 +269,6 @@ static struct irq_chip gic_chip = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= gic_set_affinity,
 #endif
-	.irq_set_wake		= gic_set_wake,
 };
 
 void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
@@ -985,7 +932,6 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		set_handle_irq(gic_handle_irq);
 	}
 
-	gic_chip.flags |= gic_arch_extn.flags;
 	gic_dist_init(gic);
 	gic_cpu_init(gic);
 	gic_pm_init(gic);
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 36ec4ae..9de976b 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -95,8 +95,6 @@
 
 struct device_node;
 
-extern struct irq_chip gic_arch_extn;
-
 void gic_set_irqchip_flags(unsigned long flags);
 void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
 		    u32 offset, struct device_node *);
-- 
2.1.4

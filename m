From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 4/5] ARM: GIC: move gic_data[] initialization into gic_init()
Date: Sun, 05 Dec 2010 11:35:19 +0000
Message-ID: <E1PPCsB-0004xa-H0@rmk-PC.arm.linux.org.uk>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45867 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab0LELf3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Dec 2010 06:35:29 -0500
In-Reply-To: <20101205113311.GC9138@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This avoids writing unnecessarily to gic_data[] from other CPUs,
making this a mostly read-only variable.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/gic.c |   48 ++++++++++++++++++++++++------------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index c48634a..b6a1d09 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -36,7 +36,7 @@
 static DEFINE_SPINLOCK(irq_controller_lock);
 
 /* Address of GIC 0 CPU interface */
-void __iomem *gic_cpu_base_addr;
+void __iomem *gic_cpu_base_addr __read_mostly;
 
 struct gic_chip_data {
 	unsigned int irq_offset;
@@ -48,7 +48,7 @@ struct gic_chip_data {
 #define MAX_GIC_NR	1
 #endif
 
-static struct gic_chip_data gic_data[MAX_GIC_NR];
+static struct gic_chip_data gic_data[MAX_GIC_NR] __read_mostly;
 
 static inline void __iomem *gic_dist_base(unsigned int irq)
 {
@@ -210,21 +210,16 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 	set_irq_chained_handler(irq, gic_handle_cascade_irq);
 }
 
-static void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
+static void __init gic_dist_init(struct gic_chip_data *gic,
 	unsigned int irq_start)
 {
 	unsigned int max_irq, i;
+	void __iomem *base = gic->dist_base;
 	u32 cpumask = 1 << smp_processor_id();
 
-	if (gic_nr >= MAX_GIC_NR)
-		BUG();
-
 	cpumask |= cpumask << 8;
 	cpumask |= cpumask << 16;
 
-	gic_data[gic_nr].dist_base = base;
-	gic_data[gic_nr].irq_offset = (irq_start - 1) & ~31;
-
 	writel(0, base + GIC_DIST_CTRL);
 
 	/*
@@ -269,9 +264,9 @@ static void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 	/*
 	 * Setup the Linux IRQ subsystem.
 	 */
-	for (i = irq_start; i < gic_data[gic_nr].irq_offset + max_irq; i++) {
+	for (i = irq_start; i < gic->irq_offset + max_irq; i++) {
 		set_irq_chip(i, &gic_chip);
-		set_irq_chip_data(i, &gic_data[gic_nr]);
+		set_irq_chip_data(i, gic);
 		set_irq_handler(i, handle_level_irq);
 		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
 	}
@@ -279,19 +274,12 @@ static void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 	writel(1, base + GIC_DIST_CTRL);
 }
 
-static void __cpuinit gic_cpu_init(unsigned int gic_nr, void __iomem *base)
+static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
 {
-	void __iomem *dist_base;
+	void __iomem *dist_base = gic->dist_base;
+	void __iomem *base = gic->cpu_base;
 	int i;
 
-	if (gic_nr >= MAX_GIC_NR)
-		BUG();
-
-	dist_base = gic_data[gic_nr].dist_base;
-	BUG_ON(!dist_base);
-
-	gic_data[gic_nr].cpu_base = base;
-
 	/*
 	 * Deal with the banked PPI and SGI interrupts - disable all
 	 * PPI interrupts, ensure all SGI interrupts are enabled.
@@ -312,15 +300,27 @@ static void __cpuinit gic_cpu_init(unsigned int gic_nr, void __iomem *base)
 void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
 	void __iomem *dist_base, void __iomem *cpu_base)
 {
+	struct gic_chip_data *gic;
+
+	BUG_ON(gic_nr >= MAX_GIC_NR);
+
+	gic = &gic_data[gic_nr];
+	gic->dist_base = dist_base;
+	gic->cpu_base = cpu_base;
+	gic->irq_offset = (irq_start - 1) & ~31;
+
 	if (gic_nr == 0)
 		gic_cpu_base_addr = cpu_base;
-	gic_dist_init(gic_nr, dist_base, irq_start);
-	gic_cpu_init(gic_nr, cpu_base);
+
+	gic_dist_init(gic, irq_start);
+	gic_cpu_init(gic);
 }
 
 void __cpuinit gic_secondary_init(unsigned int gic_nr)
 {
-	gic_cpu_init(gic_nr, gic_data[gic_nr].cpu_base);
+	BUG_ON(gic_nr >= MAX_GIC_NR);
+
+	gic_cpu_init(&gic_data[gic_nr]);
 }
 
 #ifdef CONFIG_SMP
-- 
1.6.2.5


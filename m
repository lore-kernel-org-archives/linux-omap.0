From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/5] ARM: gic: Add hooks for architecture specific extensions
Date: Mon, 24 Jan 2011 14:21:15 +0530
Message-ID: <1295859080-15259-2-git-send-email-santosh.shilimkar@ti.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43315 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375Ab1AXIvw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 03:51:52 -0500
In-Reply-To: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, ccross@android.com, catalin.marinas@arm.com, linux@arm.linux.org.uk, linus.ml.walleij@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

Few architectures combine the GIC with an external interrupt controller.
On such systems it may be necessary to update both the GIC registers
and the external controller's registers to control IRQ behavior.

This can be addressed in couple of possible methods.
 1.	Export common GIC routines along with 'struct irq_chip gic_chip'
	and allow architectures to have custom function by override.

 2.	Provide architecture specific function pointer hooks
	within GIC library and leave platforms to add the necessary
	code as part of these hooks.

First one might be non-intrusive but have few shortcomings like arch needs
to have there own custom gic library. Locks used should be common since it
caters to same IRQs etc. Maintenance point of view also it leads to
multiple file fixes.

The second probably is cleaner and portable. It ensures that all the
common GIC infrastructure is not touched and also provides archs to
address their specific issue.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/gic.c               |   28 ++++++++++++++++++++++++++++
 arch/arm/include/asm/hardware/gic.h |    1 +
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 2243772..b4a9ea7 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -44,6 +44,15 @@ struct gic_chip_data {
 	void __iomem *cpu_base;
 };
 
+/* Default make arch specific GIC functions NULL */
+struct irq_chip gic_arch_extn = {
+	.irq_mask	= NULL,
+	.irq_unmask	= NULL,
+#ifdef CONFIG_PM
+	.irq_set_wake	= NULL,
+#endif
+};
+
 #ifndef MAX_GIC_NR
 #define MAX_GIC_NR	1
 #endif
@@ -84,6 +93,8 @@ static void gic_mask_irq(struct irq_data *d)
 
 	spin_lock(&irq_controller_lock);
 	writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
+	if (gic_arch_extn.irq_mask)
+		gic_arch_extn.irq_mask(d);
 	spin_unlock(&irq_controller_lock);
 }
 
@@ -92,6 +103,8 @@ static void gic_unmask_irq(struct irq_data *d)
 	u32 mask = 1 << (d->irq % 32);
 
 	spin_lock(&irq_controller_lock);
+	if (gic_arch_extn.irq_unmask)
+		gic_arch_extn.irq_unmask(d);
 	writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_irq(d) / 32) * 4);
 	spin_unlock(&irq_controller_lock);
 }
@@ -167,6 +180,18 @@ gic_set_cpu(struct irq_data *d, const struct cpumask *mask_val, bool force)
 }
 #endif
 
+#ifdef CONFIG_PM
+static int gic_set_wake(struct irq_data *d, unsigned int on)
+{
+	int ret = -ENXIO;
+
+	if (gic_arch_extn.irq_set_wake)
+		ret = gic_arch_extn.irq_set_wake(d, on);
+
+	return ret;
+}
+#endif
+
 static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 {
 	struct gic_chip_data *chip_data = get_irq_data(irq);
@@ -205,6 +230,9 @@ static struct irq_chip gic_chip = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= gic_set_cpu,
 #endif
+#ifdef CONFIG_PM
+	.irq_set_wake	= gic_set_wake,
+#endif
 };
 
 void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 84557d3..0691f9d 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -34,6 +34,7 @@
 
 #ifndef __ASSEMBLY__
 extern void __iomem *gic_cpu_base_addr;
+extern struct irq_chip gic_arch_extn;
 
 void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
 void gic_secondary_init(unsigned int);
-- 
1.6.0.4


From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 15/17] irqchip/gic: Split GIC init in preparation for platform driver
Date: Wed, 4 May 2016 17:25:28 +0100
Message-ID: <1462379130-11742-16-git-send-email-jonathanh@nvidia.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

To re-use the code that initialises the GIC (found in
__gic_init_bases()), from within a platform driver, it is necessary to
move the code from the __init section so that it is always present and
not removed. Unfortunately, it is not possible to simply drop the __init
from the function declaration for __gic_init_bases() because it contains
calls to set_smp_cross_call() and set_handle_irq() which are both
located in the __init section. Fortunately, these calls are only
required for the root controller and because the initial platform driver
will only support non-root controllers that can be initialised later in
the boot process, we can move these calls to another function.

Move the bulk of the code from __gic_init_bases() to a new function
called gic_init_bases() which is not located in the __init section and
can be used by the platform driver. Update __gic_init_bases() to call
gic_init_bases() and if necessary, set_smp_cross_call() and
set_handle_irq().

To allow the platform driver to dynamically allocate the GIC chip data
structure, rather than passing an index to reference the GIC to
gic_init_bases() pass a pointer to the chip data instead. This means
that the name must be passed to gic_init_bases() as well, because the
name will not be passed upon an index for a platform device.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/irqchip/irq-gic.c | 71 +++++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 2fc5018d6eb9..15e8a12813cc 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1002,32 +1002,29 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.unmap = gic_irq_domain_unmap,
 };
 
-static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
-			   void __iomem *dist_base, void __iomem *cpu_base,
-			   u32 percpu_offset, struct fwnode_handle *handle)
+static int gic_init_bases(struct gic_chip_data *gic, int irq_start,
+			  void __iomem *dist_base, void __iomem *cpu_base,
+			  u32 percpu_offset, struct fwnode_handle *handle,
+			  const char *name)
 {
 	irq_hw_number_t hwirq_base;
-	struct gic_chip_data *gic;
-	int gic_irqs, irq_base, i, ret;
-
-	BUG_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR);
+	int gic_irqs, irq_base, ret;
 
-	gic = &gic_data[gic_nr];
+	if (WARN_ON(!gic || gic->domain))
+		return -EINVAL;
 
 	/* Initialize irq_chip */
 	gic->chip = gic_chip;
+	gic->chip.name = name;
 
-	if (static_key_true(&supports_deactivate) && gic_nr == 0) {
+	if (static_key_true(&supports_deactivate) && gic == &gic_data[0]) {
 		gic->chip.irq_mask = gic_eoimode1_mask_irq;
 		gic->chip.irq_eoi = gic_eoimode1_eoi_irq;
 		gic->chip.irq_set_vcpu_affinity = gic_irq_set_vcpu_affinity;
-		gic->chip.name = kasprintf(GFP_KERNEL, "GICv2");
-	} else {
-		gic->chip.name = kasprintf(GFP_KERNEL, "GIC-%d", gic_nr);
 	}
 
 #ifdef CONFIG_SMP
-	if (gic_nr == 0)
+	if (gic == &gic_data[0])
 		gic->chip.irq_set_affinity = gic_set_affinity;
 #endif
 
@@ -1081,7 +1078,7 @@ static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 		 * For primary GICs, skip over SGIs.
 		 * For secondary GICs, skip over PPIs, too.
 		 */
-		if (gic_nr == 0 && (irq_start & 31) > 0) {
+		if (gic == &gic_data[0] && (irq_start & 31) > 0) {
 			hwirq_base = 16;
 			if (irq_start != -1)
 				irq_start = (irq_start & ~31) + 16;
@@ -1108,6 +1105,42 @@ static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 		goto error;
 	}
 
+	return 0;
+
+error:
+	if (IS_ENABLED(CONFIG_GIC_NON_BANKED) && percpu_offset) {
+		free_percpu(gic->dist_base.percpu_base);
+		free_percpu(gic->cpu_base.percpu_base);
+	}
+
+	return ret;
+}
+
+static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
+			   void __iomem *dist_base, void __iomem *cpu_base,
+			   u32 percpu_offset, struct fwnode_handle *handle)
+{
+	struct gic_chip_data *gic;
+	char *name;
+	int i, ret;
+
+	if (WARN_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR))
+		return -EINVAL;
+
+	gic = &gic_data[gic_nr];
+
+	if (static_key_true(&supports_deactivate) && gic_nr == 0)
+		name = kasprintf(GFP_KERNEL, "GICv2");
+	else
+		name = kasprintf(GFP_KERNEL, "GIC-%d", gic_nr);
+
+	ret = gic_init_bases(gic, irq_start, dist_base, cpu_base, percpu_offset,
+			     handle, name);
+	if (ret) {
+		kfree(name);
+		return ret;
+	}
+
 	if (gic_nr == 0) {
 		/*
 		 * Initialize the CPU interface map to all CPUs.
@@ -1130,16 +1163,6 @@ static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 	gic_pm_init(gic);
 
 	return 0;
-
-error:
-	if (IS_ENABLED(CONFIG_GIC_NON_BANKED) && percpu_offset) {
-		free_percpu(gic->dist_base.percpu_base);
-		free_percpu(gic->cpu_base.percpu_base);
-	}
-
-	kfree(gic->chip.name);
-
-	return ret;
 }
 
 void __init gic_init(unsigned int gic_nr, int irq_start,
-- 
2.1.4

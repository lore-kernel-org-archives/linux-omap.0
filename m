From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 13/15] irqchip/gic: Prepare for adding platform driver
Date: Thu, 17 Mar 2016 14:19:17 +0000
Message-ID: <1458224359-32665-14-git-send-email-jonathanh@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

To support GIC chips located in power-domains outside of the CPU subsystem
it is necessary to add a platform driver for these chips, so that the
probing of the chip can be deferred if resources, such as a power-domain,
is not yet available.

To re-use the code that initialises the GIC (found in __gic_init_bases()),
from within the platform driver, it is necessary to move the code from the
__init section so that it is always present and not removed. Unfortunately,
it is not possible to simply drop the __init from the function declaration
for __gic_init_bases() because it contains calls to set_smp_cross_call()
and set_handle_irq() which are both located in the __init section.
Fortunately, these calls are only required for the root controller and
because the platform driver will only support non-root controllers that
can be initialised later in the boot process, we can move these calls to
another function. Move the bulk of the code from __gic_init_bases() to a
new function called gic_init_bases() which is not located in the __init
section and can be used by the platform driver. Update __gic_init_bases()
to call gic_init_bases() and if necessary, set_smp_cross_call() and
set_handle_irq().

The function, gic_init_bases(), references the GIC via a pointer to the
GIC chip data structure instead of an index so that it can be used by the
platform driver and statically declared GICs. This means that the name
must be passed to gic_init_bases() as well, because the name will not be
passed upon an index for platform devices.

Drop the __init section from the gic_dist_config(), gic_dist_init() and
gic_pm_init() so these can be re-used by the platform driver as well.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/irqchip/irq-gic-common.c |  4 +-
 drivers/irqchip/irq-gic.c        | 80 +++++++++++++++++++++++++++-------------
 2 files changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 423a345d7b75..646fc0f4a3bc 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -64,8 +64,8 @@ void gic_configure_irq(unsigned int irq, unsigned int type,
 		sync_access();
 }
 
-void __init gic_dist_config(void __iomem *base, int gic_irqs,
-			    void (*sync_access)(void))
+void gic_dist_config(void __iomem *base, int gic_irqs,
+		     void (*sync_access)(void))
 {
 	unsigned int i;
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index de9f1caee648..7cc5380db298 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -438,7 +438,7 @@ static void gic_cpu_if_up(struct gic_chip_data *gic)
 }
 
 
-static void __init gic_dist_init(struct gic_chip_data *gic)
+static void gic_dist_init(struct gic_chip_data *gic)
 {
 	unsigned int i;
 	u32 cpumask;
@@ -711,7 +711,7 @@ static struct notifier_block gic_notifier_block = {
 	.notifier_call = gic_notifier,
 };
 
-static void __init gic_pm_init(struct gic_chip_data *gic)
+static void gic_pm_init(struct gic_chip_data *gic)
 {
 	gic->saved_ppi_enable = __alloc_percpu(DIV_ROUND_UP(32, 32) * 4,
 		sizeof(u32));
@@ -729,7 +729,7 @@ static void __init gic_pm_init(struct gic_chip_data *gic)
 		cpu_pm_register_notifier(&gic_notifier_block);
 }
 #else
-static void __init gic_pm_init(struct gic_chip_data *gic)
+static void gic_pm_init(struct gic_chip_data *gic)
 {
 }
 #endif
@@ -1003,34 +1003,31 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
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
 	int gic_irqs, irq_base, i, ret;
 
-	BUG_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR);
+	if (WARN_ON(!gic || gic->domain))
+		return -EINVAL;
 
 	gic_check_cpu_features();
 
-	gic = &gic_data[gic_nr];
-
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
 
@@ -1084,7 +1081,7 @@ static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 		 * For primary GICs, skip over SGIs.
 		 * For secondary GICs, skip over PPIs, too.
 		 */
-		if (gic_nr == 0 && (irq_start & 31) > 0) {
+		if (gic == &gic_data[0] && (irq_start & 31) > 0) {
 			hwirq_base = 16;
 			if (irq_start != -1)
 				irq_start = (irq_start & ~31) + 16;
@@ -1111,7 +1108,7 @@ static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 		goto error;
 	}
 
-	if (gic_nr == 0) {
+	if (gic == &gic_data[0]) {
 		/*
 		 * Initialize the CPU interface map to all CPUs.
 		 * It will be refined as each CPU probes its ID.
@@ -1119,13 +1116,6 @@ static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 		 */
 		for (i = 0; i < NR_GIC_CPU_IF; i++)
 			gic_cpu_map[i] = 0xff;
-#ifdef CONFIG_SMP
-		set_smp_cross_call(gic_raise_softirq);
-		register_cpu_notifier(&gic_cpu_notifier);
-#endif
-		set_handle_irq(gic_handle_irq);
-		if (static_key_true(&supports_deactivate))
-			pr_info("GIC: Using split EOI/Deactivate mode\n");
 	}
 
 	gic_dist_init(gic);
@@ -1140,7 +1130,47 @@ error:
 		free_percpu(gic->cpu_base.percpu_base);
 	}
 
-	kfree(gic->chip.name);
+	return ret;
+}
+
+static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
+				   void __iomem *dist_base,
+				   void __iomem *cpu_base,
+				   u32 percpu_offset,
+				   struct fwnode_handle *handle)
+{
+	struct gic_chip_data *gic;
+	char *name;
+	int ret;
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
+	ret = gic_init_bases(gic, irq_start, dist_base, cpu_base,
+			     percpu_offset, handle, name);
+	if (ret) {
+		kfree(gic->chip.name);
+		return ret;
+	}
+
+	if (gic_nr == 0) {
+		if (IS_ENABLED(CONFIG_SMP)) {
+			set_smp_cross_call(gic_raise_softirq);
+			register_cpu_notifier(&gic_cpu_notifier);
+		}
+
+		set_handle_irq(gic_handle_irq);
+
+		if (static_key_true(&supports_deactivate))
+			pr_info("GIC: Using split EOI/Deactivate mode\n");
+	}
 
 	return ret;
 }
-- 
2.1.4

From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 16/17] irqchip/gic: Prepare for adding platform driver
Date: Wed, 4 May 2016 17:25:29 +0100
Message-ID: <1462379130-11742-17-git-send-email-jonathanh@nvidia.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462379130-11742-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

To support GICs that require runtime-pm, it is necessary to add a
platform driver, so that the probing of the chip can be deferred if
resources, such as a power-domain, is not yet available.

To prepare for adding a platform driver:
 1. Drop the __init section from the gic_dist_config(), gic_dist_init()
    and gic_pm_init() so these can be re-used by the platform driver.
 2. Move the definitions for gic_base and gic_chip_data structures to a
    local header files along with prototypes for functions required by
    the platform driver.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/irqchip/irq-gic-common.c |  4 +--
 drivers/irqchip/irq-gic.c        | 57 +++++++++++-------------------------
 drivers/irqchip/irq-gic.h        | 63 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 42 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic.h

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 9fa92a17225c..083c30390aa3 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -72,8 +72,8 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	return ret;
 }
 
-void __init gic_dist_config(void __iomem *base, int gic_irqs,
-			    void (*sync_access)(void))
+void gic_dist_config(void __iomem *base, int gic_irqs,
+		     void (*sync_access)(void))
 {
 	unsigned int i;
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 15e8a12813cc..bf9a256a1269 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -48,6 +48,7 @@
 #include <asm/smp_plat.h>
 #include <asm/virt.h>
 
+#include "irq-gic.h"
 #include "irq-gic-common.h"
 
 #ifdef CONFIG_ARM64
@@ -63,31 +64,6 @@ static void gic_check_cpu_features(void)
 #define gic_check_cpu_features()	do { } while(0)
 #endif
 
-union gic_base {
-	void __iomem *common_base;
-	void __percpu * __iomem *percpu_base;
-};
-
-struct gic_chip_data {
-	struct irq_chip chip;
-	union gic_base dist_base;
-	union gic_base cpu_base;
-#ifdef CONFIG_CPU_PM
-	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
-	u32 saved_spi_active[DIV_ROUND_UP(1020, 32)];
-	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
-	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
-	u32 __percpu *saved_ppi_enable;
-	u32 __percpu *saved_ppi_active;
-	u32 __percpu *saved_ppi_conf;
-#endif
-	struct irq_domain *domain;
-	unsigned int gic_irqs;
-#ifdef CONFIG_GIC_NON_BANKED
-	void __iomem *(*get_base)(union gic_base *);
-#endif
-};
-
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 
 /*
@@ -352,7 +328,7 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 	} while (1);
 }
 
-static void gic_handle_cascade_irq(struct irq_desc *desc)
+void gic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct gic_chip_data *chip_data = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -436,7 +412,7 @@ static void gic_cpu_if_up(struct gic_chip_data *gic)
 }
 
 
-static void __init gic_dist_init(struct gic_chip_data *gic)
+void gic_dist_init(struct gic_chip_data *gic)
 {
 	unsigned int i;
 	u32 cpumask;
@@ -459,7 +435,7 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
 	writel_relaxed(GICD_ENABLE, base + GIC_DIST_CTRL);
 }
 
-static void gic_cpu_init(struct gic_chip_data *gic)
+void gic_cpu_init(struct gic_chip_data *gic)
 {
 	void __iomem *dist_base = gic_data_dist_base(gic);
 	void __iomem *base = gic_data_cpu_base(gic);
@@ -518,7 +494,7 @@ int gic_cpu_if_down(unsigned int gic_nr)
  * this function, no interrupts will be delivered by the GIC, and another
  * platform-specific wakeup source must be enabled.
  */
-static void gic_dist_save(struct gic_chip_data *gic)
+void gic_dist_save(struct gic_chip_data *gic)
 {
 	unsigned int gic_irqs;
 	void __iomem *dist_base;
@@ -557,7 +533,7 @@ static void gic_dist_save(struct gic_chip_data *gic)
  * handled normally, but any edge interrupts that occured will not be seen by
  * the GIC and need to be handled by the platform-specific wakeup source.
  */
-static void gic_dist_restore(struct gic_chip_data *gic)
+void gic_dist_restore(struct gic_chip_data *gic)
 {
 	unsigned int gic_irqs;
 	unsigned int i;
@@ -603,7 +579,7 @@ static void gic_dist_restore(struct gic_chip_data *gic)
 	writel_relaxed(GICD_ENABLE, dist_base + GIC_DIST_CTRL);
 }
 
-static void gic_cpu_save(struct gic_chip_data *gic)
+void gic_cpu_save(struct gic_chip_data *gic)
 {
 	int i;
 	u32 *ptr;
@@ -633,7 +609,7 @@ static void gic_cpu_save(struct gic_chip_data *gic)
 
 }
 
-static void gic_cpu_restore(struct gic_chip_data *gic)
+void gic_cpu_restore(struct gic_chip_data *gic)
 {
 	int i;
 	u32 *ptr;
@@ -710,7 +686,7 @@ static struct notifier_block gic_notifier_block = {
 	.notifier_call = gic_notifier,
 };
 
-static void __init gic_pm_init(struct gic_chip_data *gic)
+void gic_pm_init(struct gic_chip_data *gic)
 {
 	gic->saved_ppi_enable = __alloc_percpu(DIV_ROUND_UP(32, 32) * 4,
 		sizeof(u32));
@@ -728,7 +704,7 @@ static void __init gic_pm_init(struct gic_chip_data *gic)
 		cpu_pm_register_notifier(&gic_notifier_block);
 }
 #else
-static void __init gic_pm_init(struct gic_chip_data *gic)
+void gic_pm_init(struct gic_chip_data *gic)
 {
 }
 #endif
@@ -1002,10 +978,10 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.unmap = gic_irq_domain_unmap,
 };
 
-static int gic_init_bases(struct gic_chip_data *gic, int irq_start,
-			  void __iomem *dist_base, void __iomem *cpu_base,
-			  u32 percpu_offset, struct fwnode_handle *handle,
-			  const char *name)
+int gic_init_bases(struct gic_chip_data *gic, int irq_start,
+		   void __iomem *dist_base, void __iomem *cpu_base,
+		   u32 percpu_offset, struct fwnode_handle *handle,
+		   const char *name)
 {
 	irq_hw_number_t hwirq_base;
 	int gic_irqs, irq_base, ret;
@@ -1153,6 +1129,7 @@ static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 		set_smp_cross_call(gic_raise_softirq);
 		register_cpu_notifier(&gic_cpu_notifier);
 #endif
+
 		set_handle_irq(gic_handle_irq);
 		if (static_key_true(&supports_deactivate))
 			pr_info("GIC: Using split EOI/Deactivate mode\n");
@@ -1217,8 +1194,8 @@ static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
 	return true;
 }
 
-static int gic_of_setup(struct device_node *node, void __iomem **dist_base,
-			void __iomem **cpu_base, u32 *percpu_offset)
+int gic_of_setup(struct device_node *node, void __iomem **dist_base,
+		 void __iomem **cpu_base, u32 *percpu_offset)
 {
 	if (!node || !dist_base || !cpu_base || !percpu_offset)
 		return -EINVAL;
diff --git a/drivers/irqchip/irq-gic.h b/drivers/irqchip/irq-gic.h
new file mode 100644
index 000000000000..59198d5e7175
--- /dev/null
+++ b/drivers/irqchip/irq-gic.h
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2016 NVIDIA CORPORATION, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _IRQ_GIC_H
+#define _IRQ_GIC_H
+
+union gic_base {
+	void __iomem *common_base;
+	void __percpu * __iomem *percpu_base;
+};
+
+struct gic_chip_data {
+	struct irq_chip chip;
+	union gic_base dist_base;
+	union gic_base cpu_base;
+#ifdef CONFIG_CPU_PM
+	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
+	u32 saved_spi_active[DIV_ROUND_UP(1020, 32)];
+	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
+	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
+	u32 __percpu *saved_ppi_enable;
+	u32 __percpu *saved_ppi_active;
+	u32 __percpu *saved_ppi_conf;
+#endif
+	struct irq_domain *domain;
+	unsigned int gic_irqs;
+#ifdef CONFIG_GIC_NON_BANKED
+	void __iomem *(*get_base)(union gic_base *);
+#endif
+};
+
+void gic_cpu_init(struct gic_chip_data *gic);
+void gic_cpu_save(struct gic_chip_data *gic);
+void gic_cpu_restore(struct gic_chip_data *gic);
+void gic_dist_init(struct gic_chip_data *gic);
+void gic_dist_save(struct gic_chip_data *gic);
+void gic_dist_restore(struct gic_chip_data *gic);
+void gic_pm_init(struct gic_chip_data *gic);
+
+int gic_of_setup(struct device_node *node, void __iomem **dist_base,
+		 void __iomem **cpu_base, u32 *percpu_offset);
+
+int gic_init_bases(struct gic_chip_data *gic, int irq_start,
+		   void __iomem *dist_base, void __iomem *cpu_base,
+		   u32 percpu_offset, struct fwnode_handle *handle,
+		   const char *name);
+
+void gic_handle_cascade_irq(struct irq_desc *desc);
+
+#endif /* _IRQ_GIC_H */
-- 
2.1.4

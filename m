From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 2/4] ARM: OMAP2/3: intc: Add DT support for TI interrupt controller
Date: Tue, 14 Feb 2012 18:56:10 +0100
Message-ID: <1329242172-4214-3-git-send-email-b-cousson@ti.com>
References: <1329242172-4214-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58381 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322Ab2BNR4v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 12:56:51 -0500
In-Reply-To: <1329242172-4214-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, rob.herring@calxeda.com
Cc: grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Add a function to initialize the OMAP2/3 interrupt controller (INTC)
using a device tree node.

This version take advantage of the new irq_domain_add_legacy API.

Replace some printk() with the proper pr_ macro.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 .../devicetree/bindings/arm/omap/intc.txt          |   27 +++++++++
 arch/arm/mach-omap2/common.h                       |   10 +++
 arch/arm/mach-omap2/irq.c                          |   59 ++++++++++++++++---
 3 files changed, 86 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/intc.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/intc.txt b/Documentation/devicetree/bindings/arm/omap/intc.txt
new file mode 100644
index 0000000..f2583e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/intc.txt
@@ -0,0 +1,27 @@
+* OMAP Interrupt Controller
+
+OMAP2/3 are using a TI interrupt controller that can support several
+configurable number of interrupts.
+
+Main node required properties:
+
+- compatible : should be:
+	"ti,omap2-intc"
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The type shall be a <u32> and the value shall be 1.
+
+  The cell contains the interrupt number in the range [0-128].
+- ti,intc-size: Number of interrupts handled by the interrupt controller.
+- reg: physical base address and size of the intc registers map.
+
+Example:
+
+	intc: interrupt-controller@1 {
+		compatible = "ti,omap2-intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		ti,intc-size = <96>;
+		reg = <0x48200000 0x1000>;
+	};
+
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index febffde..a87ce52 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -174,6 +174,16 @@ void omap3_intc_handle_irq(struct pt_regs *regs);
 extern void __iomem *omap4_get_l2cache_base(void);
 #endif
 
+struct device_node;
+#ifdef CONFIG_OF
+int __init intc_of_init(struct device_node *node, struct device_node *parent);
+#else
+int __init intc_of_init(struct device_node *node, struct device_node *parent)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_SMP
 extern void __iomem *omap4_get_scu_base(void);
 #else
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 1fef061..e2d0f33 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -11,12 +11,16 @@
  * for more details.
  */
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 
 /* selected INTC register offsets */
@@ -57,6 +61,8 @@ static struct omap_irq_bank {
 	},
 };
 
+static struct irq_domain *domain;
+
 /* Structure to save interrupt controller context */
 struct omap3_intc_regs {
 	u32 sysconfig;
@@ -147,17 +153,27 @@ omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 				IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 }
 
-static void __init omap_init_irq(u32 base, int nr_irqs)
+static void __init omap_init_irq(u32 base, int nr_irqs,
+				 struct device_node *node)
 {
 	void __iomem *omap_irq_base;
 	unsigned long nr_of_irqs = 0;
 	unsigned int nr_banks = 0;
-	int i, j;
+	int i, j, irq_base;
 
 	omap_irq_base = ioremap(base, SZ_4K);
 	if (WARN_ON(!omap_irq_base))
 		return;
 
+	irq_base = irq_alloc_descs(-1, 0, nr_irqs, 0);
+	if (irq_base < 0) {
+		pr_warn("Couldn't allocate IRQ numbers\n");
+		irq_base = 0;
+	}
+
+	domain = irq_domain_add_legacy(node, nr_irqs, irq_base, 0,
+				       &irq_domain_simple_ops, NULL);
+
 	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
 		struct omap_irq_bank *bank = irq_banks + i;
 
@@ -166,36 +182,36 @@ static void __init omap_init_irq(u32 base, int nr_irqs)
 		/* Static mapping, never released */
 		bank->base_reg = ioremap(base, SZ_4K);
 		if (!bank->base_reg) {
-			printk(KERN_ERR "Could not ioremap irq bank%i\n", i);
+			pr_err("Could not ioremap irq bank%i\n", i);
 			continue;
 		}
 
 		omap_irq_bank_init_one(bank);
 
 		for (j = 0; j < bank->nr_irqs; j += 32)
-			omap_alloc_gc(bank->base_reg + j, j, 32);
+			omap_alloc_gc(bank->base_reg + j, j + irq_base, 32);
 
 		nr_of_irqs += bank->nr_irqs;
 		nr_banks++;
 	}
 
-	printk(KERN_INFO "Total of %ld interrupts on %d active controller%s\n",
-	       nr_of_irqs, nr_banks, nr_banks > 1 ? "s" : "");
+	pr_info("Total of %ld interrupts on %d active controller%s\n",
+		nr_of_irqs, nr_banks, nr_banks > 1 ? "s" : "");
 }
 
 void __init omap2_init_irq(void)
 {
-	omap_init_irq(OMAP24XX_IC_BASE, 96);
+	omap_init_irq(OMAP24XX_IC_BASE, 96, NULL);
 }
 
 void __init omap3_init_irq(void)
 {
-	omap_init_irq(OMAP34XX_IC_BASE, 96);
+	omap_init_irq(OMAP34XX_IC_BASE, 96, NULL);
 }
 
 void __init ti81xx_init_irq(void)
 {
-	omap_init_irq(OMAP34XX_IC_BASE, 128);
+	omap_init_irq(OMAP34XX_IC_BASE, 128, NULL);
 }
 
 static inline void omap_intc_handle_irq(void __iomem *base_addr, struct pt_regs *regs)
@@ -225,8 +241,10 @@ out:
 		irqnr = readl_relaxed(base_addr + INTCPS_SIR_IRQ_OFFSET);
 		irqnr &= ACTIVEIRQ_MASK;
 
-		if (irqnr)
+		if (irqnr) {
+			irqnr = irq_find_mapping(domain, irqnr);
 			handle_IRQ(irqnr, regs);
+		}
 	} while (irqnr);
 }
 
@@ -236,6 +254,27 @@ asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs *regs
 	omap_intc_handle_irq(base_addr, regs);
 }
 
+int __init intc_of_init(struct device_node *node, struct device_node *parent)
+{
+	struct resource res;
+	u32 nr_irqs = 96;
+
+	if (WARN_ON(!node))
+		return -ENODEV;
+
+	if (of_address_to_resource(node, 0, &res)) {
+		WARN(1, "unable to get intc registers\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "ti,intc-size", &nr_irqs))
+		pr_warn("unable to get intc-size, default to %d\n", nr_irqs);
+
+	omap_init_irq(res.start, nr_irqs, of_node_get(node));
+
+	return 0;
+}
+
 #ifdef CONFIG_ARCH_OMAP3
 static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
 
-- 
1.7.0.4


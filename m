From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/4] ARM: OMAP2/3: intc: Add DT support for TI interrupt controller
Date: Wed, 7 Dec 2011 21:50:47 +0100
Message-ID: <1323291049-24964-3-git-send-email-b-cousson@ti.com>
References: <1323291049-24964-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58736 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757963Ab1LGUwP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 15:52:15 -0500
In-Reply-To: <1323291049-24964-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, rob.herring@calxeda.com
Cc: devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Add a function to initialize the OMAP2/3 interrupt controller (INTC)
using a device tree node.

Replace some printk() with the proper pr_ macro.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/arm/omap/intc.txt          |   27 +++++++++++++++
 arch/arm/mach-omap2/common.h                       |   10 ++++++
 arch/arm/mach-omap2/irq.c                          |   35 ++++++++++++++++++--
 3 files changed, 69 insertions(+), 3 deletions(-)
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
index 012bac7..bcfccc2 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -156,6 +156,16 @@ void omap3_intc_resume_idle(void);
 void omap2_intc_handle_irq(struct pt_regs *regs);
 void omap3_intc_handle_irq(struct pt_regs *regs);
 
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
 /*
  * wfi used in low power code. Directly opcode is used instead
  * of instruction to avoid mulit-omap build break
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 42b1d65..cafc663 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -17,6 +17,9 @@
 #include <mach/hardware.h>
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/irqdomain.h>
 
 
 /* selected INTC register offsets */
@@ -166,7 +169,7 @@ static void __init omap_init_irq(u32 base, int nr_irqs)
 		/* Static mapping, never released */
 		bank->base_reg = ioremap(base, SZ_4K);
 		if (!bank->base_reg) {
-			printk(KERN_ERR "Could not ioremap irq bank%i\n", i);
+			pr_err("Could not ioremap irq bank%i\n", i);
 			continue;
 		}
 
@@ -179,8 +182,8 @@ static void __init omap_init_irq(u32 base, int nr_irqs)
 		nr_banks++;
 	}
 
-	printk(KERN_INFO "Total of %ld interrupts on %d active controller%s\n",
-	       nr_of_irqs, nr_banks, nr_banks > 1 ? "s" : "");
+	pr_info("Total of %ld interrupts on %d active controller%s\n",
+		nr_of_irqs, nr_banks, nr_banks > 1 ? "s" : "");
 }
 
 void __init omap2_init_irq(void)
@@ -236,6 +239,32 @@ asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs *regs
 	omap_intc_handle_irq(base_addr, regs);
 }
 
+#ifdef CONFIG_OF
+int __init intc_of_init(struct device_node *node, struct device_node *parent)
+{
+	struct resource res;
+	u32 nr_irqs;
+
+	if (WARN_ON(!node))
+		return -ENODEV;
+
+	if (of_address_to_resource(node, 0, &res)) {
+		WARN(1, "unable to get intc registers\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "ti,intc-size", &nr_irqs)) {
+		WARN(1, "unable to get intc-size\n");
+		return -EINVAL;
+	}
+
+	omap_init_irq(res.start, nr_irqs);
+	irq_domain_add_simple(node, 0);
+
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_ARCH_OMAP3
 static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
 
-- 
1.7.0.4


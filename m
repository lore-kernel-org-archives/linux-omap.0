From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 10/14] ARM: omap2+: board-generic: clean up the irq data from board file.
Date: Fri, 6 Jul 2012 14:51:51 +0530
Message-ID: <1341566515-22665-11-git-send-email-santosh.shilimkar@ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50573 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083Ab2GFJXJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 05:23:09 -0400
In-Reply-To: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: R Sricharan <r.sricharan@ti.com>

Move the irq_match arrays and the irq init functions of OMAP 2,3
and 4 based boards out of board-generic.c file and also rename the
irq init function to match the interrupt controller present in
the SOCs.

This is a preparatory patch to add the OMAP5 evm board's irq init
support with device tree.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |   23 ++++++-----------------
 arch/arm/mach-omap2/common.h        |    6 ++++--
 arch/arm/mach-omap2/irq.c           |   13 ++++++++++++-
 arch/arm/mach-omap2/omap4-common.c  |   13 +++++++++++++
 4 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 2f2abfb..716e6b1 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -25,23 +25,12 @@
 #include "common-board-devices.h"
 
 #if !(defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
-#define omap_intc_of_init	NULL
+#define intc_of_init	NULL
 #endif
 #ifndef CONFIG_ARCH_OMAP4
 #define gic_of_init		NULL
 #endif
 
-static struct of_device_id irq_match[] __initdata = {
-	{ .compatible = "ti,omap2-intc", .data = omap_intc_of_init, },
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{ }
-};
-
-static void __init omap_init_irq(void)
-{
-	of_irq_init(irq_match);
-}
-
 static struct of_device_id omap_dt_match_table[] __initdata = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "ti,omap-infra", },
@@ -65,7 +54,7 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap2_timer,
@@ -84,7 +73,7 @@ DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap243x_map_io,
 	.init_early	= omap2430_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap2_timer,
@@ -103,7 +92,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap3_timer,
@@ -122,7 +111,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= am33xx_map_io,
 	.init_early	= am33xx_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap3_am33xx_timer,
@@ -140,7 +129,7 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
-	.init_irq	= omap_init_irq,
+	.init_irq	= omap_gic_of_init,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap4430_init_late,
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 960f984..1f65b18 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -239,6 +239,8 @@ void omap3_intc_prepare_idle(void);
 void omap3_intc_resume_idle(void);
 void omap2_intc_handle_irq(struct pt_regs *regs);
 void omap3_intc_handle_irq(struct pt_regs *regs);
+void omap_intc_of_init(void);
+void omap_gic_of_init(void);
 
 #ifdef CONFIG_CACHE_L2X0
 extern void __iomem *omap4_get_l2cache_base(void);
@@ -246,10 +248,10 @@ extern void __iomem *omap4_get_l2cache_base(void);
 
 struct device_node;
 #ifdef CONFIG_OF
-int __init omap_intc_of_init(struct device_node *node,
+int __init intc_of_init(struct device_node *node,
 			     struct device_node *parent);
 #else
-int __init omap_intc_of_init(struct device_node *node,
+int __init intc_of_init(struct device_node *node,
 			     struct device_node *parent)
 {
 	return 0;
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index d5b34fe..8467beb 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -21,6 +21,7 @@
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <mach/hardware.h>
 
@@ -258,7 +259,7 @@ asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs *regs
 	omap_intc_handle_irq(base_addr, regs);
 }
 
-int __init omap_intc_of_init(struct device_node *node,
+int __init intc_of_init(struct device_node *node,
 			     struct device_node *parent)
 {
 	struct resource res;
@@ -280,6 +281,16 @@ int __init omap_intc_of_init(struct device_node *node,
 	return 0;
 }
 
+static struct of_device_id irq_match[] __initdata = {
+	{ .compatible = "ti,omap2-intc", .data = intc_of_init, },
+	{ }
+};
+
+void __init omap_intc_of_init(void)
+{
+	of_irq_init(irq_match);
+}
+
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
 static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
 
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index a8161e5..f38d659 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -21,6 +21,8 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
 
 #include <plat/irqs.h>
 #include <plat/sram.h>
@@ -210,6 +212,17 @@ static int __init omap4_sar_ram_init(void)
 }
 early_initcall(omap4_sar_ram_init);
 
+static struct of_device_id irq_match[] __initdata = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{ }
+};
+
+void __init omap_gic_of_init(void)
+{
+	omap_wakeupgen_init();
+	of_irq_init(irq_match);
+}
+
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 {
-- 
1.7.9.5


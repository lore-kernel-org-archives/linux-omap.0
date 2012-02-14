From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 4/4] ARM: OMAP2+: board-generic: Use of_irq_init API
Date: Tue, 14 Feb 2012 18:56:12 +0100
Message-ID: <1329242172-4214-5-git-send-email-b-cousson@ti.com>
References: <1329242172-4214-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48805 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754610Ab2BNR4x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 12:56:53 -0500
In-Reply-To: <1329242172-4214-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, rob.herring@calxeda.com
Cc: grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Use the of_irq_init API introduced in 3.2 to handle
interrupt-controller with DT.
Update the irq_match table to map the proper XXX_of_init
functions for INTC and GIC drivers.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-omap2/board-generic.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 02d7e82..cf08921 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -12,6 +12,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/io.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
 #include <linux/i2c/twl.h>
@@ -24,6 +25,17 @@
 #include "common.h"
 #include "common-board-devices.h"
 
+static struct of_device_id irq_match[] __initdata = {
+	{ .compatible = "ti,omap2-intc", .data = intc_of_init, },
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{ }
+};
+
+static void __init omap_init_irq(void)
+{
+	of_irq_init(irq_match);
+}
+
 /*
  * XXX: Still needed to boot until the i2c & twl driver is adapted to
  * device-tree
@@ -58,18 +70,8 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
 	{ }
 };
 
-static struct of_device_id intc_match[] __initdata = {
-	{ .compatible = "ti,omap3-intc", },
-	{ .compatible = "arm,cortex-a9-gic", },
-	{ }
-};
-
 static void __init omap_generic_init(void)
 {
-	struct device_node *node = of_find_matching_node(NULL, intc_match);
-	if (node)
-		irq_domain_add_legacy(node, 32, 0, 0, &irq_domain_simple_ops, NULL);
-
 	omap_sdrc_init(NULL, NULL);
 
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
@@ -101,7 +103,7 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
-	.init_irq	= omap2_init_irq,
+	.init_irq	= omap_init_irq,
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap2_timer,
@@ -120,7 +122,7 @@ DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap243x_map_io,
 	.init_early	= omap2430_init_early,
-	.init_irq	= omap2_init_irq,
+	.init_irq	= omap_init_irq,
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap2_timer,
@@ -139,7 +141,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
-	.init_irq	= omap3_init_irq,
+	.init_irq	= omap_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_init,
 	.timer		= &omap3_timer,
@@ -158,7 +160,7 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
-	.init_irq	= gic_init_irq,
+	.init_irq	= omap_init_irq,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap4_init,
 	.timer		= &omap4_timer,
-- 
1.7.0.4


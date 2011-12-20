From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 5/5] ARM: OMAP2+: board-generic: Use of_irq_init API
Date: Tue, 20 Dec 2011 14:39:58 +0100
Message-ID: <1324388398-2683-6-git-send-email-b-cousson@ti.com>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36267 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab1LTNke (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 08:40:34 -0500
In-Reply-To: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Use the of_irq_init API introduced in 3.2 to handle
interrupt-controller with DT.
Update the irq_match table to map the proper XXX_of_init
functions for INTC and GIC drivers.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-omap2/board-generic.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index e493877..2529017 100644
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
-		irq_domain_add_simple(node, 0);
-
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 
@@ -103,7 +105,7 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
-	.init_irq	= omap2_init_irq,
+	.init_irq	= omap_init_irq,
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap2_timer,
@@ -122,7 +124,7 @@ DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap243x_map_io,
 	.init_early	= omap2430_init_early,
-	.init_irq	= omap2_init_irq,
+	.init_irq	= omap_init_irq,
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap2_timer,
@@ -141,7 +143,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
-	.init_irq	= omap3_init_irq,
+	.init_irq	= omap_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_init,
 	.timer		= &omap3_timer,
@@ -160,7 +162,7 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
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


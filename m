From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 11/14] ARM: OMAP5: board-generic: Add device tree support.
Date: Fri, 6 Jul 2012 14:51:52 +0530
Message-ID: <1341566515-22665-12-git-send-email-santosh.shilimkar@ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50541 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755651Ab2GFJWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 05:22:34 -0400
In-Reply-To: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: R Sricharan <r.sricharan@ti.com>

Adding the minimal support for OMAP5 evm board
with device tree.

Reviewed-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 .../devicetree/bindings/arm/omap/omap.txt          |    3 +++
 arch/arm/mach-omap2/board-generic.c                |   19 +++++++++++++++++++
 arch/arm/mach-omap2/omap4-common.c                 |    1 +
 3 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index e78e8bc..3d450f6 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -47,3 +47,6 @@ Boards:
 
 - AM335X EVM : Software Developement Board for AM335x
   compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3"
+
+- OMAP5 EVM : Evaluation Module
+  compatible = "ti,omap5-evm", "ti,omap5"
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 716e6b1..6f93a20 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -138,3 +138,22 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.restart	= omap_prcm_restart,
 MACHINE_END
 #endif
+
+#ifdef CONFIG_SOC_OMAP5
+static const char *omap5_boards_compat[] __initdata = {
+	"ti,omap5",
+	NULL,
+};
+
+DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= omap5_map_io,
+	.init_early	= omap5_init_early,
+	.init_irq	= omap_gic_of_init,
+	.handle_irq	= gic_handle_irq,
+	.init_machine	= omap_generic_init,
+	.timer		= &omap5_timer,
+	.dt_compat	= omap5_boards_compat,
+	.restart	= omap_prcm_restart,
+MACHINE_END
+#endif
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index f38d659..c29dee9 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -214,6 +214,7 @@ early_initcall(omap4_sar_ram_init);
 
 static struct of_device_id irq_match[] __initdata = {
 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{ .compatible = "arm,cortex-a15-gic", .data = gic_of_init, },
 	{ }
 };
 
-- 
1.7.9.5


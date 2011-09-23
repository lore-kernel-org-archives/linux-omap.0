From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 08/11] OMAP2+: board-generic: Add i2c static init
Date: Fri, 23 Sep 2011 22:23:16 +0200
Message-ID: <1316809399-19579-9-git-send-email-b-cousson@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49180 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260Ab1IWUYo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 16:24:44 -0400
In-Reply-To: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Still needed to boot until the i2c & twl driver is adapted to
device-tree. Otherwise the voltage control code will try to
access the twl and crash.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-generic.c |   41 +++++++++++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index dcbd64c..1186a76 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
+#include <linux/i2c/twl.h>
 
 #include <mach/hardware.h>
 #include <asm/mach/arch.h>
@@ -18,7 +19,31 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <mach/omap4-common.h>
+#include "common-board-devices.h"
 
+/*
+ * XXX: Still needed to boot until the i2c & twl driver is adapted to
+ * device-tree
+ */
+static struct twl4030_platform_data sdp4430_twldata = {
+	.irq_base	= TWL6030_IRQ_BASE,
+	.irq_end	= TWL6030_IRQ_END,
+};
+
+static void __init omap4_i2c_init(void)
+{
+	omap4_pmic_init("twl6030", &sdp4430_twldata);
+}
+
+static struct twl4030_platform_data beagle_twldata = {
+	.irq_base	= TWL4030_IRQ_BASE,
+	.irq_end	= TWL4030_IRQ_END,
+};
+
+static void __init omap3_i2c_init(void)
+{
+	omap3_pmic_init("twl4030", &beagle_twldata);
+}
 
 static struct of_device_id omap_dt_match_table[] __initdata = {
 	{ .compatible = "simple-bus", },
@@ -44,6 +69,18 @@ static void __init omap_generic_init(void)
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
 }
 
+static void __init omap4_init(void)
+{
+	omap4_i2c_init();
+	omap_generic_init();
+}
+
+static void __init omap3_init(void)
+{
+	omap3_i2c_init();
+	omap_generic_init();
+}
+
 #if defined(CONFIG_SOC_OMAP2420)
 static const char *omap242x_boards_compat[] __initdata = {
 	"ti,omap2420",
@@ -89,7 +126,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
-	.init_machine	= omap_generic_init,
+	.init_machine	= omap3_init,
 	.timer		= &omap3_timer,
 	.dt_compat	= omap3_boards_compat,
 MACHINE_END
@@ -106,7 +143,7 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
 	.init_irq	= gic_init_irq,
-	.init_machine	= omap_generic_init,
+	.init_machine	= omap4_init,
 	.timer		= &omap4_timer,
 	.dt_compat	= omap4_boards_compat,
 MACHINE_END
-- 
1.7.0.4


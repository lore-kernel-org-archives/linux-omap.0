From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: OMAP2+: Remove extra ifdefs for board-generic
Date: Thu, 01 Mar 2012 09:42:19 -0800
Message-ID: <20120301174219.12471.29458.stgit@kaulin.local>
References: <20120301174037.12471.72457.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60164 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab2CARmV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 12:42:21 -0500
In-Reply-To: <20120301174037.12471.72457.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

We need just one ifdef for each ARCH_OMAP2/3/4.

Also remove the comment about i2c & twl driver as it's
pretty obvious that we still need some platform data
until drivers are converted to device tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-generic.c |   76 +++++++++++++++--------------------
 1 files changed, 32 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 25d195f..74e1687 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -43,34 +43,6 @@ static void __init omap_init_irq(void)
 	of_irq_init(irq_match);
 }
 
-/*
- * XXX: Still needed to boot until the i2c & twl driver is adapted to
- * device-tree
- */
-#ifdef CONFIG_ARCH_OMAP4
-static struct twl4030_platform_data sdp4430_twldata = {
-	.irq_base	= TWL6030_IRQ_BASE,
-	.irq_end	= TWL6030_IRQ_END,
-};
-
-static void __init omap4_i2c_init(void)
-{
-	omap4_pmic_init("twl6030", &sdp4430_twldata);
-}
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-static struct twl4030_platform_data beagle_twldata = {
-	.irq_base	= TWL4030_IRQ_BASE,
-	.irq_end	= TWL4030_IRQ_END,
-};
-
-static void __init omap3_i2c_init(void)
-{
-	omap3_pmic_init("twl4030", &beagle_twldata);
-}
-#endif
-
 static struct of_device_id omap_dt_match_table[] __initdata = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "ti,omap-infra", },
@@ -84,22 +56,6 @@ static void __init omap_generic_init(void)
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
 }
 
-#ifdef CONFIG_ARCH_OMAP4
-static void __init omap4_init(void)
-{
-	omap4_i2c_init();
-	omap_generic_init();
-}
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-static void __init omap3_init(void)
-{
-	omap3_i2c_init();
-	omap_generic_init();
-}
-#endif
-
 #ifdef CONFIG_SOC_OMAP2420
 static const char *omap242x_boards_compat[] __initdata = {
 	"ti,omap2420",
@@ -139,6 +95,22 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
+static struct twl4030_platform_data beagle_twldata = {
+	.irq_base	= TWL4030_IRQ_BASE,
+	.irq_end	= TWL4030_IRQ_END,
+};
+
+static void __init omap3_i2c_init(void)
+{
+	omap3_pmic_init("twl4030", &beagle_twldata);
+}
+
+static void __init omap3_init(void)
+{
+	omap3_i2c_init();
+	omap_generic_init();
+}
+
 static const char *omap3_boards_compat[] __initdata = {
 	"ti,omap3",
 	NULL,
@@ -158,6 +130,22 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
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
+static void __init omap4_init(void)
+{
+	omap4_i2c_init();
+	omap_generic_init();
+}
+
 static const char *omap4_boards_compat[] __initdata = {
 	"ti,omap4",
 	NULL,


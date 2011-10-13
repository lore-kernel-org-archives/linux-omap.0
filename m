From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] arm: omap: Fix errors and warnings when building for one board
Date: Thu, 13 Oct 2011 20:23:43 +0530
Message-ID: <1318517623-16066-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55855 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755617Ab1JMOyI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 10:54:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

When customizing omap2plus_defconfig to build for only
one board (omap3evm), I came across these warnings and
errors (filenames truncated):

arch/arm/mach-omap2/board-generic.c:76:20: warning: 'omap4_init' defined but not used
arch/arm/mach-omap2/built-in.o: In function `omap2420_init_early':
arch/arm/mach-omap2/io.c:364: undefined reference to `omap2_set_globals_242x'
arch/arm/mach-omap2/io.c:366: undefined reference to `omap2xxx_voltagedomains_init'
arch/arm/mach-omap2/io.c:367: undefined reference to `omap242x_powerdomains_init'
arch/arm/mach-omap2/io.c:368: undefined reference to `omap242x_clockdomains_init'
arch/arm/mach-omap2/io.c:369: undefined reference to `omap2420_hwmod_init'
arch/arm/mach-omap2/built-in.o: In function `omap2430_init_early':
arch/arm/mach-omap2/io.c:376: undefined reference to `omap2_set_globals_243x'
arch/arm/mach-omap2/io.c:378: undefined reference to `omap2xxx_voltagedomains_init'
arch/arm/mach-omap2/io.c:379: undefined reference to `omap243x_powerdomains_init'
arch/arm/mach-omap2/io.c:380: undefined reference to `omap243x_clockdomains_init'
arch/arm/mach-omap2/io.c:381: undefined reference to `omap2430_hwmod_init'
arch/arm/mach-omap2/built-in.o: In function `omap4430_init_early':
arch/arm/mach-omap2/io.c:436: undefined reference to `omap2_set_globals_443x'
arch/arm/mach-omap2/io.c:438: undefined reference to `omap44xx_voltagedomains_init'
arch/arm/mach-omap2/io.c:439: undefined reference to `omap44xx_powerdomains_init'
arch/arm/mach-omap2/io.c:440: undefined reference to `omap44xx_clockdomains_init'
arch/arm/mach-omap2/io.c:441: undefined reference to `omap44xx_hwmod_init'

This patch fixes them.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---

 Adding ifdefs makes the code bit ugly and is prone to propagate
 further. Not sure if DT will help here, but this patch would be
 useful for people trying to build for individual boards.

 Compile tested for OMAP3EVM.

 Applies to linux-omap/master at:
   fb4df0f : ARM: OMAP1: Fix warnings about enabling 32 KiHz timer


 arch/arm/mach-omap2/board-generic.c |    8 ++++++++
 arch/arm/mach-omap2/io.c            |    6 ++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index d9ccb9d..b39ce79 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -34,20 +34,24 @@ static struct twl4030_platform_data sdp4430_twldata = {
 	.irq_end	= TWL6030_IRQ_END,
 };
 
+#if defined(CONFIG_ARCH_OMAP4)
 static void __init omap4_i2c_init(void)
 {
 	omap4_pmic_init("twl6030", &sdp4430_twldata);
 }
+#endif
 
 static struct twl4030_platform_data beagle_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 };
 
+#if defined(CONFIG_ARCH_OMAP3)
 static void __init omap3_i2c_init(void)
 {
 	omap3_pmic_init("twl4030", &beagle_twldata);
 }
+#endif
 
 static struct of_device_id omap_dt_match_table[] __initdata = {
 	{ .compatible = "simple-bus", },
@@ -73,17 +77,21 @@ static void __init omap_generic_init(void)
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
 }
 
+#if defined(CONFIG_ARCH_OMAP4)
 static void __init omap4_init(void)
 {
 	omap4_i2c_init();
 	omap_generic_init();
 }
+#endif
 
+#if defined(CONFIG_ARCH_OMAP3)
 static void __init omap3_init(void)
 {
 	omap3_i2c_init();
 	omap_generic_init();
 }
+#endif
 
 #if defined(CONFIG_SOC_OMAP2420)
 static const char *omap242x_boards_compat[] __initdata = {
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index aa96538..ef3fb1e 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -359,6 +359,7 @@ static void __init omap_hwmod_init_postsetup(void)
 	omap_pm_if_early_init();
 }
 
+#if defined(CONFIG_ARCH_OMAP2)
 void __init omap2420_init_early(void)
 {
 	omap2_set_globals_242x();
@@ -382,11 +383,13 @@ void __init omap2430_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap2430_clk_init();
 }
+#endif
 
 /*
  * Currently only board-omap3beagle.c should call this because of the
  * same machine_id for 34xx and 36xx beagle.. Will get fixed with DT.
  */
+#if defined(CONFIG_ARCH_OMAP3)
 void __init omap3_init_early(void)
 {
 	omap2_set_globals_3xxx();
@@ -430,7 +433,9 @@ void __init ti816x_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap3xxx_clk_init();
 }
+#endif
 
+#if defined(CONFIG_ARCH_OMAP4)
 void __init omap4430_init_early(void)
 {
 	omap2_set_globals_443x();
@@ -442,6 +447,7 @@ void __init omap4430_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap4xxx_clk_init();
 }
+#endif
 
 void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1)
-- 
1.7.0.4


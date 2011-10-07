From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/7] ARM: OMAP: Avoid cpu_is_omapxxxx usage until map_io is
	done
Date: Fri, 07 Oct 2011 12:45:48 -0700
Message-ID: <20111007194548.18205.27365.stgit@kaulin.local>
References: <20111007194242.18205.64009.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42953 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753853Ab1JGTpu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 15:45:50 -0400
In-Reply-To: <20111007194242.18205.64009.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This way we don't need to initialize SoC detection early
and can start using generic map_io.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c  |    7 --
 arch/arm/mach-omap2/io.c                 |   95 +++++++++++++++---------------
 arch/arm/plat-omap/include/plat/common.h |    1 
 3 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 4a5d75f..4c25742 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -444,11 +444,6 @@ static struct platform_device keys_gpio = {
 	},
 };
 
-static void __init omap3_beagle_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
-
 static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&leds_gpio,
 	&keys_gpio,
@@ -555,7 +550,7 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.boot_params	= 0x80000100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
-	.init_early	= omap3_beagle_init_early,
+	.init_early	= omap3_init_early,
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap3_beagle_init,
 	.timer		= &omap3_secure_timer,
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 15f91c4..e8123d0 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -248,9 +248,6 @@ static void __init _omap2_map_common_io(void)
 	 */
 	local_flush_tlb_all();
 	flush_cache_all();
-
-	omap2_check_revision();
-	omap_sram_init();
 }
 
 #ifdef CONFIG_SOC_OMAP2420
@@ -337,33 +334,15 @@ static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
 /* See irq.c, omap4-common.c and entry-macro.S */
 void __iomem *omap_irq_base;
 
-void __init omap2_init_common_infrastructure(void)
+static void __init omap_common_init_early(void)
 {
-	u8 postsetup_state;
+	omap2_check_revision();
+	omap_sram_init();
+}
 
-	if (cpu_is_omap242x()) {
-		omap2xxx_voltagedomains_init();
-		omap242x_powerdomains_init();
-		omap242x_clockdomains_init();
-		omap2420_hwmod_init();
-	} else if (cpu_is_omap243x()) {
-		omap2xxx_voltagedomains_init();
-		omap243x_powerdomains_init();
-		omap243x_clockdomains_init();
-		omap2430_hwmod_init();
-	} else if (cpu_is_omap34xx()) {
-		omap3xxx_voltagedomains_init();
-		omap3xxx_powerdomains_init();
-		omap3xxx_clockdomains_init();
-		omap3xxx_hwmod_init();
-	} else if (cpu_is_omap44xx()) {
-		omap44xx_voltagedomains_init();
-		omap44xx_powerdomains_init();
-		omap44xx_clockdomains_init();
-		omap44xx_hwmod_init();
-	} else {
-		pr_err("Could not init hwmod data - unknown SoC\n");
-        }
+static void __init omap_hwmod_init_postsetup(void)
+{
+	u8 postsetup_state;
 
 	/* Set the default postsetup state for all hwmods */
 #ifdef CONFIG_PM_RUNTIME
@@ -392,57 +371,79 @@ void __init omap2_init_common_infrastructure(void)
 				     &postsetup_state);
 
 	omap_pm_if_early_init();
-
-	if (cpu_is_omap2420())
-		omap2420_clk_init();
-	else if (cpu_is_omap2430())
-		omap2430_clk_init();
-	else if (cpu_is_omap34xx())
-		omap3xxx_clk_init();
-	else if (cpu_is_omap44xx())
-		omap4xxx_clk_init();
-	else
-		pr_err("Could not init clock framework - unknown SoC\n");
 }
 
 void __init omap2420_init_early(void)
 {
-	omap2_init_common_infrastructure();
+	omap_common_init_early();
+	omap2xxx_voltagedomains_init();
+	omap242x_powerdomains_init();
+	omap242x_clockdomains_init();
+	omap2420_hwmod_init();
+	omap_hwmod_init_postsetup();
+	omap2420_clk_init();
 }
 
 void __init omap2430_init_early(void)
 {
-	omap2_init_common_infrastructure();
+	omap_common_init_early();
+	omap2xxx_voltagedomains_init();
+	omap243x_powerdomains_init();
+	omap243x_clockdomains_init();
+	omap2430_hwmod_init();
+	omap_hwmod_init_postsetup();
+	omap2430_clk_init();
+}
+
+/*
+ * Currently only board-omap3beagle.c should call this because of the
+ * same machine_id for 34xx and 36xx beagle.. Will get fixed with DT.
+ */
+void __init omap3_init_early(void)
+{
+	omap_common_init_early();
+	omap3xxx_voltagedomains_init();
+	omap3xxx_powerdomains_init();
+	omap3xxx_clockdomains_init();
+	omap3xxx_hwmod_init();
+	omap_hwmod_init_postsetup();
+	omap3xxx_clk_init();
 }
 
 void __init omap3430_init_early(void)
 {
-	omap2_init_common_infrastructure();
+	omap3_init_early();
 }
 
 void __init omap35xx_init_early(void)
 {
-	omap2_init_common_infrastructure();
+	omap3_init_early();
 }
 
 void __init omap3630_init_early(void)
 {
-	omap2_init_common_infrastructure();
+	omap3_init_early();
 }
 
 void __init am35xx_init_early(void)
 {
-	omap2_init_common_infrastructure();
+	omap3_init_early();
 }
 
 void __init ti816x_init_early(void)
 {
-	omap2_init_common_infrastructure();
+	omap3_init_early();
 }
 
 void __init omap4430_init_early(void)
 {
-	omap2_init_common_infrastructure();
+	omap_common_init_early();
+	omap44xx_voltagedomains_init();
+	omap44xx_powerdomains_init();
+	omap44xx_clockdomains_init();
+	omap44xx_hwmod_init();
+	omap_hwmod_init_postsetup();
+	omap4xxx_clk_init();
 }
 
 void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index abda2c7..5eac355 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -50,6 +50,7 @@ void omap2430_init_early(void);
 void omap3430_init_early(void);
 void omap35xx_init_early(void);
 void omap3630_init_early(void);
+void omap3_init_early(void);	/* Do not use this one */
 void am35xx_init_early(void);
 void ti816x_init_early(void);
 void omap4430_init_early(void);


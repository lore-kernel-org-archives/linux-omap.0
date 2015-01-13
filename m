From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/7] ARM: OMAP2+: Fix ti81xx class type
Date: Tue, 13 Jan 2015 15:13:54 -0800
Message-ID: <1421190837-4692-5-git-send-email-tony@atomide.com>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29201 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751691AbbAMXR5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 18:17:57 -0500
In-Reply-To: <1421190837-4692-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

Otherwise it will return true for cpu_is_omap34xx() which we don't
want for the clocks and hwmod. It's closer to am33xx for the clocks
and hwmod than to the omap34xx. We also want to be able to detect
814x and 816x separately as at least the clocks are different with
814x using a apll and 816x using a fapll for the source clocks.

Note that we can also remove omap3xxx_clk_init() call as it's wrong
and ti81xx are booting in device tree only mode.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h                |  3 ++-
 arch/arm/mach-omap2/io.c                    | 25 +++++++++++++++++++++----
 arch/arm/mach-omap2/powerdomains3xxx_data.c |  2 +-
 arch/arm/mach-omap2/soc.h                   |  4 ++--
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 377eea8..900ebdd 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -110,7 +110,8 @@ void omap3630_init_early(void);
 void omap3_init_early(void);	/* Do not use this one */
 void am33xx_init_early(void);
 void am35xx_init_early(void);
-void ti81xx_init_early(void);
+void ti814x_init_early(void);
+void ti816x_init_early(void);
 void am33xx_init_early(void);
 void am43xx_init_early(void);
 void am43xx_init_late(void);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index a1bd6af..b957776 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -492,9 +492,28 @@ void __init am35xx_init_early(void)
 		omap_clk_soc_init = am35xx_dt_clk_init;
 }
 
-void __init ti81xx_init_early(void)
+void __init ti814x_init_early(void)
 {
-	omap2_set_globals_tap(OMAP343X_CLASS,
+	omap2_set_globals_tap(TI814X_CLASS,
+			      OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
+				  NULL);
+	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE));
+	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
+	omap3xxx_check_revision();
+	ti81xx_check_features();
+	omap3xxx_voltagedomains_init();
+	omap3xxx_powerdomains_init();
+	omap3xxx_clockdomains_init();
+	omap3xxx_hwmod_init();
+	omap_hwmod_init_postsetup();
+	if (of_have_populated_dt())
+		omap_clk_soc_init = ti81xx_dt_clk_init;
+}
+
+void __init ti816x_init_early(void)
+{
+	omap2_set_globals_tap(TI816X_CLASS,
 			      OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE));
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
 				  NULL);
@@ -509,8 +528,6 @@ void __init ti81xx_init_early(void)
 	omap_hwmod_init_postsetup();
 	if (of_have_populated_dt())
 		omap_clk_soc_init = ti81xx_dt_clk_init;
-	else
-		omap_clk_soc_init = omap3xxx_clk_init;
 }
 
 void __init omap3_init_late(void)
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 328c103..70bc706 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -464,7 +464,7 @@ void __init omap3xxx_powerdomains_init(void)
 {
 	unsigned int rev;
 
-	if (!cpu_is_omap34xx())
+	if (!cpu_is_omap34xx() && !cpu_is_ti81xx())
 		return;
 
 	pwrdm_register_platform_funcs(&omap3_pwrdm_operations);
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index c1a3b44..f97654d 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -423,13 +423,13 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP3630_REV_ES1_1	(OMAP363X_CLASS | (0x1 << 8))
 #define OMAP3630_REV_ES1_2	(OMAP363X_CLASS | (0x2 << 8))
 
-#define TI816X_CLASS		0x81600034
+#define TI816X_CLASS		0x81600081
 #define TI8168_REV_ES1_0	TI816X_CLASS
 #define TI8168_REV_ES1_1	(TI816X_CLASS | (0x1 << 8))
 #define TI8168_REV_ES2_0	(TI816X_CLASS | (0x2 << 8))
 #define TI8168_REV_ES2_1	(TI816X_CLASS | (0x3 << 8))
 
-#define TI814X_CLASS		0x81400034
+#define TI814X_CLASS		0x81400081
 #define TI8148_REV_ES1_0	TI814X_CLASS
 #define TI8148_REV_ES2_0	(TI814X_CLASS | (0x1 << 8))
 #define TI8148_REV_ES2_1	(TI814X_CLASS | (0x2 << 8))
-- 
2.1.4


From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/3] OMAP3: PM: Fix the way OPP rate tables are initialized
Date: Mon, 12 Oct 2009 19:12:38 +0530
Message-ID: <1255354960-7873-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43374 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756622AbZJLNnW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Oct 2009 09:43:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Rajendra Nayak <rnayak@ti.com>

Remove rate tables being passed to omap2_init_common_hw, instead
pass them as arguments to omap3_pm_early_init and
call this function from board files.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c     |    5 +++--
 arch/arm/mach-omap2/board-apollon.c     |    3 ++-
 arch/arm/mach-omap2/board-generic.c     |    3 ++-
 arch/arm/mach-omap2/board-h4.c          |    3 ++-
 arch/arm/mach-omap2/board-ldp.c         |    3 ++-
 arch/arm/mach-omap2/board-omap3beagle.c |    5 +++--
 arch/arm/mach-omap2/board-omap3evm.c    |    5 +++--
 arch/arm/mach-omap2/board-overo.c       |    4 +++-
 arch/arm/mach-omap2/board-rx51.c        |    6 ++++--
 arch/arm/mach-omap2/board-zoom2.c       |    6 ++++--
 arch/arm/mach-omap2/io.c                |    6 +-----
 arch/arm/mach-omap2/pm.h                |    4 +++-
 arch/arm/mach-omap2/pm34xx.c            |   16 +++++++++++-----
 arch/arm/plat-omap/include/mach/io.h    |    5 +----
 14 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 97b61cd..425f5ac 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -185,8 +185,9 @@ static void __init omap_3430sdp_init_irq(void)
 {
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
-	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL, omap3_mpu_rate_table,
-			     omap3_dsp_rate_table, omap3_l3_rate_table);
+	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
+				 omap3_l3_rate_table);
+	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 9cc984f..6a5c338 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -267,7 +267,8 @@ static void __init omap_apollon_init_irq(void)
 {
 	omap_board_config = apollon_config;
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
+	omap3_pm_early_init(NULL, NULL, NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	apollon_init_smc91x();
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 5a834c1..55e1f11 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -38,7 +38,8 @@ static void __init omap_generic_init_irq(void)
 {
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
+	omap3_pm_early_init(NULL, NULL, NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 }
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 500aebb..e8b5f6a 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -313,7 +313,8 @@ static void __init omap_h4_init_irq(void)
 {
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
+	omap3_pm_early_init(NULL, NULL, NULL)
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	h4_init_flash();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 335185f..009fe39 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -289,7 +289,8 @@ static void __init omap_ldp_init_irq(void)
 {
 	omap_board_config = ldp_config;
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
+	omap3_pm_early_init(NULL, NULL, NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	ldp_init_smsc911x();
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 9ba2514..097810b 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -351,9 +351,10 @@ static void __init omap3_beagle_init_irq(void)
 {
 	omap_board_config = omap3_beagle_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
+	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
+				omap3_l3_rate_table);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
-			     omap3_dsp_rate_table, omap3_l3_rate_table);
+			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3900151..3d05923 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -290,8 +290,9 @@ static void __init omap3_evm_init_irq(void)
 {
 	omap_board_config = omap3_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, omap3_mpu_rate_table,
-	                     omap3_dsp_rate_table, omap3_l3_rate_table);
+	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
+				omap3_l3_rate_table);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	omap3evm_init_smc911x();
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 2cdced7..d487942 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -49,6 +49,7 @@
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
+#include "pm.h"
 
 #define OVERO_GPIO_BT_XGATE	15
 #define OVERO_GPIO_W2W_NRESET	16
@@ -374,8 +375,9 @@ static void __init overo_init_irq(void)
 {
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
+	omap3_pm_early_init(NULL, NULL, NULL);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params, NULL, NULL, NULL);
+			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 7ae3ab8..26313ee 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -33,6 +33,7 @@
 #include <mach/usb.h>
 
 #include "omap3-opp.h"
+#include "pm.h"
 
 #define RX51_GPIO_SLEEP_IND 162
 
@@ -85,9 +86,10 @@ static void __init rx51_init_irq(void)
 {
 	omap_board_config = rx51_config;
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
+	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
+				omap3_l3_rate_table);
 	omap2_init_common_hw(rx51_get_sdram_timings(),
-			     rx51_get_sdram_timings(), omap3_mpu_rate_table,
-			     omap3_dsp_rate_table, omap3_l3_rate_table);
+			     rx51_get_sdram_timings());
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 97df2e4..607f144 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -26,6 +26,7 @@
 
 #include "mmc-twl4030.h"
 #include "omap3-opp.h"
+#include "pm.h"
 
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
@@ -214,8 +215,9 @@ static void __init omap_zoom2_init_irq(void)
 {
 	omap_board_config = zoom2_config;
 	omap_board_config_size = ARRAY_SIZE(zoom2_config);
-	omap2_init_common_hw(NULL, NULL, omap3_mpu_rate_table,
-	                     omap3_dsp_rate_table, omap3_l3_rate_table);
+	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
+				omap3_l3_rate_table);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 8e0d005..3567bbe 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -283,10 +283,7 @@ static int __init _omap2_init_reprogram_sdrc(void)
 }
 
 void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
-				 struct omap_sdrc_params *sdrc_cs1,
-				 struct omap_opp *mpu_opps,
-				 struct omap_opp *dsp_opps,
-				 struct omap_opp *l3_opps)
+				 struct omap_sdrc_params *sdrc_cs1)
 {
 	struct omap_hwmod **hwmods = NULL;
 
@@ -301,7 +298,6 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	/* The OPP tables have to be registered before a clk init */
 	omap_hwmod_init(hwmods);
 	omap2_mux_init();
-	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index f8d11a2..f535a14 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -84,5 +84,7 @@ extern unsigned int omap34xx_suspend_sz;
 extern unsigned int save_secure_ram_context_sz;
 extern unsigned int omap24xx_cpu_suspend_sz;
 extern unsigned int omap34xx_cpu_suspend_sz;
-
+void omap3_pm_early_init(struct omap_opp *mpu_opps,
+			 struct omap_opp *dsp_opps,
+			 struct omap_opp *l3_opps);
 #endif
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index cea3bca..2242d23 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -39,6 +39,7 @@
 #include <mach/gpmc.h>
 #include <mach/dma.h>
 #include <mach/dmtimer.h>
+#include <mach/omap-pm.h>
 
 #include <asm/tlbflush.h>
 
@@ -1229,6 +1230,11 @@ err2:
 		list_del(&pwrst->node);
 		kfree(pwrst);
 	}
+
+	/* Do this late in the pm init */
+	pm_dbg_regset_init(1);
+	pm_dbg_regset_init(2);
+
 	return ret;
 }
 
@@ -1275,20 +1281,20 @@ static void __init configure_vc(void)
 	prm_write_mod_reg(prm_setup.voltsetup2, OMAP3430_GR_MOD,
 			OMAP3_PRM_VOLTSETUP2_OFFSET);
 
-	pm_dbg_regset_init(1);
-	pm_dbg_regset_init(2);
 }
 
-static int __init omap3_pm_early_init(void)
+void omap3_pm_early_init(struct omap_opp *mpu_opps,
+			 struct omap_opp *dsp_opps,
+			 struct omap_opp *l3_opps)
 {
 	prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL, OMAP3430_GR_MOD,
 				OMAP3_PRM_POLCTRL_OFFSET);
 
 	configure_vc();
+	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
 
-	return 0;
+	return;
 }
 
-arch_initcall(omap3_pm_early_init);
 late_initcall(omap3_pm_init);
 
diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index 9699030..fce5f7f 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -229,10 +229,7 @@ extern void omap1_init_common_hw(void);
 
 extern void omap2_map_common_io(void);
 extern void omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
-				 struct omap_sdrc_params *sdrc_cs1,
-				 struct omap_opp *mpu_opps,
-				 struct omap_opp *dsp_opps,
-				 struct omap_opp *l3_opps);
+				 struct omap_sdrc_params *sdrc_cs1);
 
 #define __arch_ioremap(p,s,t)	omap_ioremap(p,s,t)
 #define __arch_iounmap(v)	omap_iounmap(v)
-- 
1.5.4.7


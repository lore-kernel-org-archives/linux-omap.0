From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] io: remove redundant params in omap2_init_common_hw
Date: Sat, 19 Dec 2009 18:40:52 +0530
Message-ID: <1261228253-30283-2-git-send-email-nm@ti.com>
References: <1261228253-30283-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52821 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735AbZLSNLG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Dec 2009 08:11:06 -0500
In-Reply-To: <1261228253-30283-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin h <khilman@deeprootsystems.com>
Cc: linux omap <linux-omap@vger.kernel.org>, Romit Dasgupta <romit@ti.com>, Ambresh k <ambresh@ti.com>, Nishanth Menon <nm@ti.com>

dsp_opp, mpu_opp, l3_opps are now not used by omap2_init_common_hw,
remove them

Signed-off-by: Nishanth Menon <nm@ti.com>
Cc: Ambresh k <ambresh@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c      |    3 +--
 arch/arm/mach-omap2/board-3630sdp.c      |    4 +---
 arch/arm/mach-omap2/board-apollon.c      |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c       |    3 +--
 arch/arm/mach-omap2/board-generic.c      |    2 +-
 arch/arm/mach-omap2/board-h4.c           |    2 +-
 arch/arm/mach-omap2/board-ldp.c          |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c  |    3 +--
 arch/arm/mach-omap2/board-omap3evm.c     |    3 +--
 arch/arm/mach-omap2/board-omap3pandora.c |    3 +--
 arch/arm/mach-omap2/board-overo.c        |    2 +-
 arch/arm/mach-omap2/board-rx51.c         |    5 +----
 arch/arm/mach-omap2/board-zoom2.c        |    3 +--
 arch/arm/mach-omap2/board-zoom3.c        |    4 +---
 arch/arm/mach-omap2/io.c                 |    5 +----
 arch/arm/plat-omap/include/plat/io.h     |    5 +----
 16 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 451e909..c334536 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -345,8 +345,7 @@ static void __init omap_3430sdp_init_irq(void)
 	omap3_pm_init_opp_table();
 	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
 	omap3_pm_init_vc(&omap3_setuptime_table);
-	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL, omap3_mpu_rate_table,
-			     omap3_dsp_rate_table, omap3_l3_rate_table);
+	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index f8f5e48..805512b 100755
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -86,9 +86,7 @@ static void __init omap_sdp_init_irq(void)
 	/* TODO: Add RET, OFF, cpu_idle params */
 
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
-			     h8mbx00u0mer0em_sdrc_params,
-			     omap3_mpu_rate_table, omap3_dsp_rate_table,
-			     omap3_l3_rate_table);
+			     h8mbx00u0mer0em_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 31120b9..fbbd68d 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -277,7 +277,7 @@ static void __init omap_apollon_init_irq(void)
 {
 	omap_board_config = apollon_config;
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	apollon_init_smc91x();
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 9a15c53..2626a9f 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -471,8 +471,7 @@ static void __init cm_t35_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(cm_t35_config);
 
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params,
-			     NULL, NULL, NULL);
+			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index fd23535..7e6e6ca 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -38,7 +38,7 @@ static void __init omap_generic_init_irq(void)
 {
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 }
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 3cdb9ea..cfb7f12 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -313,7 +313,7 @@ static void __init omap_h4_init_irq(void)
 {
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	h4_init_flash();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 3b4e2c7..995d4a2 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -290,7 +290,7 @@ static void __init omap_ldp_init_irq(void)
 {
 	omap_board_config = ldp_config;
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	ldp_init_smsc911x();
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index cd62c7b..c4079c6 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -363,8 +363,7 @@ static void __init omap3_beagle_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
 	omap3_pm_init_opp_table();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
-			     omap3_dsp_rate_table, omap3_l3_rate_table);
+			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 843c0b9..faa541e 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -405,8 +405,7 @@ static void __init omap3_evm_init_irq(void)
 	omap_board_config = omap3_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
 	omap3_pm_init_opp_table();
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, omap3_mpu_rate_table,
-	                     omap3_dsp_rate_table, omap3_l3_rate_table);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 9d361a1..ef17cf1 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -371,8 +371,7 @@ static struct spi_board_info omap3pandora_spi_board_info[] __initdata = {
 static void __init omap3pandora_init_irq(void)
 {
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params,
-			     NULL, NULL, NULL);
+			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index e0aebc3..d192dd9 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -385,7 +385,7 @@ static void __init overo_init_irq(void)
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params, NULL, NULL, NULL);
+			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 1c5333f..47bcbf9 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -108,10 +108,7 @@ static void __init rx51_init_irq(void)
 	omap3_pm_init_opp_table();
 	omap3_pm_init_cpuidle(rx51_cpuidle_params);
 	sdrc_params = rx51_get_sdram_timings();
-	omap2_init_common_hw(sdrc_params, sdrc_params,
-			     omap3_mpu_rate_table,
-			     omap3_dsp_rate_table,
-			     omap3_l3_rate_table);
+	omap2_init_common_hw(sdrc_params, sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 3ce3dca..573c6f6 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -32,8 +32,7 @@ static void __init omap_zoom2_init_irq(void)
 {
 	omap3_pm_init_opp_table();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-				 mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
-				 omap3_dsp_rate_table, omap3_l3_rate_table);
+				 mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 54292d3..2d20602 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -44,9 +44,7 @@ static void __init omap_zoom_init_irq(void)
 	/* TODO: Add RET, OFF, cpu_idle params */
 
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
-			     h8mbx00u0mer0em_sdrc_params,
-			     omap3_mpu_rate_table, omap3_dsp_rate_table,
-			     omap3_l3_rate_table);
+			     h8mbx00u0mer0em_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index a45ff98..fad4192 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -302,10 +302,7 @@ static int __init _omap2_init_reprogram_sdrc(void)
 }
 
 void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
-				 struct omap_sdrc_params *sdrc_cs1,
-				 struct omap_opp *mpu_opps,
-				 struct omap_opp *dsp_opps,
-				 struct omap_opp *l3_opps)
+				 struct omap_sdrc_params *sdrc_cs1)
 {
 	struct omap_hwmod **hwmods = NULL;
 
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index b455433..6c77b03 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -275,10 +275,7 @@ extern void omap1_init_common_hw(void);
 
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
1.6.3.3


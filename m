From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 8/9] omap3: pm: introduce dynamic OPP
Date: Wed, 11 Nov 2009 23:45:20 -0600
Message-ID: <1258004721-7315-9-git-send-email-nm@ti.com>
References: <1258004721-7315-1-git-send-email-nm@ti.com>
 <1258004721-7315-2-git-send-email-nm@ti.com>
 <1258004721-7315-3-git-send-email-nm@ti.com>
 <1258004721-7315-4-git-send-email-nm@ti.com>
 <1258004721-7315-5-git-send-email-nm@ti.com>
 <1258004721-7315-6-git-send-email-nm@ti.com>
 <1258004721-7315-7-git-send-email-nm@ti.com>
 <1258004721-7315-8-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46930 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbZKLFpq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 00:45:46 -0500
In-Reply-To: <1258004721-7315-8-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

OPP tables have been used as static arrays till now this causes
limitations in terms of ability to dynamically making decisions
for cpu types and populating it with the right values. This
implementation is based on the discussions in the thread:
http://marc.info/?l=linux-omap&m=125482970102327&w=2
inputs from Romit, Benoit, Kevin, Sanjeev, Santosh acked.

omap3_pm_init_opp_table is introduced here, and the default omap3
tables have been renamed to omap34xx_ tables, original omap3_xx
tables are now dynamically allocated and populated.

Corresponding board files calling omap2_init_common_hw with the
active opp table params have been updated with this patch.

This now paves way to introduce 3630 OPP tables.

Tested on: SDP3430

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c     |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c |    1 +
 arch/arm/mach-omap2/board-omap3evm.c    |    1 +
 arch/arm/mach-omap2/board-rx51.c        |    2 ++
 arch/arm/mach-omap2/board-zoom2.c       |    2 ++
 arch/arm/mach-omap2/omap3-opp.h         |    6 +++---
 arch/arm/mach-omap2/pm.h                |    8 ++++++++
 arch/arm/mach-omap2/pm34xx.c            |   31 ++++++++++++++++++++++++++++---
 8 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 11f0dc5..de1b632 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -222,6 +222,7 @@ static void __init omap_3430sdp_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	omap3_pm_init_vc(&omap3_setuptime_table);
 	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
+	omap3_pm_init_opp_table();
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL, omap3_mpu_rate_table,
 			     omap3_dsp_rate_table, omap3_l3_rate_table);
 	omap_init_irq();
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index d0a95ea..65bab97 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -351,6 +351,7 @@ static void __init omap3_beagle_init_irq(void)
 {
 	omap_board_config = omap3_beagle_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
+	omap3_pm_init_opp_table();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
 			     omap3_dsp_rate_table, omap3_l3_rate_table);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 2c63002..d8318cd 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -336,6 +336,7 @@ static void __init omap3_evm_init_irq(void)
 {
 	omap_board_config = omap3_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
+	omap3_pm_init_opp_table();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, omap3_mpu_rate_table,
 	                     omap3_dsp_rate_table, omap3_l3_rate_table);
 	omap_init_irq();
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 527f0c6..1f24933 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -31,6 +31,7 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 
+#include "pm.h"
 #include "omap3-opp.h"
 
 #define RX51_GPIO_SLEEP_IND 162
@@ -84,6 +85,7 @@ static void __init rx51_init_irq(void)
 {
 	omap_board_config = rx51_config;
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
+	omap3_pm_init_opp_table();
 	omap2_init_common_hw(rx51_get_sdram_timings(),
 			     rx51_get_sdram_timings(), omap3_mpu_rate_table,
 			     omap3_dsp_rate_table, omap3_l3_rate_table);
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index b6801a7..a7e1fee 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -25,6 +25,7 @@
 #include <plat/usb.h>
 
 #include "mmc-twl4030.h"
+#include "pm.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "omap3-opp.h"
 
@@ -215,6 +216,7 @@ static void __init omap_zoom2_init_irq(void)
 {
 	omap_board_config = zoom2_config;
 	omap_board_config_size = ARRAY_SIZE(zoom2_config);
+	omap3_pm_init_opp_table();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 				 mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
 				 omap3_dsp_rate_table, omap3_l3_rate_table);
diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
index 27e2ca5..7f27f44 100644
--- a/arch/arm/mach-omap2/omap3-opp.h
+++ b/arch/arm/mach-omap2/omap3-opp.h
@@ -21,8 +21,8 @@
 #define S83M    83000000
 #define S166M   166000000
 
-extern struct omap_opp omap3_mpu_rate_table[];
-extern struct omap_opp omap3_dsp_rate_table[];
-extern struct omap_opp omap3_l3_rate_table[];
+extern struct omap_opp *omap3_mpu_rate_table;
+extern struct omap_opp *omap3_dsp_rate_table;
+extern struct omap_opp *omap3_l3_rate_table;
 
 #endif
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b576424..1aabf74 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -51,6 +51,14 @@ struct cpuidle_params {
 extern void omap3_pm_init_vc(struct prm_setup_vc *setup_vc);
 extern void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params);
 
+/**
+ * omap3_pm_init_opp_table - OMAP opp table lookup called after
+ * cpu is detected.
+ * Initialize the basic opp table here, board files
+ * could choose to modify opp table after the basic initialization
+ */
+extern void omap3_pm_init_opp_table(void);
+
 extern int resource_set_opp_level(int res, u32 target_level, int flags);
 extern int resource_access_opp_lock(int res, int delta);
 #define resource_lock_opp(res) resource_access_opp_lock(res, 1)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 92f11d7..511137c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -99,7 +99,7 @@ static struct prm_setup_vc prm_setup = {
 	.vdd1_off = 0x00,	/* 0.6v */
 };
 
-struct omap_opp omap3_mpu_rate_table[] = {
+static __initdata struct omap_opp omap34xx_mpu_rate_table[] = {
 	{0, 0, 0, 0},
 	/*OPP1*/
 	{true, S125M, VDD1_OPP1, 0x1E},
@@ -114,7 +114,7 @@ struct omap_opp omap3_mpu_rate_table[] = {
 	{0, 0, 0, 0},
 };
 
-struct omap_opp omap3_l3_rate_table[] = {
+static __initdata struct omap_opp omap34xx_l3_rate_table[] = {
 	{0, 0, 0, 0},
 	/*OPP1*/
 	{false, 0, VDD2_OPP1, 0x1E},
@@ -125,7 +125,7 @@ struct omap_opp omap3_l3_rate_table[] = {
 	{0, 0, 0, 0},
 };
 
-struct omap_opp omap3_dsp_rate_table[] = {
+static __initdata struct omap_opp omap34xx_dsp_rate_table[] = {
 	{0, 0, 0, 0},
 	/*OPP1*/
 	{true, S90M, VDD1_OPP1, 0x1E},
@@ -140,6 +140,10 @@ struct omap_opp omap3_dsp_rate_table[] = {
 	{0, 0, 0, 0},
 };
 
+struct omap_opp *omap3_mpu_rate_table;
+struct omap_opp *omap3_dsp_rate_table;
+struct omap_opp *omap3_l3_rate_table;
+
 static inline void omap3_per_save_context(void)
 {
 	omap_gpio_save_context();
@@ -1276,6 +1280,27 @@ static void __init configure_vc(void)
 	pm_dbg_regset_init(2);
 }
 
+void __init omap3_pm_init_opp_table(void)
+{
+	/* Populate the base CPU rate tables here */
+	omap3_mpu_rate_table = kmalloc(sizeof(omap34xx_mpu_rate_table),
+			GFP_KERNEL);
+	omap3_dsp_rate_table = kmalloc(sizeof(omap34xx_dsp_rate_table),
+			GFP_KERNEL);
+	omap3_l3_rate_table = kmalloc(sizeof(omap34xx_l3_rate_table),
+			GFP_KERNEL);
+
+	BUG_ON(!omap3_mpu_rate_table || !omap3_dsp_rate_table ||
+		!omap3_l3_rate_table);
+
+	memcpy(omap3_mpu_rate_table, omap34xx_mpu_rate_table,
+			sizeof(omap34xx_mpu_rate_table));
+	memcpy(omap3_dsp_rate_table, omap34xx_dsp_rate_table,
+			sizeof(omap34xx_dsp_rate_table));
+	memcpy(omap3_l3_rate_table, omap34xx_l3_rate_table,
+			sizeof(omap34xx_l3_rate_table));
+}
+
 static int __init omap3_pm_early_init(void)
 {
 	prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL, OMAP3430_GR_MOD,
-- 
1.6.3.3


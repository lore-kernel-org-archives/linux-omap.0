From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 8/9 v2] omap3: pm: introduce dynamic OPP
Date: Fri, 13 Nov 2009 00:05:21 -0600
Message-ID: <1258092322-30833-9-git-send-email-nm@ti.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com>
 <1258092322-30833-2-git-send-email-nm@ti.com>
 <1258092322-30833-3-git-send-email-nm@ti.com>
 <1258092322-30833-4-git-send-email-nm@ti.com>
 <1258092322-30833-5-git-send-email-nm@ti.com>
 <1258092322-30833-6-git-send-email-nm@ti.com>
 <1258092322-30833-7-git-send-email-nm@ti.com>
 <1258092322-30833-8-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37985 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631AbZKMGFV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Nov 2009 01:05:21 -0500
In-Reply-To: <1258092322-30833-8-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, SuiLun Lam <s-lam@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

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

Tested on: SDP3430 - SDP3630 boot breaks with this patch
(as SDP3630 needs corresponding correct VDD2 freq w.r.t SDRC clk.
The next patch in this series fixes things)

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: SuiLun Lam <s-lam@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c     |    1 +
 arch/arm/mach-omap2/board-3630sdp.c     |    6 +++++-
 arch/arm/mach-omap2/board-omap3beagle.c |    1 +
 arch/arm/mach-omap2/board-omap3evm.c    |    1 +
 arch/arm/mach-omap2/board-rx51.c        |    1 +
 arch/arm/mach-omap2/board-zoom2.c       |    7 +++++--
 arch/arm/mach-omap2/board-zoom3.c       |    6 +++++-
 arch/arm/mach-omap2/omap3-opp.h         |    6 +++---
 arch/arm/mach-omap2/pm.h                |    7 +++++++
 arch/arm/mach-omap2/pm34xx.c            |   31 ++++++++++++++++++++++++++++---
 10 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 74c20ee..a326b39 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -220,6 +220,7 @@ static void __init omap_3430sdp_init_irq(void)
 {
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
+	omap3_pm_init_opp_table();
 	omap3_pm_init_vc(&omap3_setuptime_table);
 	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL, omap3_mpu_rate_table,
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index d130d67..f613f82 100755
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -21,7 +21,9 @@
 #include <plat/mux.h>
 #include <plat/usb.h>
 
+#include "pm.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
+#include "omap3-opp.h"
 
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
 
@@ -74,9 +76,11 @@ static void __init omap_sdp_init_irq(void)
 {
 	omap_board_config = sdp_config;
 	omap_board_config_size = ARRAY_SIZE(sdp_config);
+	omap3_pm_init_opp_table();
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			     h8mbx00u0mer0em_sdrc_params,
-                             NULL, NULL, NULL);
+			     omap3_mpu_rate_table, omap3_dsp_rate_table,
+			     omap3_l3_rate_table);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 44de94b..e7bee77 100644
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
index 2f1c2be..997fd1c 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -103,6 +103,7 @@ static void __init rx51_init_irq(void)
 
 	omap_board_config = rx51_config;
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
+	omap3_pm_init_opp_table();
 	omap3_pm_init_cpuidle(rx51_cpuidle_params);
 	sdrc_params = rx51_get_sdram_timings();
 	omap2_init_common_hw(sdrc_params, sdrc_params,
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 430b791..2799e3c 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -21,6 +21,7 @@
 #include <plat/common.h>
 #include <plat/board.h>
 
+#include "pm.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "omap3-opp.h"
 
@@ -31,9 +32,11 @@ static void __init omap_zoom2_init_irq(void)
 {
 	omap_board_config = zoom2_config;
 	omap_board_config_size = ARRAY_SIZE(zoom2_config);
+	omap3_pm_init_opp_table();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-				 mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
-				 omap3_dsp_rate_table, omap3_l3_rate_table);
+				 mt46h32m32lf6_sdrc_params,
+				 omap3_mpu_rate_table, omap3_dsp_rate_table,
+				 omap3_l3_rate_table);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 50a13ea..e21ad34 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -19,7 +19,9 @@
 #include <plat/common.h>
 #include <plat/board.h>
 
+#include "pm.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
+#include "omap3-opp.h"
 
 static void __init omap_zoom_map_io(void)
 {
@@ -34,9 +36,11 @@ static void __init omap_zoom_init_irq(void)
 {
 	omap_board_config = zoom_config;
 	omap_board_config_size = ARRAY_SIZE(zoom_config);
+	omap3_pm_init_opp_table();
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			     h8mbx00u0mer0em_sdrc_params,
-			     NULL, NULL, NULL);
+			     omap3_mpu_rate_table, omap3_dsp_rate_table,
+			     omap3_l3_rate_table);
 	omap_init_irq();
 	omap_gpio_init();
 }
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
index c195b14..76bbdc4 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -59,6 +59,13 @@ static inline void omap3_pm_init_cpuidle(
 }
 #endif
 
+/**
+ * omap3_pm_init_opp_table - OMAP opp table lookup called after cpu is detected.
+ * Initialize the basic opp table here, board files could choose to modify opp
+ * table after the basic initialization
+ */
+extern void omap3_pm_init_opp_table(void);
+
 extern int resource_set_opp_level(int res, u32 target_level, int flags);
 extern int resource_access_opp_lock(int res, int delta);
 #define resource_lock_opp(res) resource_access_opp_lock(res, 1)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2f17a40..14131f8 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -100,7 +100,7 @@ static struct prm_setup_vc prm_setup = {
 	.vdd1_off = 0x00,	/* 0.6v */
 };
 
-struct omap_opp omap3_mpu_rate_table[] = {
+static __initdata struct omap_opp omap34xx_mpu_rate_table[] = {
 	{0, 0, 0, 0},
 	/*OPP1*/
 	{true, S125M, VDD1_OPP1, 0x1E},
@@ -115,7 +115,7 @@ struct omap_opp omap3_mpu_rate_table[] = {
 	{0, 0, 0, 0},
 };
 
-struct omap_opp omap3_l3_rate_table[] = {
+static __initdata struct omap_opp omap34xx_l3_rate_table[] = {
 	{0, 0, 0, 0},
 	/*OPP1*/
 	{false, 0, VDD2_OPP1, 0x1E},
@@ -126,7 +126,7 @@ struct omap_opp omap3_l3_rate_table[] = {
 	{0, 0, 0, 0},
 };
 
-struct omap_opp omap3_dsp_rate_table[] = {
+static __initdata struct omap_opp omap34xx_dsp_rate_table[] = {
 	{0, 0, 0, 0},
 	/*OPP1*/
 	{true, S90M, VDD1_OPP1, 0x1E},
@@ -141,6 +141,10 @@ struct omap_opp omap3_dsp_rate_table[] = {
 	{0, 0, 0, 0},
 };
 
+struct omap_opp *omap3_mpu_rate_table;
+struct omap_opp *omap3_dsp_rate_table;
+struct omap_opp *omap3_l3_rate_table;
+
 static inline void omap3_per_save_context(void)
 {
 	omap_gpio_save_context();
@@ -1280,6 +1284,27 @@ static void __init configure_vc(void)
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


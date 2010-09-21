From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v2 02/10] OMAP: mach-omap2: Fix static declaration warnings
Date: Tue, 21 Sep 2010 15:31:12 +0530
Message-ID: <1285063280-4057-3-git-send-email-manjugk@ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43428 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757137Ab0IUKBv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 06:01:51 -0400
In-Reply-To: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

This patch fixes sparse warnings due to non declaration of
static structures and variables.

Sparse warning logs fixed:
arch/arm/mach-omap2/control.c:88:6: warning: symbol 'omap3_secure_ram_storage' was not declared. Should it be static?
n
arch/arm/mach-omap2/timer-gp.c:50:22: warning: symbol 'gptimer_wakeup' was not declared. Should it be static?
arch/arm/mach-omap2/timer-gp.c:240:18: warning: symbol 'omap_timer' was not declared. Should it be static?
arch/arm/mach-omap2/prcm.c:121:24: warning: symbol 'prcm_context' was not declared. Should it be static?
arch/arm/mach-omap2/mux2420.c:510:29: warning: symbol 'omap2420_pop_ball' was not declared. Should it be static?
arch/arm/mach-omap2/mux2430.c:589:29: warning: symbol 'omap2430_pop_ball' was not declared. Should it be static?
arch/arm/mach-omap2/mux34xx.c:934:28: warning: symbol 'omap3_cus_subset' was not declared. Should it be static?
arch/arm/mach-omap2/mux34xx.c:1080:29: warning: symbol 'omap3_cus_ball' was not declared. Should it be static?
arch/arm/mach-omap2/mux34xx.c:1272:28: warning: symbol 'omap3_cbb_subset' was not declared. Should it be static?
arch/arm/mach-omap2/mux34xx.c:1393:29: warning: symbol 'omap3_cbb_ball' was not declared. Should it be static?
arch/arm/mach-omap2/mux34xx.c:1603:28: warning: symbol 'omap36xx_cbp_subset' was not declared. Should it be static?
arch/arm/mach-omap2/mux34xx.c:1821:29: warning: symbol 'omap36xx_cbp_ball' was not declared. Should it be static?
arch/arm/mach-omap2/pm-debug.c:165:15: warning: symbol 'pm_dbg_dir' was not declared. Should it be static?
arch/arm/mach-omap2/board-omap3evm.c:587:30: warning: symbol 'ads7846_config' was not declared. Should it be static?
arch/arm/mach-omap2/board-omap3evm.c:606:23: warning: symbol 'omap3evm_spi_board_info' was not declared. Should it be static?
arch/arm/mach-omap2/board-rx51-sdram.c:46:25: warning: symbol 'rx51_sdrc_params' was not declared. Should it be static?
arch/arm/mach-omap2/board-rx51-sdram.c:211:25: warning: symbol 'rx51_get_sdram_timings' was not declared. Should it be static?
arch/arm/mach-omap2/board-omap3touchbook.c:64:15: warning: symbol 'touchbook_revision' was not declared. Should it be static?
arch/arm/mach-omap2/board-am3517evm.c:350:24: warning: symbol 'am3517_evm_dss_device' was not declared. Should it be static?
arch/arm/mach-omap2/board-omap3stalker.c:567:23: warning: symbol 'omap3stalker_spi_board_info' was not declared. Should it be static?

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c      |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c       |    4 ++--
 arch/arm/mach-omap2/board-omap3stalker.c   |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 +-
 arch/arm/mach-omap2/board-rx51-sdram.c     |    2 +-
 arch/arm/mach-omap2/control.c              |    1 +
 arch/arm/mach-omap2/mux2420.c              |    2 +-
 arch/arm/mach-omap2/mux2430.c              |    2 +-
 arch/arm/mach-omap2/mux34xx.c              |   12 ++++++------
 arch/arm/mach-omap2/pm-debug.c             |    2 +-
 arch/arm/mach-omap2/prcm.c                 |    2 +-
 arch/arm/plat-omap/include/plat/dmtimer.h  |    2 ++
 arch/arm/plat-omap/include/plat/sdrc.h     |    1 +
 13 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 4d0f585..197289b 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -347,7 +347,7 @@ static struct omap_dss_board_info am3517_evm_dss_data = {
 	.default_device	= &am3517_evm_lcd_device,
 };
 
-struct platform_device am3517_evm_dss_device = {
+static struct platform_device am3517_evm_dss_device = {
 	.name		= "omapdss",
 	.id		= -1,
 	.dev		= {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index f76d9c0..892b740 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -584,7 +584,7 @@ static int ads7846_get_pendown_state(void)
 	return !gpio_get_value(OMAP3_EVM_TS_GPIO);
 }
 
-struct ads7846_platform_data ads7846_config = {
+static struct ads7846_platform_data ads7846_config = {
 	.x_max			= 0x0fff,
 	.y_max			= 0x0fff,
 	.x_plate_ohms		= 180,
@@ -603,7 +603,7 @@ static struct omap2_mcspi_device_config ads7846_mcspi_config = {
 	.single_channel	= 1,	/* 0: slave, 1: master */
 };
 
-struct spi_board_info omap3evm_spi_board_info[] = {
+static struct spi_board_info omap3evm_spi_board_info[] = {
 	[0] = {
 		.modalias		= "ads7846",
 		.bus_num		= 1,
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index bcd01d2..70067d6 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -564,7 +564,7 @@ static struct omap2_mcspi_device_config ads7846_mcspi_config = {
 	.single_channel		= 1,	/* 0: slave, 1: master */
 };
 
-struct spi_board_info omap3stalker_spi_board_info[] = {
+static struct spi_board_info omap3stalker_spi_board_info[] = {
 	[0] = {
 	       .modalias	= "ads7846",
 	       .bus_num		= 1,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 663c62d..430ae22 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -61,7 +61,7 @@
 #define TB_BL_PWM_TIMER		9
 #define TB_KILL_POWER_GPIO	168
 
-unsigned long touchbook_revision;
+static unsigned long touchbook_revision;
 
 static struct mtd_partition omap3touchbook_nand_partitions[] = {
 	/* All the partition sizes are listed in terms of NAND block size */
diff --git a/arch/arm/mach-omap2/board-rx51-sdram.c b/arch/arm/mach-omap2/board-rx51-sdram.c
index f392844..a43b2c5 100644
--- a/arch/arm/mach-omap2/board-rx51-sdram.c
+++ b/arch/arm/mach-omap2/board-rx51-sdram.c
@@ -43,7 +43,7 @@ struct sdram_timings {
 	u32 tWTR;
 };
 
-struct omap_sdrc_params rx51_sdrc_params[4];
+static struct omap_sdrc_params rx51_sdrc_params[4];
 
 static const struct sdram_timings rx51_timings[] = {
 	{
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 7405936..018022a 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -23,6 +23,7 @@
 #include "cm.h"
 #include "prm.h"
 #include "sdrc.h"
+#include "pm.h"
 
 static void __iomem *omap2_ctrl_base;
 
diff --git a/arch/arm/mach-omap2/mux2420.c b/arch/arm/mach-omap2/mux2420.c
index fdb04a7..414af54 100644
--- a/arch/arm/mach-omap2/mux2420.c
+++ b/arch/arm/mach-omap2/mux2420.c
@@ -507,7 +507,7 @@ static struct omap_mux __initdata omap2420_muxmodes[] = {
  * Balls for 447-pin POP package
  */
 #ifdef CONFIG_DEBUG_FS
-struct omap_ball __initdata omap2420_pop_ball[] = {
+static struct omap_ball __initdata omap2420_pop_ball[] = {
 	_OMAP2420_BALLENTRY(CAM_D0, "y4", NULL),
 	_OMAP2420_BALLENTRY(CAM_D1, "y3", NULL),
 	_OMAP2420_BALLENTRY(CAM_D2, "u7", NULL),
diff --git a/arch/arm/mach-omap2/mux2430.c b/arch/arm/mach-omap2/mux2430.c
index 7dcaaa8..84d2c5a 100644
--- a/arch/arm/mach-omap2/mux2430.c
+++ b/arch/arm/mach-omap2/mux2430.c
@@ -586,7 +586,7 @@ static struct omap_mux __initdata omap2430_muxmodes[] = {
  * 447-pin s-PBGA Package, 0.00mm Ball Pitch (Bottom)
  */
 #ifdef CONFIG_DEBUG_FS
-struct omap_ball __initdata omap2430_pop_ball[] = {
+static struct omap_ball __initdata omap2430_pop_ball[] = {
 	_OMAP2430_BALLENTRY(CAM_D0, "t8", NULL),
 	_OMAP2430_BALLENTRY(CAM_D1, "t4", NULL),
 	_OMAP2430_BALLENTRY(CAM_D10, "r4", NULL),
diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index f64d7ee..574e54e 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -931,7 +931,7 @@ struct omap_ball __initdata omap3_cbc_ball[] = {
  * Signals different on CUS package compared to superset
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_OMAP_PACKAGE_CUS)
-struct omap_mux __initdata omap3_cus_subset[] = {
+static struct omap_mux __initdata omap3_cus_subset[] = {
 	_OMAP3_MUXENTRY(CAM_D10, 109,
 		"cam_d10", NULL, NULL, NULL,
 		"gpio_109", NULL, NULL, "safe_mode"),
@@ -1077,7 +1077,7 @@ struct omap_mux __initdata omap3_cus_subset[] = {
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)		\
 		&& defined(CONFIG_OMAP_PACKAGE_CUS)
-struct omap_ball __initdata omap3_cus_ball[] = {
+static struct omap_ball __initdata omap3_cus_ball[] = {
 	_OMAP3_BALLENTRY(CAM_D0, "ab18", NULL),
 	_OMAP3_BALLENTRY(CAM_D1, "ac18", NULL),
 	_OMAP3_BALLENTRY(CAM_D10, "f21", NULL),
@@ -1269,7 +1269,7 @@ struct omap_ball __initdata omap3_cus_ball[] = {
  * Signals different on CBB package comapared to superset
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_OMAP_PACKAGE_CBB)
-struct omap_mux __initdata omap3_cbb_subset[] = {
+static struct omap_mux __initdata omap3_cbb_subset[] = {
 	_OMAP3_MUXENTRY(CAM_D10, 109,
 		"cam_d10", NULL, NULL, NULL,
 		"gpio_109", NULL, NULL, "safe_mode"),
@@ -1390,7 +1390,7 @@ struct omap_mux __initdata omap3_cbb_subset[] = {
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)		\
 		&& defined(CONFIG_OMAP_PACKAGE_CBB)
-struct omap_ball __initdata omap3_cbb_ball[] = {
+static struct omap_ball __initdata omap3_cbb_ball[] = {
 	_OMAP3_BALLENTRY(CAM_D0, "ag17", NULL),
 	_OMAP3_BALLENTRY(CAM_D1, "ah17", NULL),
 	_OMAP3_BALLENTRY(CAM_D10, "b25", NULL),
@@ -1600,7 +1600,7 @@ struct omap_ball __initdata omap3_cbb_ball[] = {
  * Signals different on 36XX CBP package comapared to 34XX CBC package
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_OMAP_PACKAGE_CBP)
-struct omap_mux __initdata omap36xx_cbp_subset[] = {
+static struct omap_mux __initdata omap36xx_cbp_subset[] = {
 	_OMAP3_MUXENTRY(CAM_D0, 99,
 		"cam_d0", NULL, "csi2_dx2", NULL,
 		"gpio_99", NULL, NULL, "safe_mode"),
@@ -1818,7 +1818,7 @@ struct omap_mux __initdata omap36xx_cbp_subset[] = {
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)		\
 		&& defined (CONFIG_OMAP_PACKAGE_CBP)
-struct omap_ball __initdata omap36xx_cbp_ball[] = {
+static struct omap_ball __initdata omap36xx_cbp_ball[] = {
 	_OMAP3_BALLENTRY(CAM_D0, "ag17", NULL),
 	_OMAP3_BALLENTRY(CAM_D1, "ah17", NULL),
 	_OMAP3_BALLENTRY(CAM_D10, "b25", NULL),
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 723b44e..efb1d15 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -162,7 +162,7 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 
 static void pm_dbg_regset_store(u32 *ptr);
 
-struct dentry *pm_dbg_dir;
+static struct dentry *pm_dbg_dir;
 
 static int pm_dbg_init_done;
 
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index c201374..8d412a2 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -118,7 +118,7 @@ struct omap3_prcm_regs {
 	u32 wkup_pm_wken;
 };
 
-struct omap3_prcm_regs prcm_context;
+static struct omap3_prcm_regs prcm_context;
 
 u32 omap_prcm_get_reset_sources(void)
 {
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 20f1054..dfa3aff 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -45,6 +45,8 @@
 #define OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE	0x02
 
 struct omap_dm_timer;
+extern struct omap_dm_timer *gptimer_wakeup;
+extern struct sys_timer omap_timer;
 struct clk;
 
 int omap_dm_timer_init(void);
diff --git a/arch/arm/plat-omap/include/plat/sdrc.h b/arch/arm/plat-omap/include/plat/sdrc.h
index 7b76f50..efd87c8 100644
--- a/arch/arm/plat-omap/include/plat/sdrc.h
+++ b/arch/arm/plat-omap/include/plat/sdrc.h
@@ -147,6 +147,7 @@ struct memory_timings {
 };
 
 extern void omap2xxx_sdrc_init_params(u32 force_lock_to_unlock_mode);
+struct omap_sdrc_params *rx51_get_sdram_timings(void);
 
 u32 omap2xxx_sdrc_dll_is_unlocked(void);
 u32 omap2xxx_sdrc_reprogram(u32 level, u32 force);
-- 
1.7.0.4


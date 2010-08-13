From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP2PLUS: Fix Sparse errors/warnings in mach-omap2
Date: Fri, 13 Aug 2010 13:52:00 +0530
Message-ID: <1281687720-5482-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57035 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761362Ab0HMIXc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Aug 2010 04:23:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

This patch fixes sparse errors/warnings for all the files
in mach-omap2 directory.

Build tested for omap3_defconfig and boot tested on OMAP4 SDP and beagle
board.

sparse warnings which are fixed with this patch:

arch/arm/mach-omap2/control.c:88:6: warning: symbol 'omap3_secure_ram_storage' was not declared. Should it be static?
arch/arm/mach-omap2/control.c:195:16: warning: incorrect type in assignment (different address spaces)
arch/arm/mach-omap2/control.c:195:16:    expected unsigned int [usertype] *v_addr
arch/arm/mach-omap2/control.c:195:16:    got void [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/control.c:199:25: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/control.c:199:25:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/control.c:199:25:    got unsigned int [usertype] *
arch/arm/mach-omap2/control.c:320:28: warning: incorrect type in assignment (different address spaces)
arch/arm/mach-omap2/control.c:320:28:    expected void *[noderef] <asn:2>scratchpad_address
arch/arm/mach-omap2/control.c:320:28:    got void [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/control.c:321:9: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/control.c:321:9:    expected void volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/control.c:321:9:    got void *[noderef] <asn:2>scratchpad_address
arch/arm/mach-omap2/control.c:324:9: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/control.c:324:9:    expected void volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/control.c:324:9:    got void *
arch/arm/mach-omap2/control.c:327:9: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/control.c:327:9:    expected void volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/control.c:327:9:    got void *
arch/arm/mach-omap2/control.c:334:9: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/control.c:334:9:    expected void volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/control.c:334:9:    got void *
arch/arm/mach-omap2/control.c:321:9: warning: dereference of noderef expression
arch/arm/mach-omap2/control.c:324:9: warning: dereference of noderef expression
arch/arm/mach-omap2/control.c:327:9: warning: dereference of noderef expression
arch/arm/mach-omap2/control.c:334:9: warning: dereference of noderef expression

arch/arm/mach-omap2/timer-gp.c:50:22: warning: symbol 'gptimer_wakeup' was not declared. Should it be static?
arch/arm/mach-omap2/timer-gp.c:115:12: warning: symbol 'omap2_gp_clockevent_set_gptimer' was not declared. Should it be static?
arch/arm/mach-omap2/timer-gp.c:240:18: warning: symbol 'omap_timer' was not declared. Should it be static?

arch/arm/mach-omap2/irq.c:50:35: warning: Using plain integer as NULL pointer

arch/arm/mach-omap2/powerdomain.c:993:5: warning: symbol 'pwrdm_set_lowpwrstchange' was not declared. Should it be static?

arch/arm/mach-omap2/mux2430.c:589:29: warning: symbol 'omap2430_pop_ball' was not declared. Should it be static?

arch/arm/mach-omap2/mux34xx.c:934:28: warning: symbol 'omap3_cus_subset' was not declared. Should it be static?
arch/arm/mach-omap2/mux34xx.c:1080:29: warning: symbol 'omap3_cus_ball' was not declared. Should it be static?
arch/arm/mach-omap2/mux34xx.c:1272:28: warning: symbol 'omap3_cbb_subset' was not declared. Should it be static?
arch/arm/mach-omap2/mux34xx.c:1393:29: warning: symbol 'omap3_cbb_ball' was not declared. Should it be static?
arch/arm/mach-omap2/mux34xx.c:1603:28: warning: symbol 'omap36xx_cbp_subset' was not declared. Should it be static?
arch/arm/mach-omap2/mux34xx.c:1821:29: warning: symbol 'omap36xx_cbp_ball' was not declared. Should it be static?

arch/arm/mach-omap2/pm34xx.c:323:28: warning: incorrect type in assignment (different address spaces)
arch/arm/mach-omap2/pm34xx.c:323:28:    expected unsigned int [usertype] *scratchpad_address
arch/arm/mach-omap2/pm34xx.c:323:28:    got void [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/pm34xx.c:326:26: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/pm34xx.c:326:26:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/pm34xx.c:326:26:    got unsigned int [usertype] *
arch/arm/mach-omap2/pm34xx.c:329:26: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/pm34xx.c:329:26:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/pm34xx.c:329:26:    got unsigned int [usertype] *
arch/arm/mach-omap2/pm34xx.c:334:29: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/pm34xx.c:334:29:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/pm34xx.c:334:29:    got unsigned int [usertype] *

arch/arm/mach-omap2/pm-debug.c:165:15: warning: symbol 'pm_dbg_dir' was not declared. Should it be static?

arch/arm/mach-omap2/board-flash.c:141:8: warning: symbol 'board_nand_init' was not declared. Should it be static?

arch/arm/mach-omap2/board-omap3evm.c:590:30: warning: symbol 'ads7846_config' was not declared. Should it be static?
arch/arm/mach-omap2/board-omap3evm.c:609:23: warning: symbol 'omap3evm_spi_board_info' was not declared. Should it be static?

arch/arm/mach-omap2/board-n8x0.c:416:6: warning: symbol 'n8x0_mmc_slot1_cover_handler' was not declared. Should it be static?
arch/arm/mach-omap2/board-n8x0.c:544:13: warning: symbol 'n8x0_mmc_init' was not declared. Should it be static?
arch/arm/mach-omap2/board-rx51-sdram.c:46:25: warning: symbol 'rx51_sdrc_params' was not declared. Should it be static?
arch/arm/mach-omap2/board-rx51-sdram.c:211:25: warning: symbol 'rx51_get_sdram_timings' was not declared. Should it be static?

arch/arm/mach-omap2/board-rx51-peripherals.c:902:13: warning: symbol 'rx51_peripherals_init' was not declared. Should it be static?
arch/arm/mach-omap2/board-rx51-video.c:107:13: warning: symbol 'rx51_video_mem_init' was not declared. Should it be static?
arch/arm/mach-omap2/board-zoom-debugboard.c:155:12: warning: symbol 'zoom_debugboard_init' was not declared. Should it be static?
arch/arm/mach-omap2/board-zoom-peripherals.c:280:13: warning: symbol 'zoom_peripherals_init' was not declared. Should it be static?

arch/arm/mach-omap2/board-igep0020.c:110:13: warning: symbol 'igep2_flash_init' was not declared. Should it be static?
arch/arm/mach-omap2/board-omap3touchbook.c:64:15: warning: symbol 'touchbook_revision' was not declared. Should it be static?

arch/arm/mach-omap2/board-am3517evm.c:109:6: warning: symbol 'am3517_evm_ethernet_init' was not declared. Should it be static?
arch/arm/mach-omap2/board-am3517evm.c:350:24: warning: symbol 'am3517_evm_dss_device' was not declared. Should it be static?
arch/arm/mach-omap2/board-am3517evm.c:141:17: warning: Initializer entry defined twice
arch/arm/mach-omap2/board-am3517evm.c:142:18:   also defined here

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-am3517evm.c          |    5 +--
 arch/arm/mach-omap2/board-igep0020.c           |    4 +-
 arch/arm/mach-omap2/board-n8x0.c               |   16 +------------
 arch/arm/mach-omap2/board-omap3evm.c           |    4 +-
 arch/arm/mach-omap2/board-omap3stalker.c       |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c     |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c   |    2 +
 arch/arm/mach-omap2/board-rx51-sdram.c         |    2 +-
 arch/arm/mach-omap2/board-rx51-video.c         |    2 +
 arch/arm/mach-omap2/board-rx51.c               |    2 +
 arch/arm/mach-omap2/board-zoom-debugboard.c    |    2 +
 arch/arm/mach-omap2/board-zoom-peripherals.c   |    2 +
 arch/arm/mach-omap2/control.c                  |    5 ++-
 arch/arm/mach-omap2/include/mach/board-flash.h |    2 +
 arch/arm/mach-omap2/include/mach/board-rx51.h  |   11 +++++++++
 arch/arm/mach-omap2/irq.c                      |    2 +-
 arch/arm/mach-omap2/mux2420.c                  |    2 +-
 arch/arm/mach-omap2/mux2430.c                  |    2 +-
 arch/arm/mach-omap2/mux34xx.c                  |   12 +++++-----
 arch/arm/mach-omap2/pm-debug.c                 |    2 +-
 arch/arm/mach-omap2/pm34xx.c                   |    2 +-
 arch/arm/mach-omap2/powerdomain.c              |   28 ------------------------
 arch/arm/mach-omap2/prcm.c                     |    2 +-
 arch/arm/mach-omap2/timer-gp.c                 |    2 +
 arch/arm/plat-omap/include/plat/board.h        |    2 +-
 arch/arm/plat-omap/include/plat/dmtimer.h      |    4 ++-
 arch/arm/plat-omap/include/plat/sdrc.h         |    1 +
 27 files changed, 55 insertions(+), 69 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/board-rx51.h

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 4d0f585..b091741 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -106,7 +106,7 @@ static void am3517_disable_ethernet_int(void)
 	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
 }
 
-void am3517_evm_ethernet_init(struct emac_platform_data *pdata)
+static void am3517_evm_ethernet_init(struct emac_platform_data *pdata)
 {
 	unsigned int regval;
 
@@ -139,7 +139,6 @@ void am3517_evm_ethernet_init(struct emac_platform_data *pdata)
 static struct i2c_board_info __initdata am3517evm_i2c1_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("s35390a", 0x30),
-		.type		= "s35390a",
 	},
 };
 
@@ -347,7 +346,7 @@ static struct omap_dss_board_info am3517_evm_dss_data = {
 	.default_device	= &am3517_evm_lcd_device,
 };
 
-struct platform_device am3517_evm_dss_device = {
+static struct platform_device am3517_evm_dss_device = {
 	.name		= "omapdss",
 	.id		= -1,
 	.dev		= {
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 175f043..fbcb888 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -107,7 +107,7 @@ static struct platform_device igep2_onenand_device = {
 	},
 };
 
-void __init igep2_flash_init(void)
+static void __init igep2_flash_init(void)
 {
 	u8		cs = 0;
 	u8		onenandcs = GPMC_CS_NUM + 1;
@@ -141,7 +141,7 @@ void __init igep2_flash_init(void)
 }
 
 #else
-void __init igep2_flash_init(void) {}
+static void __init igep2_flash_init(void) {}
 #endif
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index d705cc8..26145c9 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -413,15 +413,6 @@ static void n8x0_mmc_callback(void *data, u8 card_mask)
 	omap_mmc_notify_cover_event(mmc_device, index, *openp);
 }
 
-void n8x0_mmc_slot1_cover_handler(void *arg, int closed_state)
-{
-	if (mmc_device == NULL)
-		return;
-
-	slot1_cover_open = !closed_state;
-	omap_mmc_notify_cover_event(mmc_device, 0, closed_state);
-}
-
 static int n8x0_mmc_late_init(struct device *dev)
 {
 	int r, bit, *openp;
@@ -541,7 +532,7 @@ static struct omap_mmc_platform_data mmc1_data = {
 
 static struct omap_mmc_platform_data *mmc_data[OMAP24XX_NR_MMC];
 
-void __init n8x0_mmc_init(void)
+static void __init n8x0_mmc_init(void)
 
 {
 	int err;
@@ -590,11 +581,6 @@ void __init n8x0_mmc_init(void)
 void __init n8x0_mmc_init(void)
 {
 }
-
-void n8x0_mmc_slot1_cover_handler(void *arg, int state)
-{
-}
-
 #endif	/* CONFIG_MMC_OMAP */
 
 #ifdef CONFIG_MENELAUS
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 6494dbd..6fb5177 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -587,7 +587,7 @@ static int ads7846_get_pendown_state(void)
 	return !gpio_get_value(OMAP3_EVM_TS_GPIO);
 }
 
-struct ads7846_platform_data ads7846_config = {
+static struct ads7846_platform_data ads7846_config = {
 	.x_max			= 0x0fff,
 	.y_max			= 0x0fff,
 	.x_plate_ohms		= 180,
@@ -606,7 +606,7 @@ static struct omap2_mcspi_device_config ads7846_mcspi_config = {
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
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 9a5eb87..83d4efd 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -32,6 +32,8 @@
 #include <plat/onenand.h>
 #include <plat/gpmc-smc91x.h>
 
+#include <mach/board-rx51.h>
+
 #include <sound/tlv320aic3x.h>
 #include <sound/tpa6130a2-plat.h>
 
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
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 5a1005b..85503fe 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -20,6 +20,8 @@
 #include <plat/vram.h>
 #include <plat/mcspi.h>
 
+#include <mach/board-rx51.h>
+
 #include "mux.h"
 
 #define RX51_LCD_RESET_GPIO	90
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index a58e8cb..29ea2f1 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -30,6 +30,8 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 
+#include <mach/board-rx51.h>
+
 #include "mux.h"
 #include "pm.h"
 
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 1d7f827..007ebdc 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -16,6 +16,8 @@
 
 #include <plat/gpmc.h>
 
+#include <mach/board-zoom.h>
+
 #define ZOOM_SMSC911X_CS	7
 #define ZOOM_SMSC911X_GPIO	158
 #define ZOOM_QUADUART_CS	3
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 6b39849..e2e7353 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -24,6 +24,8 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 
+#include <mach/board-zoom.h>
+
 #include "mux.h"
 #include "hsmmc.h"
 
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index a8d20ee..018022a 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -23,6 +23,7 @@
 #include "cm.h"
 #include "prm.h"
 #include "sdrc.h"
+#include "pm.h"
 
 static void __iomem *omap2_ctrl_base;
 
@@ -190,7 +191,7 @@ void omap_ctrl_writel(u32 val, u16 offset)
 void omap3_clear_scratchpad_contents(void)
 {
 	u32 max_offset = OMAP343X_SCRATCHPAD_ROM_OFFSET;
-	u32 *v_addr;
+	void __iomem *v_addr;
 	u32 offset = 0;
 	v_addr = OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD_ROM);
 	if (prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
@@ -206,7 +207,7 @@ void omap3_clear_scratchpad_contents(void)
 /* Populate the scratchpad structure with restore structure */
 void omap3_save_scratchpad_contents(void)
 {
-	void * __iomem scratchpad_address;
+	void  __iomem *scratchpad_address;
 	u32 arm_context_addr;
 	struct omap3_scratchpad scratchpad_contents;
 	struct omap3_scratchpad_prcm_block prcm_block_contents;
diff --git a/arch/arm/mach-omap2/include/mach/board-flash.h b/arch/arm/mach-omap2/include/mach/board-flash.h
index b2242ae..69befe0 100644
--- a/arch/arm/mach-omap2/include/mach/board-flash.h
+++ b/arch/arm/mach-omap2/include/mach/board-flash.h
@@ -26,3 +26,5 @@ struct flash_partitions {
 
 extern void board_flash_init(struct flash_partitions [],
 				char chip_sel[][GPMC_CS_NUM]);
+extern void board_nand_init(struct mtd_partition *nand_parts,
+					u8 nr_parts, u8 cs);
diff --git a/arch/arm/mach-omap2/include/mach/board-rx51.h b/arch/arm/mach-omap2/include/mach/board-rx51.h
new file mode 100644
index 0000000..b76f49e
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/board-rx51.h
@@ -0,0 +1,11 @@
+/*
+ * Defines for rx51 boards
+ */
+
+#ifndef _OMAP_BOARD_RX51_H
+#define _OMAP_BOARD_RX51_H
+
+extern void __init rx51_peripherals_init(void);
+extern void __init rx51_video_mem_init(void);
+
+#endif
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 26aeef5..02fd942 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -47,7 +47,7 @@ static struct omap_irq_bank {
 } __attribute__ ((aligned(4))) irq_banks[] = {
 	{
 		/* MPU INTC */
-		.base_reg	= 0,
+		.base_reg	= (void __iomem *)0,
 		.nr_irqs	= 96,
 	},
 };
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
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fb4994a..05292ae 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -316,7 +316,7 @@ static void restore_control_register(u32 val)
 /* Function to restore the table entry that was modified for enabling MMU */
 static void restore_table_entry(void)
 {
-	u32 *scratchpad_address;
+	void __iomem *scratchpad_address;
 	u32 previous_value, control_reg_value;
 	u32 *address;
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 6527ec3..6e51079 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -981,34 +981,6 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)
 }
 
 /**
- * pwrdm_set_lowpwrstchange - Request a low power state change
- * @pwrdm: struct powerdomain *
- *
- * Allows a powerdomain to transtion to a lower power sleep state
- * from an existing sleep state without waking up the powerdomain.
- * Returns -EINVAL if the powerdomain pointer is null or if the
- * powerdomain does not support LOWPOWERSTATECHANGE, or returns 0
- * upon success.
- */
-int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
-{
-	if (!pwrdm)
-		return -EINVAL;
-
-	if (!(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE))
-		return -EINVAL;
-
-	pr_debug("powerdomain: %s: setting LOWPOWERSTATECHANGE bit\n",
-		 pwrdm->name);
-
-	prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
-			     (1 << OMAP4430_LOWPOWERSTATECHANGE_SHIFT),
-			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
-
-	return 0;
-}
-
-/**
  * pwrdm_wait_transition - wait for powerdomain power transition to finish
  * @pwrdm: struct powerdomain * to wait for
  *
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
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 74fbed8..d363891 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -47,6 +47,7 @@ static struct omap_dm_timer *gptimer;
 static struct clock_event_device clockevent_gpt;
 static u8 __initdata gptimer_id = 1;
 static u8 __initdata inited;
+
 struct omap_dm_timer *gptimer_wakeup;
 
 static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
@@ -123,6 +124,7 @@ int __init omap2_gp_clockevent_set_gptimer(u8 id)
 
 	return 0;
 }
+EXPORT_SYMBOL(omap2_gp_clockevent_set_gptimer);
 
 static void __init omap2_gp_clockevent_init(void)
 {
diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index 3cf4fa2..1642abc 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -160,10 +160,10 @@ extern const void *__omap_get_config(u16 tag, size_t len, int nr);
 
 extern const void *omap_get_var_config(u16 tag, size_t *len);
 
+
 extern struct omap_board_config_kernel *omap_board_config;
 extern int omap_board_config_size;
 
-
 /* for TI reference platforms sharing the same debug card */
 extern int debug_card_init(u32 addr, unsigned gpio);
 
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 20f1054..ce55949 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -45,6 +45,8 @@
 #define OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE	0x02
 
 struct omap_dm_timer;
+extern struct omap_dm_timer *gptimer_wakeup;
+extern struct sys_timer omap_timer;
 struct clk;
 
 int omap_dm_timer_init(void);
@@ -79,6 +81,6 @@ unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer);
 void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value);
 
 int omap_dm_timers_active(void);
-
+int omap2_gp_clockevent_set_gptimer(u8 id);
 
 #endif /* __ASM_ARCH_DMTIMER_H */
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


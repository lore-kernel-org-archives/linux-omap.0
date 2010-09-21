From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v2 03/10] OMAP: mach-omap2: Fix static function warnings
Date: Tue, 21 Sep 2010 15:31:13 +0530
Message-ID: <1285063280-4057-4-git-send-email-manjugk@ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47459 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756618Ab0IUKBy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 06:01:54 -0400
In-Reply-To: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

This patch fixes sparse warnings due non declarations of static functions.

arch/arm/mach-omap2/timer-gp.c:115:12: warning: symbol 'omap2_gp_clockevent_set_gptimer' was not declared. Should it be static?
arch/arm/mach-omap2/powerdomain.c:993:5: warning: symbol 'pwrdm_set_lowpwrstchange' was not declared. Should it be static?
arch/arm/mach-omap2/board-flash.c:141:8: warning: symbol 'board_nand_init' was not declared. Should it be static?
arch/arm/mach-omap2/board-n8x0.c:416:6: warning: symbol 'n8x0_mmc_slot1_cover_handler' was not declared. Should it be static?
arch/arm/mach-omap2/board-n8x0.c:544:13: warning: symbol 'n8x0_mmc_init' was not declared. Should it be static?
arch/arm/mach-omap2/board-rx51-peripherals.c:902:13: warning: symbol 'rx51_peripherals_init' was not declared. Should it be static?
arch/arm/mach-omap2/board-rx51-video.c:107:13: warning: symbol 'rx51_video_mem_init' was not declared. Should it be static?
arch/arm/mach-omap2/board-zoom-debugboard.c:155:12: warning: symbol 'zoom_debugboard_init' was not declared. Should it be static?
arch/arm/mach-omap2/board-zoom-peripherals.c:280:13: warning: symbol 'zoom_peripherals_init' was not declared. Should it be static?
arch/arm/mach-omap2/board-igep0020.c:110:13: warning: symbol 'igep2_flash_init' was not declared. Should it be static?
arch/arm/mach-omap2/board-am3517evm.c:109:6: warning: symbol 'am3517_evm_ethernet_init' was not declared. Should it be static?

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c          |    2 +-
 arch/arm/mach-omap2/board-igep0020.c           |    4 +-
 arch/arm/mach-omap2/board-n8x0.c               |   16 +------------
 arch/arm/mach-omap2/board-rx51-peripherals.c   |    2 +
 arch/arm/mach-omap2/board-rx51-video.c         |    2 +
 arch/arm/mach-omap2/board-zoom-debugboard.c    |    2 +
 arch/arm/mach-omap2/board-zoom-peripherals.c   |    2 +
 arch/arm/mach-omap2/include/mach/board-flash.h |    2 +
 arch/arm/mach-omap2/include/mach/board-rx51.h  |   11 +++++++++
 arch/arm/mach-omap2/powerdomain.c              |   28 ------------------------
 arch/arm/mach-omap2/timer-gp.c                 |    1 +
 arch/arm/plat-omap/include/plat/dmtimer.h      |    2 +-
 12 files changed, 27 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/board-rx51.h

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 197289b..ae22ea8 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -106,7 +106,7 @@ static void am3517_disable_ethernet_int(void)
 	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
 }
 
-void am3517_evm_ethernet_init(struct emac_platform_data *pdata)
+static void am3517_evm_ethernet_init(struct emac_platform_data *pdata)
 {
 	unsigned int regval;
 
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
index a3e2b49..3b69ba2 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -383,15 +383,6 @@ static void n8x0_mmc_callback(void *data, u8 card_mask)
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
@@ -511,7 +502,7 @@ static struct omap_mmc_platform_data mmc1_data = {
 
 static struct omap_mmc_platform_data *mmc_data[OMAP24XX_NR_MMC];
 
-void __init n8x0_mmc_init(void)
+static void __init n8x0_mmc_init(void)
 
 {
 	int err;
@@ -560,11 +551,6 @@ void __init n8x0_mmc_init(void)
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
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 74fbed8..cd2f7b8 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -123,6 +123,7 @@ int __init omap2_gp_clockevent_set_gptimer(u8 id)
 
 	return 0;
 }
+EXPORT_SYMBOL(omap2_gp_clockevent_set_gptimer);
 
 static void __init omap2_gp_clockevent_init(void)
 {
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index dfa3aff..ce55949 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -81,6 +81,6 @@ unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer);
 void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value);
 
 int omap_dm_timers_active(void);
-
+int omap2_gp_clockevent_set_gptimer(u8 id);
 
 #endif /* __ASM_ARCH_DMTIMER_H */
-- 
1.7.0.4


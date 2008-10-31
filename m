From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] HSMMC: Misc clean-up for hsmmc init
Date: Thu, 30 Oct 2008 19:04:17 -0700
Message-ID: <1225418657-31775-5-git-send-email-tony@atomide.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com>
 <1225418657-31775-2-git-send-email-tony@atomide.com>
 <1225418657-31775-3-git-send-email-tony@atomide.com>
 <1225418657-31775-4-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50539 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbYJaCE0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 22:04:26 -0400
In-Reply-To: <1225418657-31775-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Misc clean-up for hsmmc init

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/devices.c         |    2 +-
 arch/arm/mach-omap2/board-overo.c     |    2 ++
 arch/arm/mach-omap2/devices.c         |    2 +-
 arch/arm/mach-omap2/hsmmc.c           |   16 +++++-----------
 arch/arm/plat-omap/devices.c          |    2 +-
 arch/arm/plat-omap/include/mach/mmc.h |   12 ++++--------
 6 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 375a874..024dab1 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -102,7 +102,7 @@ static inline void omap_init_mbox(void) { }
 
 /*-------------------------------------------------------------------------*/
 
-#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
 static inline void omap1_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			int controller_nr)
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index a4bd804..4f0b5d4 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -26,6 +26,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/i2c/twl4030.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -144,6 +145,7 @@ static void __init overo_flash_init(void)
 static struct omap_uart_config overo_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
+
 static struct twl4030_gpio_platform_data overo_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 32550a5..0dd8b96 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -358,7 +358,7 @@ static inline void omap_init_sha1_md5(void) { }
 
 /*-------------------------------------------------------------------------*/
 
-#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
 	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
 static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 23cbdf6..f1d050a 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-omap2/board-sdp-hsmmc.c
+ * linux/arch/arm/mach-omap2/hsmmc.c
  *
  * Copyright (C) 2007-2008 Texas Instruments
  * Copyright (C) 2008 Nokia Corporation
@@ -101,6 +101,7 @@ static int hsmmc1_late_init(struct device *dev)
 
 err:
 	dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
+
 	return ret;
 }
 
@@ -232,7 +233,7 @@ static int hsmmc_twl_set_voltage(struct hsmmc_controller *c, int vdd)
 		return ret;
 
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-						vmmc, c->twl_mmc_dedicated);
+					vmmc, c->twl_mmc_dedicated);
 
 	return ret;
 }
@@ -331,8 +332,8 @@ static struct omap_mmc_platform_data mmc1_data = {
 						MMC_VDD_165_195,
 		.name			= "first slot",
 
-		.card_detect_irq        = TWL4030_GPIO_IRQ_NO(0),
-		.card_detect            = hsmmc1_card_detect,
+		.card_detect_irq	= TWL4030_GPIO_IRQ_NO(0),
+		.card_detect		= hsmmc1_card_detect,
 	},
 };
 
@@ -368,11 +369,4 @@ void __init hsmmc_init(int controller_mask)
 	omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
 }
 
-#else
-
-void __init hsmmc_init(void)
-{
-
-}
-
 #endif
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index c22bd5f..25c6d10 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -191,7 +191,7 @@ void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 
 /*-------------------------------------------------------------------------*/
 
-#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
 	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
 #define OMAP_MMC_NR_RES		2
diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
index 5e8ac72..0c2ef3b 100644
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -111,6 +111,7 @@ void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers);
 void omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers);
+void hsmmc_init(int controller_mask);
 int omap_mmc_add(int id, unsigned long base, unsigned long size,
 			unsigned int irq, struct omap_mmc_platform_data *data);
 #else
@@ -122,19 +123,14 @@ static inline void omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers)
 {
 }
+static inline void hsmmc_init(int controller_mask)
+{
+}
 static inline int omap_mmc_add(int id, unsigned long base, unsigned long size,
 		unsigned int irq, struct omap_mmc_platform_data *data)
 {
 	return 0;
 }
-#endif
 
-#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
-void __init hsmmc_init(int controller_mask);
-#else
-static inline void hsmmc_init(void)
-{
-}
 #endif
-
 #endif
-- 
1.5.6.rc3.21.g8c6b5


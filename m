From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 02/20] Move DSS driver register from board to mach_omap2
Date: Mon, 23 Aug 2010 21:27:51 +0530
Message-ID: <1282579089-10487-3-git-send-email-svadivu@ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <1282579089-10487-2-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35118 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754235Ab0HWP6Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 11:58:25 -0400
In-Reply-To: <1282579089-10487-2-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Move the DSS driver register from board file to devices.c.
Regulator initialisation done with driver name instead of the device name.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c       |   25 +++-------------------
 arch/arm/mach-omap2/devices.c             |   32 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h |    4 +++
 drivers/video/omap2/dss/core.c            |    2 +
 4 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 67b95b5..9b721a4 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -301,22 +301,8 @@ static struct omap_dss_board_info sdp3430_dss_data = {
 	.default_device	= &sdp3430_lcd_device,
 };
 
-static struct platform_device sdp3430_dss_device = {
-	.name		= "omapdss",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &sdp3430_dss_data,
-	},
-};
-
-static struct regulator_consumer_supply sdp3430_vdda_dac_supply = {
-	.supply		= "vdda_dac",
-	.dev		= &sdp3430_dss_device.dev,
-};
-
-static struct platform_device *sdp3430_devices[] __initdata = {
-	&sdp3430_dss_device,
-};
+static struct regulator_consumer_supply sdp3430_vdda_dac_supply =
+	REGULATOR_SUPPLY("vdda_dac", "omapdss");
 
 static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 };
@@ -540,10 +526,7 @@ static struct regulator_init_data sdp3430_vdac = {
 
 /* VPLL2 for digital video outputs */
 static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
-	{
-		.supply		= "vdds_dsi",
-		.dev		= &sdp3430_dss_device.dev,
-	}
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
 };
 
 static struct regulator_init_data sdp3430_vpll2 = {
@@ -797,7 +780,7 @@ static void __init omap_3430sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3430_i2c_init();
-	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
+	omap_display_init(&sdp3430_dss_data);
 	if (omap_rev() > OMAP3430_REV_ES1_0)
 		ts_gpio = SDP3430_TS_GPIO_IRQ_SDPV2;
 	else
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2dbb265..523ce27 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -28,6 +28,7 @@
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 #include <plat/dma.h>
+#include <plat/display.h>
 
 #include "mux.h"
 
@@ -813,6 +814,37 @@ static inline void omap_hdq_init(void) {}
 #endif
 
 /*---------------------------------------------------------------------------*/
+#ifdef CONFIG_OMAP2_DSS
+
+static struct platform_device omap_display_device = {
+	.name          = "omapdss",
+	.id            = -1,
+	.dev            = {
+		.platform_data = NULL,
+	},
+};
+
+void __init omap_display_init(struct omap_dss_board_info
+					*board_data)
+{
+
+	omap_display_device.dev.platform_data = board_data;
+
+	if (platform_device_register(&omap_display_device) < 0)
+		printk(KERN_ERR "Unable to register OMAP-Display device\n");
+
+
+	return ;
+}
+
+#else
+void __init omap_display_init(struct omap_dss_board_info *board_data)
+{
+}
+#endif
+
+
+/*---------------------------------------------------------------------------*/
 
 #if defined(CONFIG_VIDEO_OMAP2_VOUT) || \
 	defined(CONFIG_VIDEO_OMAP2_VOUT_MODULE)
diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 1c529ce..f5da4ae 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -23,6 +23,7 @@
 #include <linux/list.h>
 #include <linux/kobject.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
 #include <asm/atomic.h>
 
 #define DISPC_IRQ_FRAMEDONE		(1 << 0)
@@ -251,6 +252,9 @@ struct omap_dss_board_info {
 	struct omap_dss_device *default_device;
 };
 
+/* Init with the board info */
+extern void omap_display_init(struct omap_dss_board_info *board_data);
+
 struct omap_video_timings {
 	/* Unit: pixels */
 	u16 x_res;
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index b3a498f..bcbb077 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -52,6 +52,7 @@ static struct {
 	struct regulator *vdds_dsi_reg;
 	struct regulator *vdds_sdi_reg;
 	struct regulator *vdda_dac_reg;
+	struct omap_dss_board_info *pdata;
 } core;
 
 static void dss_clk_enable_all_no_ctx(void);
@@ -501,6 +502,7 @@ static int omap_dss_probe(struct platform_device *pdev)
 	int i;
 
 	core.pdev = pdev;
+	core.pdata = pdev->dev.platform_data;
 
 	dss_init_overlay_managers(pdev);
 	dss_init_overlays(pdev);
-- 
1.6.3.3


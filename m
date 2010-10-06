From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v1 05/16] OMAP3 DSS Driver register moved to mach_omap2
Date: Wed,  6 Oct 2010 16:44:48 +0530
Message-ID: <1286363699-9614-6-git-send-email-svadivu@ti.com>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
 <1286363699-9614-2-git-send-email-svadivu@ti.com>
 <1286363699-9614-3-git-send-email-svadivu@ti.com>
 <1286363699-9614-4-git-send-email-svadivu@ti.com>
 <1286363699-9614-5-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32909 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758878Ab0JFLPS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 07:15:18 -0400
In-Reply-To: <1286363699-9614-5-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Move DSS driver register from board file to devices.c
Regulator initialisation done with driver name instead
of device name.
Changed device name from omapdss to omapdisplay as the
driver takes care of panel information.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c       |   25 +++-------------------
 arch/arm/mach-omap2/devices.c             |   32 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h |    4 +++
 drivers/video/omap2/dss/core.c            |    2 +-
 4 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 3eb9839..62b6523 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -302,22 +302,8 @@ static struct omap_dss_board_info sdp3430_dss_data = {
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
+	REGULATOR_SUPPLY("vdda_dac", "omapdisplay");
 
 static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 };
@@ -541,10 +527,7 @@ static struct regulator_init_data sdp3430_vdac = {
 
 /* VPLL2 for digital video outputs */
 static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
-	{
-		.supply		= "vdds_dsi",
-		.dev		= &sdp3430_dss_device.dev,
-	}
+	REGULATOR_SUPPLY("vdds_dsi", "omapdisplay"),
 };
 
 static struct regulator_init_data sdp3430_vpll2 = {
@@ -798,7 +781,7 @@ static void __init omap_3430sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3430_i2c_init();
-	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
+	omap_display_init(&sdp3430_dss_data);
 	if (omap_rev() > OMAP3430_REV_ES1_0)
 		ts_gpio = SDP3430_TS_GPIO_IRQ_SDPV2;
 	else
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 9e5d51b..0702b87 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -28,6 +28,7 @@
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 #include <plat/dma.h>
+#include <plat/display.h>
 
 #include "mux.h"
 
@@ -885,6 +886,37 @@ static inline void omap_hdq_init(void) {}
 #endif
 
 /*---------------------------------------------------------------------------*/
+#ifdef CONFIG_OMAP2_DSS
+
+static struct platform_device omap_display_device = {
+	.name          = "omapdisplay",
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
index 8bd15bd..4b71be3 100644
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
index b3a498f..0f267e6 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -712,7 +712,7 @@ static struct platform_driver omap_dss_driver = {
 	.suspend	= omap_dss_suspend,
 	.resume		= omap_dss_resume,
 	.driver         = {
-		.name   = "omapdss",
+		.name   = "omapdisplay",
 		.owner  = THIS_MODULE,
 	},
 };
-- 
1.6.3.3


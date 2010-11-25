From: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
Subject: [PATCH 1/2] Added video data to support tvout on rx51
Date: Thu, 25 Nov 2010 17:52:22 +0200
Message-ID: <1290700343-26640-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:54056 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989Ab0KYPxc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 10:53:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org
Cc: Srikar <ext-srikar.1.bhavanarayana@nokia.com>

To support tvout on rx51,added Intilization data,
tvout as display device and enabled venc through gpio
on rx51

Signed-off-by: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-video.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 85503fe..9919581 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -14,7 +14,6 @@
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/mm.h>
-
 #include <asm/mach-types.h>
 #include <plat/display.h>
 #include <plat/vram.h>
@@ -25,6 +24,9 @@
 #include "mux.h"
 
 #define RX51_LCD_RESET_GPIO	90
+/* REVISIT  to verify with rx51.c at sound/soc/omap */
+#define RX51_TVOUT_SEL_GPIO	40
+
 
 #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
 
@@ -39,6 +41,17 @@ static void rx51_lcd_disable(struct omap_dss_device *dssdev)
 	gpio_set_value(dssdev->reset_gpio, 0);
 }
 
+static int rx51_tvout_enable(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(dssdev->reset_gpio, 1);
+	return 0;
+}
+
+static void rx51_tvout_disable(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(dssdev->reset_gpio, 0);
+}
+
 static struct omap_dss_device rx51_lcd_device = {
 	.name			= "lcd",
 	.driver_name		= "panel-acx565akm",
@@ -49,8 +62,19 @@ static struct omap_dss_device rx51_lcd_device = {
 	.platform_disable	= rx51_lcd_disable,
 };
 
+static struct omap_dss_device  rx51_tv_device = {
+	.name			= "tv",
+	.type			= OMAP_DISPLAY_TYPE_VENC,
+	.driver_name		= "venc",
+	.phy.venc.type	        = OMAP_DSS_VENC_TYPE_COMPOSITE,
+	.reset_gpio	        = RX51_TVOUT_SEL_GPIO,
+	.platform_enable        = rx51_tvout_enable,
+	.platform_disable       = rx51_tvout_disable,
+};
+
 static struct omap_dss_device *rx51_dss_devices[] = {
 	&rx51_lcd_device,
+	&rx51_tv_device,
 };
 
 static struct omap_dss_board_info rx51_dss_board_info = {
@@ -88,6 +112,9 @@ static int __init rx51_video_init(void)
 
 	gpio_direction_output(RX51_LCD_RESET_GPIO, 1);
 
+	/* REVISIT  to verify with rx51.c at sound/soc/omap */
+	gpio_direction_output(RX51_TVOUT_SEL_GPIO, 1);
+
 	platform_add_devices(rx51_video_devices,
 				ARRAY_SIZE(rx51_video_devices));
 	return 0;
-- 
1.7.1


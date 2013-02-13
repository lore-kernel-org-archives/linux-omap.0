From: Archit Taneja <archit@ti.com>
Subject: [PATCH 17/33] arm: omap: board-rx-51: use acx565akm panel's gpio handling
Date: Wed, 13 Feb 2013 19:52:09 +0530
Message-ID: <1360765345-19312-18-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40234 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757028Ab3BMOYG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:24:06 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>

The rx-51 board file currently requests gpios required by the acx565akm panel,
and provides platform_enable/disable callbacks to configure them.

These tasks have been moved to the acx565akm panel driver itself and shouldn't
be done in the board files.

Remove the gpio requests and the platform callbacks from the board file. Pass
the panel_acx565akm_data instance 'lcd_data' to omap_dss_device instead of
passing the gpio number in omap_dss_device's reset_gpio.

Add the gpio information to panel_acx565akm_data so that it's passed to the
panel driver.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-rx51-video.c |   26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 46f4fc9..9e8afa4 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -16,6 +16,8 @@
 #include <linux/mm.h>
 #include <asm/mach-types.h>
 #include <video/omapdss.h>
+#include <video/omap-panel-data.h>
+
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include "board-rx51.h"
@@ -26,25 +28,16 @@
 
 #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
 
-static int rx51_lcd_enable(struct omap_dss_device *dssdev)
-{
-	gpio_set_value(dssdev->reset_gpio, 1);
-	return 0;
-}
-
-static void rx51_lcd_disable(struct omap_dss_device *dssdev)
-{
-	gpio_set_value(dssdev->reset_gpio, 0);
-}
+static struct panel_acx565akm_data lcd_data = {
+	.reset_gpio	= RX51_LCD_RESET_GPIO,
+};
 
 static struct omap_dss_device rx51_lcd_device = {
 	.name			= "lcd",
 	.driver_name		= "panel-acx565akm",
 	.type			= OMAP_DISPLAY_TYPE_SDI,
 	.phy.sdi.datapairs	= 2,
-	.reset_gpio		= RX51_LCD_RESET_GPIO,
-	.platform_enable	= rx51_lcd_enable,
-	.platform_disable	= rx51_lcd_disable,
+	.data			= &lcd_data,
 };
 
 static struct omap_dss_device  rx51_tv_device = {
@@ -75,13 +68,8 @@ static int __init rx51_video_init(void)
 		return 0;
 	}
 
-	if (gpio_request_one(RX51_LCD_RESET_GPIO, GPIOF_OUT_INIT_HIGH,
-			     "LCD ACX565AKM reset")) {
-		pr_err("%s failed to get LCD Reset GPIO\n", __func__);
-		return 0;
-	}
-
 	omap_display_init(&rx51_dss_board_info);
+
 	return 0;
 }
 
-- 
1.7.9.5


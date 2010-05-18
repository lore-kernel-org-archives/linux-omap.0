From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 12/14] OMAP2: Devkit8000: Using gpio_is_valid
Date: Tue, 18 May 2010 14:05:33 +0200
Message-ID: <1274184335-29322-13-git-send-email-weber@corscience.de>
References: <1274184335-29322-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56023 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757236Ab0ERMGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:06:04 -0400
In-Reply-To: <1274184335-29322-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

Using the macro gpio_is_valid for check of valid gpio pins.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index bb3f3f5..de7c28a 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -134,27 +134,27 @@ static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
 	twl_i2c_write_u8(TWL4030_MODULE_GPIO, 0x80, REG_GPIODATADIR1);
 	twl_i2c_write_u8(TWL4030_MODULE_LED, 0x0, 0x0);
 
-	if (dssdev->reset_gpio != -EINVAL)
+	if (gpio_is_valid(dssdev->reset_gpio))
 		gpio_set_value(dssdev->reset_gpio, 1);
 	return 0;
 }
 
 static void devkit8000_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
-	if (dssdev->reset_gpio != -EINVAL)
+	if (gpio_is_valid(dssdev->reset_gpio))
 		gpio_set_value(dssdev->reset_gpio, 0);
 }
 
 static int devkit8000_panel_enable_dvi(struct omap_dss_device *dssdev)
 {
-	if (dssdev->reset_gpio != -EINVAL)
+	if (gpio_is_valid(dssdev->reset_gpio))
 		gpio_set_value(dssdev->reset_gpio, 1);
 	return 0;
 }
 
 static void devkit8000_panel_disable_dvi(struct omap_dss_device *dssdev)
 {
-	if (dssdev->reset_gpio != -EINVAL)
+	if (gpio_is_valid(dssdev->reset_gpio))
 		gpio_set_value(dssdev->reset_gpio, 0);
 }
 
-- 
1.6.4.4


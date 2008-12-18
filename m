From: Manikandan Pillai <mani.pillai@ti.com>
Subject: [PATCH 1/1] LCD backlight support for OMAP3 EVM using TPS6235x based power module
Date: Thu, 18 Dec 2008 09:36:03 +0530
Message-ID: <1229573163-24006-1-git-send-email-mani.pillai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43809 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbYLREGW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Dec 2008 23:06:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, broonie@sirena.org.uk
Cc: Manikandan Pillai <mani.pillai@ti.com>

This patch provides support for LCD backlight enable and disable
for OMAP3 EVM using TPS6235x based PR785 boards.

Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
---
 drivers/video/omap/lcd_omap3evm.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
index 4f373b2..0ea35ba 100644
--- a/drivers/video/omap/lcd_omap3evm.c
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -49,6 +49,9 @@
 #define TWL_PWMA_PWMAON		0x00
 #define TWL_PWMA_PWMAOFF	0x01
 
+/* GPIO on which Backlight can be switched ON/OFF */
+#define	LCD_OMAP3_BKLIGHT_GPIO	141
+
 static unsigned int bklight_level;
 
 static int omap3evm_panel_init(struct lcd_panel *panel,
@@ -71,6 +74,10 @@ static int omap3evm_panel_init(struct lcd_panel *panel,
 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
 #endif
+#if defined(CONFIG_PR785)
+	gpio_request(LCD_OMAP3_BKLIGHT_GPIO, "AE6_34XX_GPIO141");
+#endif
+
 	bklight_level = 100;
 
 	return 0;
@@ -108,7 +115,20 @@ static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
 	}
 	return 0;
 #endif
-	/* Fix this once patch fix is sent out for TPS-boards */
+
+#if defined(CONFIG_OMAP3EVM_PR785)
+	bklight_level = level;
+	/* if it is PR785 card the backlight can only be enabled or disable
+	we will use values <=15 for disable and rest as enabled */
+	if (level <= 15)
+		/* Switch of the backlight for level values <=10 */
+		gpio_direction_output(LCD_OMAP3_BKLIGHT_GPIO, 0);
+	else
+		gpio_direction_output(LCD_OMAP3_BKLIGHT_GPIO, 1);
+
+	return 0;
+#endif
+	/* if neither of them is defined, it's an error */
 	return -1;
 }
 
-- 
1.5.6


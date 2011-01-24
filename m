From: hvaibhav@ti.com
Subject: [PATCH] OMAP:board-omap3evm: Change TWL related gpio API's to gpio*_cansleep
Date: Mon, 24 Jan 2011 20:01:25 +0530
Message-ID: <1295879485-12656-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37516 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab1AXObe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 09:31:34 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Since TWL GPIO's can go into sleep, and using normal
gpio_get/set_value() API will lead to kernel dump (WARN_ON()).
So replacing standard gpio_get/set_value() to
gpio_get_set_value_cansleep().

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 323c380..a158d21 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -235,9 +235,9 @@ static int omap3_evm_enable_lcd(struct omap_dss_device *dssdev)
 	gpio_set_value(OMAP3EVM_LCD_PANEL_ENVDD, 0);
 
 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
-		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
+		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
 	else
-		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
+		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
 
 	lcd_enabled = 1;
 	return 0;
@@ -248,9 +248,9 @@ static void omap3_evm_disable_lcd(struct omap_dss_device *dssdev)
 	gpio_set_value(OMAP3EVM_LCD_PANEL_ENVDD, 1);
 
 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
-		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
+		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
 	else
-		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
+		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
 
 	lcd_enabled = 0;
 }
@@ -289,7 +289,7 @@ static int omap3_evm_enable_dvi(struct omap_dss_device *dssdev)
 		return -EINVAL;
 	}
 
-	gpio_set_value(OMAP3EVM_DVI_PANEL_EN_GPIO, 1);
+	gpio_set_value_cansleep(OMAP3EVM_DVI_PANEL_EN_GPIO, 1);
 
 	dvi_enabled = 1;
 	return 0;
@@ -297,7 +297,7 @@ static int omap3_evm_enable_dvi(struct omap_dss_device *dssdev)
 
 static void omap3_evm_disable_dvi(struct omap_dss_device *dssdev)
 {
-	gpio_set_value(OMAP3EVM_DVI_PANEL_EN_GPIO, 0);
+	gpio_set_value_cansleep(OMAP3EVM_DVI_PANEL_EN_GPIO, 0);
 
 	dvi_enabled = 0;
 }
-- 
1.6.2.4


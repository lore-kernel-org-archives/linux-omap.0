From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 1/5] OMAP:board-omap3evm: Change TWL related gpio API's to gpio*_cansleep
Date: Tue, 25 Jan 2011 23:07:37 +0530
Message-ID: <1295977061-11086-2-git-send-email-hvaibhav@ti.com>
References: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48288 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061Ab1AYRhs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 12:37:48 -0500
In-Reply-To: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

Since TWL GPIO's can go into sleep, and using normal
gpio_get/set_value() API will lead to kernel dump (WARN_ON()).
So replacing standard gpio_get/set_value() to
gpio_get/set_value_cansleep().

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 97e0f65..8d2e413 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -268,9 +268,9 @@ static int omap3_evm_enable_lcd(struct omap_dss_device *dssdev)
 	gpio_set_value(OMAP3EVM_LCD_PANEL_ENVDD, 0);

 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
-		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
+		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
 	else
-		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
+		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);

 	lcd_enabled = 1;
 	return 0;
@@ -281,9 +281,9 @@ static void omap3_evm_disable_lcd(struct omap_dss_device *dssdev)
 	gpio_set_value(OMAP3EVM_LCD_PANEL_ENVDD, 1);

 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
-		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
+		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
 	else
-		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
+		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);

 	lcd_enabled = 0;
 }
@@ -322,7 +322,7 @@ static int omap3_evm_enable_dvi(struct omap_dss_device *dssdev)
 		return -EINVAL;
 	}

-	gpio_set_value(OMAP3EVM_DVI_PANEL_EN_GPIO, 1);
+	gpio_set_value_cansleep(OMAP3EVM_DVI_PANEL_EN_GPIO, 1);

 	dvi_enabled = 1;
 	return 0;
@@ -330,7 +330,7 @@ static int omap3_evm_enable_dvi(struct omap_dss_device *dssdev)

 static void omap3_evm_disable_dvi(struct omap_dss_device *dssdev)
 {
-	gpio_set_value(OMAP3EVM_DVI_PANEL_EN_GPIO, 0);
+	gpio_set_value_cansleep(OMAP3EVM_DVI_PANEL_EN_GPIO, 0);

 	dvi_enabled = 0;
 }
--
1.6.2.4


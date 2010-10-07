From: hvaibhav@ti.com
Subject: [PATCH] omap3evm:DSS: Replace TWL gpio API to gpio*_cansleep
Date: Thu,  7 Oct 2010 21:49:24 +0530
Message-ID: <1286468365-23173-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50593 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab0JGQTa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 12:19:30 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o97GJRrJ021834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 7 Oct 2010 11:19:29 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Since access to TWL GPIO's can go into sleep, and using normal
gpio_get/set_value() API will lead to kernel dump (of WARN_ON()).

On OMAP3EVM LCD backlight & DVI encoder is controller through
TWL GPIO, so replacing normal gpio_get/set_value() to
gpio_get_set_value_cansleep().

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index adfb7ad..633c89e 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -234,9 +234,9 @@ static int omap3_evm_enable_lcd(struct omap_dss_device *dssdev)
 	gpio_set_value(OMAP3EVM_LCD_PANEL_ENVDD, 0);

 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
-		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
+		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
 	else
-		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
+		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);

 	lcd_enabled = 1;
 	return 0;
@@ -247,9 +247,9 @@ static void omap3_evm_disable_lcd(struct omap_dss_device *dssdev)
 	gpio_set_value(OMAP3EVM_LCD_PANEL_ENVDD, 1);

 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
-		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
+		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
 	else
-		gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
+		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);

 	lcd_enabled = 0;
 }
@@ -288,7 +288,7 @@ static int omap3_evm_enable_dvi(struct omap_dss_device *dssdev)
 		return -EINVAL;
 	}

-	gpio_set_value(OMAP3EVM_DVI_PANEL_EN_GPIO, 1);
+	gpio_set_value_cansleep(OMAP3EVM_DVI_PANEL_EN_GPIO, 1);

 	dvi_enabled = 1;
 	return 0;
@@ -296,7 +296,7 @@ static int omap3_evm_enable_dvi(struct omap_dss_device *dssdev)

 static void omap3_evm_disable_dvi(struct omap_dss_device *dssdev)
 {
-	gpio_set_value(OMAP3EVM_DVI_PANEL_EN_GPIO, 0);
+	gpio_set_value_cansleep(OMAP3EVM_DVI_PANEL_EN_GPIO, 0);

 	dvi_enabled = 0;
 }
--
1.6.2.4


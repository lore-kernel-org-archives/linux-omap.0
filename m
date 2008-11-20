From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH] OMAP: Switch to gpio_direction_output in OMAP_LDP.
Date: Thu, 20 Nov 2008 22:01:03 +0800
Message-ID: <1227189663-27966-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:54341 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbYKTNyt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2008 08:54:49 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mAKDsmPq015596
	for <linux-omap@vger.kernel.org>; Thu, 20 Nov 2008 05:54:48 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

stop using omap_set_gpio_direction() and switch to gpio_direction_output(),
make omap_ldp can build sucessfully.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/board-ldp.c |    2 +-
 drivers/video/omap/lcd_ldp.c    |    8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index bc66b28..a59e4eb 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -341,7 +341,7 @@ static inline void __init ldp_init_smc911x(void)
 				eth_gpio);
 		return;
 	}
-	omap_set_gpio_direction(eth_gpio, 1);
+	gpio_direction_input(eth_gpio);
 }
 
 
diff --git a/drivers/video/omap/lcd_ldp.c b/drivers/video/omap/lcd_ldp.c
index e944166..5892765 100644
--- a/drivers/video/omap/lcd_ldp.c
+++ b/drivers/video/omap/lcd_ldp.c
@@ -69,17 +69,15 @@ static int ldp_panel_init(struct lcd_panel *panel,
 	gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd panel");
 	gpio_request(LCD_PANEL_BACKLIGHT_GPIO, "lcd backlight");
 
-	omap_set_gpio_direction(LCD_PANEL_QVGA_GPIO, 0);
-	omap_set_gpio_direction(LCD_PANEL_RESET_GPIO, 0);
 	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
 	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
 
 #ifdef CONFIG_FB_OMAP_LCD_VGA
-	omap_set_gpio_dataout(LCD_PANEL_QVGA_GPIO, 0);
+	gpio_direction_output(LCD_PANEL_QVGA_GPIO, 0);
 #else
-	omap_set_gpio_dataout(LCD_PANEL_QVGA_GPIO, 1);
+	gpio_direction_output(LCD_PANEL_QVGA_GPIO, 1);
 #endif
-	omap_set_gpio_dataout(LCD_PANEL_RESET_GPIO, 1);
+	gpio_direction_output(LCD_PANEL_RESET_GPIO, 1);
 
 	return 0;
 }
-- 
1.5.6.3


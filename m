From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCHv2 1/3] OMAP: Switch to standard gpio interface in OMAP_LDP
Date: Fri, 21 Nov 2008 15:51:08 +0800
Message-ID: <1227253870-4407-2-git-send-email-stanley.miao@windriver.com>
References: <1227253870-4407-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51051 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbYKUHo4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Nov 2008 02:44:56 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mAL7iuDp021175
	for <linux-omap@vger.kernel.org>; Thu, 20 Nov 2008 23:44:56 -0800 (PST)
In-Reply-To: <1227253870-4407-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Switch to standard gpio interface and make LDP can build success.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/board-ldp.c |    4 ++--
 drivers/video/omap/lcd_ldp.c    |   16 +++++++---------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 103ce6d..cfa2cde 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -344,12 +344,12 @@ static inline void __init ldp_init_smc911x(void)
 
 	ldp_smc911x_resources[1].start = OMAP_GPIO_IRQ(eth_gpio);
 
-	if (omap_request_gpio(eth_gpio) < 0) {
+	if (gpio_request(eth_gpio, "LAN IRQ line") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc911x IRQ\n",
 				eth_gpio);
 		return;
 	}
-	omap_set_gpio_direction(eth_gpio, 1);
+	gpio_direction_input(eth_gpio);
 }
 
 
diff --git a/drivers/video/omap/lcd_ldp.c b/drivers/video/omap/lcd_ldp.c
index e944166..66a6b91 100644
--- a/drivers/video/omap/lcd_ldp.c
+++ b/drivers/video/omap/lcd_ldp.c
@@ -64,30 +64,28 @@
 static int ldp_panel_init(struct lcd_panel *panel,
 				struct omapfb_device *fbdev)
 {
-	omap_request_gpio(LCD_PANEL_RESET_GPIO);
-	omap_request_gpio(LCD_PANEL_QVGA_GPIO);
+	gpio_request(LCD_PANEL_RESET_GPIO, "lcd reset");
+	gpio_request(LCD_PANEL_QVGA_GPIO, "VGA/QVGA switch");
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
 
 static void ldp_panel_cleanup(struct lcd_panel *panel)
 {
-	omap_free_gpio(LCD_PANEL_RESET_GPIO);
-	omap_free_gpio(LCD_PANEL_QVGA_GPIO);
+	gpio_free(LCD_PANEL_RESET_GPIO);
+	gpio_free(LCD_PANEL_QVGA_GPIO);
 	gpio_free(LCD_PANEL_ENABLE_GPIO);
 	gpio_free(LCD_PANEL_BACKLIGHT_GPIO);
 }
-- 
1.5.6.3


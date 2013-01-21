From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: board-zoom: Do not request LCD panel enable GPIO from twl4030
Date: Mon, 21 Jan 2013 14:27:14 +0100
Message-ID: <1358774834-32463-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38877 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195Ab3AUN1W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jan 2013 08:27:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The pin in question is muxed between GPIO7 and PWM1. For backlight control
there is a custom code in board-zoom-display to control the backlight.
No need to request the GPIO7 - which was failing since the way it is
requested no longer valid: twl's gpio range is allocated dynamically.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Tony,

This patch is generated on top of my previous series for audio/pwm support:
http://www.spinics.net/lists/linux-omap/msg85085.html

Regards,
Peter

 arch/arm/mach-omap2/board-zoom-peripherals.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index f4ea926..0745bd9 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -38,8 +38,6 @@
 #define OMAP_ZOOM_TSC2004_IRQ_GPIO	(153)
 #define OMAP_ZOOM_WLAN_IRQ_GPIO		(162)
 
-#define LCD_PANEL_ENABLE_GPIO		(7 + OMAP_MAX_GPIO_LINES)
-
 /* Zoom2 has Qwerty keyboard*/
 static uint32_t board_keymap[] = {
 	KEY(0, 0, KEY_E),
@@ -243,23 +241,15 @@ static struct omap_tw4030_pdata omap_twl4030_audio_data = {
 static int zoom_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	int ret;
-
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
 	omap_hsmmc_late_init(mmc);
 
-	ret = gpio_request_one(LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW,
-			       "lcd enable");
-	if (ret)
-		pr_err("Failed to get LCD_PANEL_ENABLE_GPIO (gpio%d).\n",
-				LCD_PANEL_ENABLE_GPIO);
-
 	/* Audio setup */
 	omap_twl4030_audio_data.jack_detect = gpio + 2;
 	omap_twl4030_audio_init("Zoom2", &omap_twl4030_audio_data);
 
-	return ret;
+	return 0;
 }
 
 static struct twl4030_gpio_platform_data zoom_gpio_data = {
-- 
1.8.1.1


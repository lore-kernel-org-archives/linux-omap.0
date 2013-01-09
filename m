From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH for 3.8] ARM: OMAP: zoom-display: Remove the use of TWL4030_MODULE_PWM1
Date: Wed, 9 Jan 2013 11:00:28 +0100
Message-ID: <1357725628-25120-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45557 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757749Ab3AIKAg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jan 2013 05:00:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

Use the future proof TWL_MODULE_PWM module id instead to aim the twl-core
cleanup planed for 3.9 kernel cycle.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Tony,

can you queue this patch for 3.8 cycle?
With the second part of my twl-core cleanup series I have overlooked this file
since in my working tree I ahve already removed this part of the code and
switched zoom to use the bl-pwm driver for the backlight.

I will resend the series which is doing that on top of this patch:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82724.html

Thank you,
Peter

 arch/arm/mach-omap2/board-zoom-display.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index 1c7c834..8cef477 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -49,13 +49,13 @@ static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
 }
 
-/*
- * PWMA/B register offsets (TWL4030_MODULE_PWMA)
- */
+/* Register offsets in TWL4030_MODULE_INTBR */
 #define TWL_INTBR_PMBR1	0xD
 #define TWL_INTBR_GPBR1	0xC
-#define TWL_LED_PWMON	0x0
-#define TWL_LED_PWMOFF	0x1
+
+/* Register offsets in TWL_MODULE_PWM */
+#define TWL_LED_PWMON	0x3
+#define TWL_LED_PWMOFF	0x4
 
 static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
 {
@@ -93,8 +93,8 @@ static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
 	}
 
 	c = ((50 * (100 - level)) / 100) + 1;
-	twl_i2c_write_u8(TWL4030_MODULE_PWM1, 0x7F, TWL_LED_PWMOFF);
-	twl_i2c_write_u8(TWL4030_MODULE_PWM1, c, TWL_LED_PWMON);
+	twl_i2c_write_u8(TWL_MODULE_PWM, 0x7F, TWL_LED_PWMOFF);
+	twl_i2c_write_u8(TWL_MODULE_PWM, c, TWL_LED_PWMON);
 #else
 	pr_warn("Backlight not enabled\n");
 #endif
-- 
1.8.1


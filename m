From: "stanley.miao" <stanley.miao@windriver.com>
Subject: [PATCH] ARM: OMAP3: Fix omapfb's problem on OMAP3430sdp
Date: Mon, 01 Sep 2008 21:37:08 +0800
Message-ID: <1220276228.2680.9.camel@localhost>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44467 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbYIBBtH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2008 21:49:07 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m821n5Rm011363
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 18:49:05 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

In RGB565 mode, red and blue color are filtered, so the picture on LCD
looks green and dark.

Fix omapfb's problem on OMAP3430sdp.

Signed-off-by: Stanley Miao <stanley.miao@windriver.com>

---
diff --git a/drivers/video/omap/lcd_2430sdp.c
b/drivers/video/omap/lcd_2430sdp.c
index 9af6cd0..896a236 100644
--- a/drivers/video/omap/lcd_2430sdp.c
+++ b/drivers/video/omap/lcd_2430sdp.c
@@ -23,6 +23,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/delay.h>
 #include <linux/i2c/twl4030.h>
 
 #include <mach/gpio.h>
@@ -45,6 +46,10 @@ static unsigned enable_gpio;
 #define ENABLE_VAUX3_DEDICATED	0x03
 #define ENABLE_VAUX3_DEV_GRP	0x20
 
+#define ENABLE_VPLL2_DEDICATED          0x05
+#define ENABLE_VPLL2_DEV_GRP            0xE0
+#define TWL4030_VPLL2_DEV_GRP           0x33
+#define TWL4030_VPLL2_DEDICATED         0x36
 
 #define t2_out(c, r, v) twl4030_i2c_write_u8(c, r, v)
 
@@ -76,6 +81,11 @@ static int sdp2430_panel_enable(struct lcd_panel
*panel)
 {
 	u8 ded_val, ded_reg;
 	u8 grp_val, grp_reg;
+	
+	if(!is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
+		t2_out(PM_RECEIVER, ENABLE_VPLL2_DEDICATED,TWL4030_VPLL2_DEDICATED);
+		t2_out(PM_RECEIVER, ENABLE_VPLL2_DEV_GRP,TWL4030_VPLL2_DEV_GRP);
+	}
 
 	if (machine_is_omap_3430sdp()) {
 		ded_reg = TWL4030_VAUX3_DEDICATED;
@@ -104,6 +114,11 @@ static void sdp2430_panel_disable(struct lcd_panel
*panel)
 {
 	omap_set_gpio_dataout(enable_gpio, 0);
 	omap_set_gpio_dataout(backlight_gpio, 0);
+	if(!is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
+		t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
+		t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
+		mdelay(4);
+	}
 }
 
 static unsigned long sdp2430_panel_get_caps(struct lcd_panel *panel)

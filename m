From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix omapfb's problem on OMAP3430sdp
Date: Tue, 02 Sep 2008 17:33:17 +0800
Message-ID: <1220347997.7042.5.camel@localhost>
References: <1220276228.2680.9.camel@localhost>
	 <c656a4d20809012249p43213688pce54884c24541fcd@mail.gmail.com>
	 <1220336007.19839.6.camel@localhost>  <20080902081429.GB6928@frodo>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:37024 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbYIBJbo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Sep 2008 05:31:44 -0400
In-Reply-To: <20080902081429.GB6928@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: arun c <arun.edarath@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks. I resolved the style problem. If gpio function needs to be
changed, I think it should be in a single patch.

Re-send the patch again.

Fix omapfb's problem on OMAP3430

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 drivers/video/omap/lcd_2430sdp.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap/lcd_2430sdp.c
b/drivers/video/omap/lcd_2430sdp.c
index 9af6cd0..cf8d2a5 100644
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
 
@@ -77,6 +82,13 @@ static int sdp2430_panel_enable(struct lcd_panel
*panel)
 	u8 ded_val, ded_reg;
 	u8 grp_val, grp_reg;
 
+	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+		t2_out(PM_RECEIVER, ENABLE_VPLL2_DEDICATED,
+					TWL4030_VPLL2_DEDICATED);
+		t2_out(PM_RECEIVER, ENABLE_VPLL2_DEV_GRP,
+					TWL4030_VPLL2_DEV_GRP);
+	}
+
 	if (machine_is_omap_3430sdp()) {
 		ded_reg = TWL4030_VAUX3_DEDICATED;
 		ded_val = ENABLE_VAUX3_DEDICATED;
@@ -104,6 +116,11 @@ static void sdp2430_panel_disable(struct lcd_panel
*panel)
 {
 	omap_set_gpio_dataout(enable_gpio, 0);
 	omap_set_gpio_dataout(backlight_gpio, 0);
+	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+		t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
+		t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
+		mdelay(4);
+	}
 }
 
 static unsigned long sdp2430_panel_get_caps(struct lcd_panel *panel)
-- 
1.5.6.3


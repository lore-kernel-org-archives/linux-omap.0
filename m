From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 1/2] omapfb: lcd_ams_delta: add support for contrast control
Date: Mon, 16 Nov 2009 03:47:01 +0100
Message-ID: <200911160347.06415.jkrzyszt@tis.icnet.pl>
References: <200911160340.13899.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:50959 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613AbZKPCrp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 Nov 2009 21:47:45 -0500
In-Reply-To: <200911160340.13899.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, Tony Lindgren <tony@atomide.com>

The patch extends the Amstrad Delta LCD panel driver with optional support for
changing contrast using standard LCD class device API instead of setting it
silently to a default value at panel enable. It also allows for lowering power
consumption by turning off OMAP_PWL_CLK_ENABLE via lcd_ops.set_power callback.

Created and tested against linux-omap for-next,
commit 155a75d9725e66e5ec8a383822957dee52427057.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
--- a/drivers/video/omap/lcd_ams_delta.c	2009-11-14 23:49:16.000000000 +0100
+++ b/drivers/video/omap/lcd_ams_delta.c	2009-11-16 01:32:19.000000000 +0100
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/lcd.h>
 
 #include <plat/board-ams-delta.h>
 #include <mach/hardware.h>
@@ -31,6 +32,71 @@
 
 #define AMS_DELTA_DEFAULT_CONTRAST	112
 
+#define AMS_DELTA_MAX_CONTRAST		0x00FF
+#define AMS_DELTA_LCD_POWER		0x0100
+
+
+/* LCD class device section */
+
+static int ams_delta_lcd;
+
+static int ams_delta_lcd_set_power(struct lcd_device *dev, int power)
+{
+	if (power == FB_BLANK_UNBLANK) {
+		if (!(ams_delta_lcd & AMS_DELTA_LCD_POWER)) {
+			omap_writeb(ams_delta_lcd & AMS_DELTA_MAX_CONTRAST,
+					OMAP_PWL_ENABLE);
+			omap_writeb(1, OMAP_PWL_CLK_ENABLE);
+			ams_delta_lcd |= AMS_DELTA_LCD_POWER;
+		}
+	} else {
+		if (ams_delta_lcd & AMS_DELTA_LCD_POWER) {
+			omap_writeb(0, OMAP_PWL_ENABLE);
+			omap_writeb(0, OMAP_PWL_CLK_ENABLE);
+			ams_delta_lcd &= ~AMS_DELTA_LCD_POWER;
+		}
+	}
+	return 0;
+}
+
+static int ams_delta_lcd_set_contrast(struct lcd_device *dev, int value)
+{
+	if ((value >= 0) && (value <= AMS_DELTA_MAX_CONTRAST)) {
+		omap_writeb(value, OMAP_PWL_ENABLE);
+		ams_delta_lcd &= ~AMS_DELTA_MAX_CONTRAST;
+		ams_delta_lcd |= value;
+	}
+	return 0;
+}
+
+#ifdef CONFIG_LCD_CLASS_DEVICE
+static int ams_delta_lcd_get_power(struct lcd_device *dev)
+{
+	if (ams_delta_lcd & AMS_DELTA_LCD_POWER)
+		return FB_BLANK_UNBLANK;
+	else
+		return FB_BLANK_POWERDOWN;
+}
+
+static int ams_delta_lcd_get_contrast(struct lcd_device *dev)
+{
+	if (!(ams_delta_lcd & AMS_DELTA_LCD_POWER))
+		return 0;
+
+	return ams_delta_lcd & AMS_DELTA_MAX_CONTRAST;
+}
+
+static struct lcd_ops ams_delta_lcd_ops = {
+	.get_power = ams_delta_lcd_get_power,
+	.set_power = ams_delta_lcd_set_power,
+	.get_contrast = ams_delta_lcd_get_contrast,
+	.set_contrast = ams_delta_lcd_set_contrast,
+};
+#endif
+
+
+/* omapfb panel section */
+
 static int ams_delta_panel_init(struct lcd_panel *panel,
 		struct omapfb_device *fbdev)
 {
@@ -47,10 +113,6 @@ static int ams_delta_panel_enable(struct
 			AMS_DELTA_LATCH2_LCD_NDISP);
 	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN,
 			AMS_DELTA_LATCH2_LCD_VBLEN);
-
-	omap_writeb(1, OMAP_PWL_CLK_ENABLE);
-	omap_writeb(AMS_DELTA_DEFAULT_CONTRAST, OMAP_PWL_ENABLE);
-
 	return 0;
 }
 
@@ -90,8 +152,31 @@ static struct lcd_panel ams_delta_panel 
 	.get_caps	= ams_delta_panel_get_caps,
 };
 
+
+/* platform driver section */
+
 static int ams_delta_panel_probe(struct platform_device *pdev)
 {
+	struct lcd_device *lcd_device = NULL;
+#ifdef CONFIG_LCD_CLASS_DEVICE
+	int ret;
+
+	lcd_device = lcd_device_register("omapfb", &pdev->dev, NULL,
+						&ams_delta_lcd_ops);
+
+	if (IS_ERR(lcd_device)) {
+		ret = PTR_ERR(lcd_device);
+		dev_err(&pdev->dev, "failed to register device\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, lcd_device);
+	lcd_device->props.max_contrast = AMS_DELTA_MAX_CONTRAST;
+#endif
+
+	ams_delta_lcd_set_contrast(lcd_device, AMS_DELTA_DEFAULT_CONTRAST);
+	ams_delta_lcd_set_power(lcd_device, FB_BLANK_UNBLANK);
+
 	omapfb_register_panel(&ams_delta_panel);
 	return 0;
 }


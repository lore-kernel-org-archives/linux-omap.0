From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 2/2] OMAP: DSS2: Add Seiko 70WVW1TZ3 display panel
Date: Thu, 28 Oct 2010 16:43:02 +0200
Message-ID: <1288276982-17225-3-git-send-email-eballetbo@gmail.com>
References: <1288276982-17225-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46395 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab0J1OnT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Oct 2010 10:43:19 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so2029886wyf.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Oct 2010 07:43:19 -0700 (PDT)
In-Reply-To: <1288276982-17225-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, hvaibhav@ti.com, notasas@gmail.com, roger.quadros@nokia.com, mike@compulab.co.il, linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Add new Seiko 70WVW1TZ3, a LCD 7.0inch WVGA (800x480) display
type with 24-bit RGB interface and Touch-Panel

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 drivers/video/omap2/displays/Kconfig               |    7 +
 drivers/video/omap2/displays/Makefile              |    1 +
 .../video/omap2/displays/panel-seiko-70wvw1tz3.c   |  157 ++++++++++++++++++++
 3 files changed, 165 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-seiko-70wvw1tz3.c

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index c3aa478..d8e580b 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -51,4 +51,11 @@ config PANEL_POWERTIP_PH480272T
 	select BACKLIGHT_CLASS_DEVICE
         help
           LCD Panel used in IGEP boards.
+
+config PANEL_SEIKO_70WVW1TZ3
+	tristate "Seiko 70WVW1TZ3 LCD Panel"
+	depends on OMAP2_DSS
+	select BACKLIGHT_CLASS_DEVICE
+        help
+          7.0 inch LCD Panel used in IGEP boards.
 endmenu
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index 3967dbc..75e888e 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_PANEL_TOPPOLY_TDO35S) += panel-toppoly-tdo35s.o
 obj-$(CONFIG_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
 obj-$(CONFIG_PANEL_ACX565AKM) += panel-acx565akm.o
 obj-$(CONFIG_PANEL_POWERTIP_PH480272T) += panel-powertip-ph480272t.o
+obj-$(CONFIG_PANEL_SEIKO_70WVW1TZ3) += panel-seiko-70wvw1tz3.o
diff --git a/drivers/video/omap2/displays/panel-seiko-70wvw1tz3.c b/drivers/video/omap2/displays/panel-seiko-70wvw1tz3.c
new file mode 100644
index 0000000..0083d54
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-seiko-70wvw1tz3.c
@@ -0,0 +1,157 @@
+/*
+ * LCD panel driver for Seiko 70wvw1tz3Z3
+ *
+ * Copyright (C) 2010, ISEE 2007 SL
+ * Author: Enric Balletbo i Serra <eballetbo@iseebcn.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+
+#include <plat/display.h>
+
+static struct omap_video_timings s70wvw1tz3_timings = {
+	.x_res = 800,
+	.y_res = 480,
+	.pixel_clock	= 33000,
+	.hsw		= 128,
+	.hfp		= 10,
+	.hbp		= 10,
+	.vsw		= 2,
+	.vfp		= 4,
+	.vbp		= 11,
+};
+
+static int s70wvw1tz3_panel_power_on(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	r = omapdss_dpi_display_enable(dssdev);
+	if (r)
+		goto err0;
+
+	/* wait couple of vsyncs until enabling the LCD */
+	msleep(50);
+
+	if (dssdev->platform_enable) {
+		r = dssdev->platform_enable(dssdev);
+		if (r)
+			goto err1;
+	}
+
+	return 0;
+err1:
+	omapdss_dpi_display_disable(dssdev);
+err0:
+	return r;
+}
+
+static void s70wvw1tz3_panel_power_off(struct omap_dss_device *dssdev)
+{
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+
+	/* wait at least 5 vsyncs after disabling the LCD */
+	msleep(100);
+
+	omapdss_dpi_display_disable(dssdev);
+}
+
+static int s70wvw1tz3_panel_probe(struct omap_dss_device *dssdev)
+{
+	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+		OMAP_DSS_LCD_IHS;
+
+	dssdev->panel.acb = 0x0;
+	dssdev->panel.timings = s70wvw1tz3_timings;
+
+	return 0;
+}
+
+static void s70wvw1tz3_panel_remove(struct omap_dss_device *dssdev)
+{
+}
+
+static int s70wvw1tz3_panel_enable(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	r = s70wvw1tz3_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static void s70wvw1tz3_panel_disable(struct omap_dss_device *dssdev)
+{
+	s70wvw1tz3_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+}
+
+static int s70wvw1tz3_panel_suspend(struct omap_dss_device *dssdev)
+{
+	s70wvw1tz3_panel_power_off(dssdev);
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+
+	return 0;
+}
+
+static int s70wvw1tz3_panel_resume(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	r = s70wvw1tz3_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static struct omap_dss_driver s70wvw1tz3_driver = {
+	.probe		= s70wvw1tz3_panel_probe,
+	.remove		= s70wvw1tz3_panel_remove,
+
+	.enable		= s70wvw1tz3_panel_enable,
+	.disable	= s70wvw1tz3_panel_disable,
+	.suspend	= s70wvw1tz3_panel_suspend,
+	.resume		= s70wvw1tz3_panel_resume,
+
+	.driver         = {
+		.name   = "70wvw1tz3",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init s70wvw1tz3_init(void)
+{
+	return omap_dss_register_driver(&s70wvw1tz3_driver);
+}
+
+static void __exit s70wvw1tz3_exit(void)
+{
+	omap_dss_unregister_driver(&s70wvw1tz3_driver);
+}
+
+module_init(s70wvw1tz3_init);
+module_exit(s70wvw1tz3_exit);
+MODULE_LICENSE("GPL");
-- 
1.7.0.4


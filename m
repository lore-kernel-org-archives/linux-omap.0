From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 1/2] OMAP: DSS2: Add Powertip PH480272T display panel
Date: Thu, 28 Oct 2010 16:43:01 +0200
Message-ID: <1288276982-17225-2-git-send-email-eballetbo@gmail.com>
References: <1288276982-17225-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46395 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab0J1OnR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Oct 2010 10:43:17 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so2029886wyf.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Oct 2010 07:43:16 -0700 (PDT)
In-Reply-To: <1288276982-17225-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, hvaibhav@ti.com, notasas@gmail.com, roger.quadros@nokia.com, mike@compulab.co.il, linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Add new Powertip PH480242T panel, a LCD 4.3inch (480x242) display
type with 24-bit RGB interface.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 drivers/video/omap2/displays/Kconfig               |    7 +
 drivers/video/omap2/displays/Makefile              |    1 +
 .../omap2/displays/panel-powertip-ph480272t.c      |  155 ++++++++++++++++++++
 3 files changed, 163 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-powertip-ph480272t.c

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 12327bb..c3aa478 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -44,4 +44,11 @@ config PANEL_ACX565AKM
 	select BACKLIGHT_CLASS_DEVICE
 	help
 	  This is the LCD panel used on Nokia N900
+
+config PANEL_POWERTIP_PH480272T
+	tristate "Powertip PH480272T LCD Panel"
+	depends on OMAP2_DSS
+	select BACKLIGHT_CLASS_DEVICE
+        help
+          LCD Panel used in IGEP boards.
 endmenu
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index aa38609..3967dbc 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_PANEL_TAAL) += panel-taal.o
 obj-$(CONFIG_PANEL_TOPPOLY_TDO35S) += panel-toppoly-tdo35s.o
 obj-$(CONFIG_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
 obj-$(CONFIG_PANEL_ACX565AKM) += panel-acx565akm.o
+obj-$(CONFIG_PANEL_POWERTIP_PH480272T) += panel-powertip-ph480272t.o
diff --git a/drivers/video/omap2/displays/panel-powertip-ph480272t.c b/drivers/video/omap2/displays/panel-powertip-ph480272t.c
new file mode 100644
index 0000000..d303180
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-powertip-ph480272t.c
@@ -0,0 +1,155 @@
+/*
+ * LCD panel driver for Powertip PH480272T
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
+static struct omap_video_timings ph480272t_timings = {
+	.x_res		= 480,
+	.y_res		= 272,
+	.pixel_clock	= 9000,
+	.hsw		= 40,
+	.hfp		= 2,
+	.hbp		= 2,
+	.vsw		= 10,
+	.vfp            = 2,
+	.vbp            = 2,
+};
+
+static int ph480272t_power_on(struct omap_dss_device *dssdev)
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
+static void ph480272t_power_off(struct omap_dss_device *dssdev)
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
+static int ph480272t_probe(struct omap_dss_device *dssdev)
+{
+
+	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+		OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO;
+
+	dssdev->panel.acb = 0x0;
+	dssdev->panel.timings = ph480272t_timings;
+
+	return 0;
+}
+
+static void ph480272t_remove(struct omap_dss_device *dssdev)
+{
+}
+
+static int ph480272t_enable(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	r = ph480272t_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static void ph480272t_disable(struct omap_dss_device *dssdev)
+{
+	ph480272t_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+}
+
+static int ph480272t_suspend(struct omap_dss_device *dssdev)
+{
+	ph480272t_power_off(dssdev);
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+	return 0;
+}
+
+static int ph480272t_resume(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	r = ph480272t_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static struct omap_dss_driver ph480272t_driver = {
+	.probe		= ph480272t_probe,
+	.remove		= ph480272t_remove,
+	.enable		= ph480272t_enable,
+	.disable	= ph480272t_disable,
+	.suspend	= ph480272t_suspend,
+	.resume		= ph480272t_resume,
+	.driver         = {
+		.name   = "ph480272t",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init ph480272t_init(void)
+{
+	return omap_dss_register_driver(&ph480272t_driver);
+}
+
+static void __exit ph480272t_exit(void)
+{
+	omap_dss_unregister_driver(&ph480272t_driver);
+}
+
+module_init(ph480272t_init);
+module_exit(ph480272t_exit);
+MODULE_LICENSE("GPL");
-- 
1.7.0.4


From: hvaibhav@ti.com
Subject: [PATCH 2/5] OMAP: DSS2: Add Sharp LQ043T1DG01 panel drivers
Date: Thu, 17 Dec 2009 20:48:41 +0530
Message-ID: <1261063121-19923-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57013 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965016AbZLQPS7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 10:18:59 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>


Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 drivers/video/omap2/displays/Kconfig               |    6 +
 drivers/video/omap2/displays/Makefile              |    1 +
 .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  120 ++++++++++++++++++++
 3 files changed, 127 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index b12a59c..4ce47dd 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -13,6 +13,12 @@ config PANEL_SHARP_LS037V7DW01
         help
           LCD Panel used in TI's SDP3430 and EVM boards
 
+config PANEL_SHARP_LQ043T1DG01
+        tristate "Sharp LQ043T1DG01 LCD Panel"
+        depends on OMAP2_DSS
+        help
+          LCD Panel used in TI's OMAP3517 EVM boards
+
 config PANEL_TAAL
         tristate "Taal DSI Panel"
         depends on OMAP2_DSS_DSI
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index 9556464..8f3d0ad 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_PANEL_GENERIC) += panel-generic.o
 obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
+obj-$(CONFIG_PANEL_SHARP_LQ043T1DG01) += panel-sharp-lq043t1dg01.o
 
 obj-$(CONFIG_PANEL_TAAL) += panel-taal.o
diff --git a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c b/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
new file mode 100644
index 0000000..e75798e
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
@@ -0,0 +1,120 @@
+/*
+ * LCD panel driver for Sharp LQ043T1DG01
+ *
+ * Copyright (C) 2009 Texas Instruments Inc
+ * Author: Vaibhav Hiremath <hvaibhav@ti.com>
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
+static struct omap_video_timings sharp_lq_timings = {
+	.x_res = 480,
+	.y_res = 272,
+
+	.pixel_clock	= 9000,
+
+	.hsw		= 42,
+	.hfp		= 3,
+	.hbp		= 2,
+
+	.vsw		= 11,
+	.vfp		= 3,
+	.vbp		= 2,
+};
+
+static int sharp_lq_panel_probe(struct omap_dss_device *dssdev)
+{
+
+	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+		OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO;
+	dssdev->panel.acb = 0x0;
+	dssdev->panel.timings = sharp_lq_timings;
+
+	return 0;
+}
+
+static void sharp_lq_panel_remove(struct omap_dss_device *dssdev)
+{
+}
+
+static int sharp_lq_panel_enable(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+
+	/* wait couple of vsyncs until enabling the LCD */
+	msleep(50);
+
+	if (dssdev->platform_enable)
+		r = dssdev->platform_enable(dssdev);
+
+	return r;
+}
+
+static void sharp_lq_panel_disable(struct omap_dss_device *dssdev)
+{
+
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+
+	/* wait at least 5 vsyncs after disabling the LCD */
+
+	msleep(100);
+}
+
+static int sharp_lq_panel_suspend(struct omap_dss_device *dssdev)
+{
+	sharp_lq_panel_disable(dssdev);
+	return 0;
+}
+
+static int sharp_lq_panel_resume(struct omap_dss_device *dssdev)
+{
+	return sharp_lq_panel_enable(dssdev);
+}
+
+static struct omap_dss_driver sharp_lq_driver = {
+	.probe		= sharp_lq_panel_probe,
+	.remove		= sharp_lq_panel_remove,
+
+	.enable		= sharp_lq_panel_enable,
+	.disable	= sharp_lq_panel_disable,
+	.suspend	= sharp_lq_panel_suspend,
+	.resume		= sharp_lq_panel_resume,
+
+	.driver         = {
+		.name   = "sharp_lq_panel",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init sharp_lq_panel_drv_init(void)
+{
+	return omap_dss_register_driver(&sharp_lq_driver);
+}
+
+static void __exit sharp_lq_panel_drv_exit(void)
+{
+	omap_dss_unregister_driver(&sharp_lq_driver);
+}
+
+module_init(sharp_lq_panel_drv_init);
+module_exit(sharp_lq_panel_drv_exit);
+MODULE_LICENSE("GPL");
-- 
1.6.2.4


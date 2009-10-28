From: hvaibhav@ti.com
Subject: [PATCH 2/2] OMAP: DSS2: Add Sharp LQ043T1DG01 panel drivers
Date: Wed, 28 Oct 2009 15:33:52 +0530
Message-ID: <1256724232-22994-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44840 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbZJ1KDu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Oct 2009 06:03:50 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9SA3r5u019991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 05:03:55 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>


Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 drivers/video/omap2/displays/Kconfig               |    6 +
 drivers/video/omap2/displays/Makefile              |    1 +
 .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  120 ++++++++++++++++++++
 3 files changed, 127 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 79d2861..4229a28 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -19,6 +19,12 @@ config PANEL_SHARP_LS037V7DW01
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
index d44e765..9317445 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_PANEL_GENERIC) += panel-generic.o
 obj-$(CONFIG_PANEL_SAMSUNG_LTE430WQ_F0C) += panel-samsung-lte430wq-f0c.o
 obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
+obj-$(CONFIG_PANEL_SHARP_LQ043T1DG01) += panel-sharp-lq043t1dg01.o
 
 obj-$(CONFIG_PANEL_TAAL) += panel-taal.o
diff --git a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c b/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
new file mode 100644
index 0000000..0c1fd46
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
+#include <mach/display.h>
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


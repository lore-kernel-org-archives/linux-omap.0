From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 1/2] OMAP: DSS2: add Toppoly TDO35S panel
Date: Mon, 14 Dec 2009 10:01:07 +0200
Message-ID: <a5065426f4601793612b8b861e93b16ebbe746f9.1260777314.git.mike@compulab.co.il>
References: <cover.1260777313.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:42010 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755165AbZLNIBb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Dec 2009 03:01:31 -0500
In-Reply-To: <cover.1260777313.git.mike@compulab.co.il>
In-Reply-To: <cover.1260777313.git.mike@compulab.co.il>
References: <cover.1260777313.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 drivers/video/omap2/displays/Kconfig               |    6 +
 drivers/video/omap2/displays/Makefile              |    1 +
 .../video/omap2/displays/panel-toppoly-tdo35s.c    |  112 ++++++++++++++++++++
 3 files changed, 119 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-toppoly-tdo35s.c

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index b12a59c..86946e8 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -19,4 +19,10 @@ config PANEL_TAAL
         help
           Taal DSI command mode panel from TPO.
 
+config PANEL_TOPPOLY_TDO35S
+        tristate "Toppoly TDO35S LCD Panel support"
+        depends on OMAP2_DSS
+        help
+          LCD Panel used in CM-T35
+
 endmenu
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index 9556464..0b7c3b3 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_PANEL_GENERIC) += panel-generic.o
 obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
 
 obj-$(CONFIG_PANEL_TAAL) += panel-taal.o
+obj-$(CONFIG_PANEL_TOPPOLY_TDO35S) += panel-toppoly-tdo35s.o
\ No newline at end of file
diff --git a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c b/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
new file mode 100644
index 0000000..e744b8c
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
@@ -0,0 +1,112 @@
+/*
+ * LCD panel driver for Toppoly TDO35S
+ *
+ * Copyright (C) 2009 CompuLab, Ltd.
+ * Author: Mike Rapoport <mike@compulab.co.il>
+ *
+ * Based on generic panel support
+ * Copyright (C) 2008 Nokia Corporation
+ * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
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
+
+#include <plat/display.h>
+
+static struct omap_video_timings toppoly_tdo_panel_timings = {
+	/* 640 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
+	.x_res		= 480,
+	.y_res		= 640,
+
+	.pixel_clock	= 26000,
+
+	.hfp		= 104,
+	.hsw		= 8,
+	.hbp		= 8,
+
+	.vfp		= 4,
+	.vsw		= 2,
+	.vbp		= 2,
+};
+
+static int toppoly_tdo_panel_probe(struct omap_dss_device *dssdev)
+{
+	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+		OMAP_DSS_LCD_IHS;
+	dssdev->panel.timings = toppoly_tdo_panel_timings;
+
+	return 0;
+}
+
+static void toppoly_tdo_panel_remove(struct omap_dss_device *dssdev)
+{
+}
+
+static int toppoly_tdo_panel_enable(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	if (dssdev->platform_enable)
+		r = dssdev->platform_enable(dssdev);
+
+	return r;
+}
+
+static void toppoly_tdo_panel_disable(struct omap_dss_device *dssdev)
+{
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+}
+
+static int toppoly_tdo_panel_suspend(struct omap_dss_device *dssdev)
+{
+	toppoly_tdo_panel_disable(dssdev);
+	return 0;
+}
+
+static int toppoly_tdo_panel_resume(struct omap_dss_device *dssdev)
+{
+	return toppoly_tdo_panel_enable(dssdev);
+}
+
+static struct omap_dss_driver generic_driver = {
+	.probe		= toppoly_tdo_panel_probe,
+	.remove		= toppoly_tdo_panel_remove,
+
+	.enable		= toppoly_tdo_panel_enable,
+	.disable	= toppoly_tdo_panel_disable,
+	.suspend	= toppoly_tdo_panel_suspend,
+	.resume		= toppoly_tdo_panel_resume,
+
+	.driver         = {
+		.name   = "toppoly_tdo35s_panel",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init toppoly_tdo_panel_drv_init(void)
+{
+	return omap_dss_register_driver(&generic_driver);
+}
+
+static void __exit toppoly_tdo_panel_drv_exit(void)
+{
+	omap_dss_unregister_driver(&generic_driver);
+}
+
+module_init(toppoly_tdo_panel_drv_init);
+module_exit(toppoly_tdo_panel_drv_exit);
+MODULE_LICENSE("GPL");
-- 
1.6.4.4


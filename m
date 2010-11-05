From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 2/3] OMAP: DSS2: Add generic panel display driver
Date: Fri,  5 Nov 2010 15:43:55 -0400
Message-ID: <1288986236-30210-3-git-send-email-bryan.wu@canonical.com>
References: <1288986236-30210-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42175 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618Ab0KETo0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 15:44:26 -0400
Received: by mail-qw0-f46.google.com with SMTP id 8so785823qwb.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 12:44:25 -0700 (PDT)
In-Reply-To: <1288986236-30210-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, notasas@gmail.com

Generic panel driver includes the driver and 4 similar panel configurations. It
will match the panel name which is passed from platform data and setup the
right configurations.

With generic panel driver, we can remove those 4 duplicated panel display
drivers. In the future, it is simple for us just add new panel configuration
date in panel-generic.c to support new display panel.

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 drivers/video/omap2/displays/Kconfig     |    8 +
 drivers/video/omap2/displays/Makefile    |    1 +
 drivers/video/omap2/displays/panel-dpi.c |  306 ++++++++++++++++++++++++++++++
 3 files changed, 315 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-dpi.c

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 12327bb..9602d3f 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -1,6 +1,14 @@
 menu "OMAP2/3 Display Device Drivers"
         depends on OMAP2_DSS
 
+config PANEL_DPI
+        tristate "Generic DPI Panel"
+        help
+	  Generic DPI panel driver.
+	  Supports DVI output for Beagle and OMAP3 SDP.
+	  Supports LCD Panel used in TI SDP3430 and EVM boards,
+	  OMAP3517 EVM boards and CM-T35.
+
 config PANEL_GENERIC
         tristate "Generic Panel"
         help
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index aa38609..1265772 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_PANEL_DPI) += panel-dpi.o
 obj-$(CONFIG_PANEL_GENERIC) += panel-generic.o
 obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
 obj-$(CONFIG_PANEL_SHARP_LQ043T1DG01) += panel-sharp-lq043t1dg01.o
diff --git a/drivers/video/omap2/displays/panel-dpi.c b/drivers/video/omap2/displays/panel-dpi.c
new file mode 100644
index 0000000..1007ecb
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-dpi.c
@@ -0,0 +1,306 @@
+/*
+ * Generic DPI Panels support
+ *
+ * Copyright (C) 2010 Canonical Ltd.
+ * Author: Bryan Wu <bryan.wu@canonical.com>
+ *
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
+#include <plat/panel.h>
+
+struct panel_config {
+	struct omap_video_timings timings;
+
+	int acbi;	/* ac-bias pin transitions per interrupt */
+	/* Unit: line clocks */
+	int acb;	/* ac-bias pin frequency */
+
+	enum omap_panel_config config;
+
+	/*
+	 * Used to match device to panel configuration
+	 * when use generic panel driver
+	 */
+	const char *name;
+
+	int data_lines;
+};
+
+/* Panel configurations */
+static struct panel_config dpi_panels[] = {
+	/* Generic Panel */
+	{
+		{
+			.x_res		= 640,
+			.y_res		= 480,
+
+			.pixel_clock	= 23500,
+
+			.hfp		= 48,
+			.hsw		= 32,
+			.hbp		= 80,
+
+			.vfp		= 3,
+			.vsw		= 4,
+			.vbp		= 7,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT,
+		.name			= "generic",
+		.data_lines		= 24,
+	},
+
+	/* Sharp LQ043T1DG01 */
+	{
+		{
+			.x_res		= 480,
+			.y_res		= 272,
+
+			.pixel_clock	= 9000,
+
+			.hsw		= 42,
+			.hfp		= 3,
+			.hbp		= 2,
+
+			.vsw		= 11,
+			.vfp		= 3,
+			.vbp		= 2,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO,
+		.name			= "sharp_lq",
+		.data_lines		= 16,
+	},
+
+	/* Sharp LS037V7DW01 */
+	{
+		{
+			.x_res		= 480,
+			.y_res		= 640,
+
+			.pixel_clock	= 19200,
+
+			.hsw		= 2,
+			.hfp		= 1,
+			.hbp		= 28,
+
+			.vsw		= 1,
+			.vfp		= 1,
+			.vbp		= 1,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x28,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+						OMAP_DSS_LCD_IHS,
+		.name			= "sharp_ls",
+		.data_lines		= 16,
+	},
+
+	/* Toppoly TDO35S */
+	{
+		{
+			.x_res		= 480,
+			.y_res		= 640,
+
+			.pixel_clock	= 26000,
+
+			.hfp		= 104,
+			.hsw		= 8,
+			.hbp		= 8,
+
+			.vfp		= 4,
+			.vsw		= 2,
+			.vbp		= 2,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC |
+					OMAP_DSS_LCD_ONOFF,
+		.name			= "toppoly_tdo35s",
+		.data_lines		= 18,
+	},
+};
+
+static int dpi_panel_power_on(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+		return 0;
+
+	r = omapdss_dpi_display_enable(dssdev);
+	if (r)
+		goto err0;
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
+static void dpi_panel_power_off(struct omap_dss_device *dssdev)
+{
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
+		return;
+
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+
+	omapdss_dpi_display_disable(dssdev);
+}
+
+static int dpi_panel_probe(struct omap_dss_device *dssdev)
+{
+	struct panel_data *panel_data = get_panel_data(dssdev);
+	struct panel_config *panel_config = NULL;
+	int i;
+
+	dev_dbg(&dssdev->dev, "probe\n");
+
+	if (!panel_data || !panel_data->name)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(dpi_panels); i++) {
+		if (strcmp(panel_data->name, dpi_panels[i].name) == 0) {
+			panel_config = &dpi_panels[i];
+			break;
+		}
+	}
+
+	if (!panel_config)
+		return -EINVAL;
+
+	dssdev->type = OMAP_DISPLAY_TYPE_DPI;
+	dssdev->panel.config = panel_config->config;
+	dssdev->panel.timings = panel_config->timings;
+	dssdev->panel.acb = panel_config->acb;
+	dssdev->panel.acbi = panel_config->acbi;
+	dssdev->phy.dpi.data_lines = panel_config->data_lines;
+
+	return 0;
+}
+
+static void dpi_panel_remove(struct omap_dss_device *dssdev)
+{
+}
+
+static int dpi_panel_enable(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	r = dpi_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static void dpi_panel_disable(struct omap_dss_device *dssdev)
+{
+	dpi_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+}
+
+static int dpi_panel_suspend(struct omap_dss_device *dssdev)
+{
+	dpi_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+
+	return 0;
+}
+
+static int dpi_panel_resume(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	r = dpi_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static void dpi_panel_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	dpi_set_timings(dssdev, timings);
+}
+
+static void dpi_panel_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	*timings = dssdev->panel.timings;
+}
+
+static int dpi_panel_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	return dpi_check_timings(dssdev, timings);
+}
+
+static struct omap_dss_driver dpi_driver = {
+	.probe		= dpi_panel_probe,
+	.remove		= dpi_panel_remove,
+
+	.enable		= dpi_panel_enable,
+	.disable	= dpi_panel_disable,
+	.suspend	= dpi_panel_suspend,
+	.resume		= dpi_panel_resume,
+
+	.set_timings	= dpi_panel_set_timings,
+	.get_timings	= dpi_panel_get_timings,
+	.check_timings	= dpi_panel_check_timings,
+
+	.driver         = {
+		.name   = "dpi_panel",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init dpi_panel_drv_init(void)
+{
+	return omap_dss_register_driver(&dpi_driver);
+}
+
+static void __exit dpi_panel_drv_exit(void)
+{
+	omap_dss_unregister_driver(&dpi_driver);
+}
+
+module_init(dpi_panel_drv_init);
+module_exit(dpi_panel_drv_exit);
+MODULE_LICENSE("GPL");
-- 
1.7.1


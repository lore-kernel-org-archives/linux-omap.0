From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
Date: Mon,  8 Nov 2010 16:44:58 -0500
Message-ID: <1289252700-3482-2-git-send-email-bryan.wu@canonical.com>
References: <1289252700-3482-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52267 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796Ab0KHVpN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 16:45:13 -0500
Received: by mail-gw0-f46.google.com with SMTP id 21so3764502gwj.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Nov 2010 13:45:13 -0800 (PST)
In-Reply-To: <1289252700-3482-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, notasas@gmail.com

Generic DPI panel driver includes the driver and 4 similar panel configurations. It
will match the panel name which is passed from platform data and setup the
right configurations.

With generic DPI panel driver, we can remove those 4 duplicated panel display
drivers. In the future, it is simple for us just add new panel configuration
date in panel-generic-dpi.c to support new display panel.

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 .../arm/plat-omap/include/plat/panel-generic-dpi.h |   31 ++
 drivers/video/omap2/displays/Kconfig               |    8 +
 drivers/video/omap2/displays/Makefile              |    1 +
 drivers/video/omap2/displays/panel-generic-dpi.c   |  314 ++++++++++++++++++++
 4 files changed, 354 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/panel-generic-dpi.h
 create mode 100644 drivers/video/omap2/displays/panel-generic-dpi.c

diff --git a/arch/arm/plat-omap/include/plat/panel-generic-dpi.h b/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
new file mode 100644
index 0000000..da50756
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
@@ -0,0 +1,31 @@
+/*
+ * Header for generic DPI panel driver
+ *
+ * Copyright (C) 2010 Canonical Ltd.
+ * Author: Bryan Wu <bryan.wu@canonical.com>
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
+#ifndef __ARCH_ARM_PLAT_OMAP_GENERIC_DPI_PANEL_H
+#define __ARCH_ARM_PLAT_OMAP_GENERIC_DPI_PANEL_H
+
+/**
+ * struct panel_data - panel driver configuration
+ * @name: panel name
+ */
+struct generic_dpi_panel_data {
+	const char *name;
+};
+
+#endif /* __ARCH_ARM_PLAT_OMAP_GENERIC_DPI_PANEL_H */
diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 12327bb..cb3e339 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -1,6 +1,14 @@
 menu "OMAP2/3 Display Device Drivers"
         depends on OMAP2_DSS
 
+config PANEL_GENERIC_DPI
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
index aa38609..022058c 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_PANEL_GENERIC_DPI) += panel-generic-dpi.o
 obj-$(CONFIG_PANEL_GENERIC) += panel-generic.o
 obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
 obj-$(CONFIG_PANEL_SHARP_LQ043T1DG01) += panel-sharp-lq043t1dg01.o
diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
new file mode 100644
index 0000000..b252e0f
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -0,0 +1,314 @@
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
+#include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
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
+static struct panel_config generic_dpi_panels[] = {
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
+static inline struct generic_dpi_panel_data
+*get_panel_data(const struct omap_dss_device *dssdev)
+{
+	return (struct generic_dpi_panel_data *) dssdev->data;
+}
+
+
+static int generic_dpi_panel_power_on(struct omap_dss_device *dssdev)
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
+static void generic_dpi_panel_power_off(struct omap_dss_device *dssdev)
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
+static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
+{
+	struct generic_dpi_panel_data *panel_data = get_panel_data(dssdev);
+	struct panel_config *panel_config = NULL;
+	int i;
+
+	dev_dbg(&dssdev->dev, "probe\n");
+
+	if (!panel_data || !panel_data->name)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(generic_dpi_panels); i++) {
+		if (strcmp(panel_data->name, generic_dpi_panels[i].name) == 0) {
+			panel_config = &generic_dpi_panels[i];
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
+static void generic_dpi_panel_remove(struct omap_dss_device *dssdev)
+{
+}
+
+static int generic_dpi_panel_enable(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	r = generic_dpi_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static void generic_dpi_panel_disable(struct omap_dss_device *dssdev)
+{
+	generic_dpi_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+}
+
+static int generic_dpi_panel_suspend(struct omap_dss_device *dssdev)
+{
+	generic_dpi_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+
+	return 0;
+}
+
+static int generic_dpi_panel_resume(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	r = generic_dpi_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static void generic_dpi_panel_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	dpi_set_timings(dssdev, timings);
+}
+
+static void generic_dpi_panel_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	*timings = dssdev->panel.timings;
+}
+
+static int generic_dpi_panel_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	return dpi_check_timings(dssdev, timings);
+}
+
+static struct omap_dss_driver dpi_driver = {
+	.probe		= generic_dpi_panel_probe,
+	.remove		= generic_dpi_panel_remove,
+
+	.enable		= generic_dpi_panel_enable,
+	.disable	= generic_dpi_panel_disable,
+	.suspend	= generic_dpi_panel_suspend,
+	.resume		= generic_dpi_panel_resume,
+
+	.set_timings	= generic_dpi_panel_set_timings,
+	.get_timings	= generic_dpi_panel_get_timings,
+	.check_timings	= generic_dpi_panel_check_timings,
+
+	.driver         = {
+		.name   = "generic_dpi_panel",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init generic_dpi_panel_drv_init(void)
+{
+	return omap_dss_register_driver(&dpi_driver);
+}
+
+static void __exit generic_dpi_panel_drv_exit(void)
+{
+	omap_dss_unregister_driver(&dpi_driver);
+}
+
+module_init(generic_dpi_panel_drv_init);
+module_exit(generic_dpi_panel_drv_exit);
+MODULE_LICENSE("GPL");
-- 
1.7.1


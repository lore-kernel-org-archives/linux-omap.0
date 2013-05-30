From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 21/27] OMAPDSS: Add new simple DPI panel driver
Date: Thu, 30 May 2013 12:36:14 +0300
Message-ID: <1369906580-27585-22-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42847 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030449Ab3E3JhR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 05:37:17 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add simple DPI Panel driver which uses the new DSS device model and DSS
ops. A "simple" panel means one that does not require any special setup.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays-new/Kconfig     |   5 +
 drivers/video/omap2/displays-new/Makefile    |   1 +
 drivers/video/omap2/displays-new/panel-dpi.c | 270 +++++++++++++++++++++++++++
 3 files changed, 276 insertions(+)
 create mode 100644 drivers/video/omap2/displays-new/panel-dpi.c

diff --git a/drivers/video/omap2/displays-new/Kconfig b/drivers/video/omap2/displays-new/Kconfig
index 5326638..1435f2f 100644
--- a/drivers/video/omap2/displays-new/Kconfig
+++ b/drivers/video/omap2/displays-new/Kconfig
@@ -28,4 +28,9 @@ config DISPLAY_CONNECTOR_ANALOG_TV
 	help
 	  Driver for a generic analog TV connector.
 
+config PANEL_DPI
+	tristate "Generic DPI panel"
+	help
+	  Driver for generic DPI panels.
+
 endmenu
diff --git a/drivers/video/omap2/displays-new/Makefile b/drivers/video/omap2/displays-new/Makefile
index 083bf08..54002d3 100644
--- a/drivers/video/omap2/displays-new/Makefile
+++ b/drivers/video/omap2/displays-new/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_DISPLAY_ENCODER_TPD12S015) += encoder-tpd12s015.o
 obj-$(CONFIG_DISPLAY_CONNECTOR_DVI) += connector-dvi.o
 obj-$(CONFIG_DISPLAY_CONNECTOR_HDMI) += connector-hdmi.o
 obj-$(CONFIG_DISPLAY_CONNECTOR_ANALOG_TV) += connector-analog-tv.o
+obj-$(CONFIG_PANEL_DPI) += panel-dpi.o
diff --git a/drivers/video/omap2/displays-new/panel-dpi.c b/drivers/video/omap2/displays-new/panel-dpi.c
new file mode 100644
index 0000000..5f8f7e7
--- /dev/null
+++ b/drivers/video/omap2/displays-new/panel-dpi.c
@@ -0,0 +1,270 @@
+/*
+ * Generic MIPI DPI Panel Driver
+ *
+ * Copyright (C) 2013 Texas Instruments
+ * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <video/omapdss.h>
+#include <video/omap-panel-data.h>
+
+struct panel_drv_data {
+	struct omap_dss_device dssdev;
+	struct omap_dss_device *in;
+
+	int data_lines;
+
+	struct omap_video_timings videomode;
+
+	int backlight_gpio;
+	int enable_gpio;
+};
+
+#define to_panel_data(p) container_of(p, struct panel_drv_data, dssdev)
+
+static int panel_dpi_connect(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+	int r;
+
+	if (omapdss_device_is_connected(dssdev))
+		return 0;
+
+	r = in->ops.dpi->connect(in, dssdev);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static void panel_dpi_disconnect(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	if (!omapdss_device_is_connected(dssdev))
+		return;
+
+	in->ops.dpi->disconnect(in, dssdev);
+}
+
+static int panel_dpi_enable(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+	int r;
+
+	if (!omapdss_device_is_connected(dssdev))
+		return -ENODEV;
+
+	if (omapdss_device_is_enabled(dssdev))
+		return 0;
+
+	in->ops.dpi->set_data_lines(in, ddata->data_lines);
+	in->ops.dpi->set_timings(in, &ddata->videomode);
+
+	r = in->ops.dpi->enable(in);
+	if (r)
+		return r;
+
+	if (gpio_is_valid(ddata->enable_gpio))
+		gpio_set_value_cansleep(ddata->enable_gpio, 1);
+
+	if (gpio_is_valid(ddata->backlight_gpio))
+		gpio_set_value_cansleep(ddata->backlight_gpio, 1);
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static void panel_dpi_disable(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	if (!omapdss_device_is_enabled(dssdev))
+		return;
+
+	if (gpio_is_valid(ddata->enable_gpio))
+		gpio_set_value_cansleep(ddata->enable_gpio, 0);
+
+	if (gpio_is_valid(ddata->backlight_gpio))
+		gpio_set_value_cansleep(ddata->backlight_gpio, 0);
+
+	in->ops.dpi->disable(in);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+}
+
+static void panel_dpi_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	ddata->videomode = *timings;
+	dssdev->panel.timings = *timings;
+
+	in->ops.dpi->set_timings(in, timings);
+}
+
+static void panel_dpi_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+
+	*timings = ddata->videomode;
+}
+
+static int panel_dpi_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	return in->ops.dpi->check_timings(in, timings);
+}
+
+static struct omap_dss_driver panel_dpi_ops = {
+	.connect	= panel_dpi_connect,
+	.disconnect	= panel_dpi_disconnect,
+
+	.enable		= panel_dpi_enable,
+	.disable	= panel_dpi_disable,
+
+	.set_timings	= panel_dpi_set_timings,
+	.get_timings	= panel_dpi_get_timings,
+	.check_timings	= panel_dpi_check_timings,
+
+	.get_resolution	= omapdss_default_get_resolution,
+};
+
+static int panel_dpi_probe_pdata(struct platform_device *pdev)
+{
+	const struct panel_dpi_platform_data *pdata;
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct omap_dss_device *dssdev, *in;
+	struct videomode vm;
+
+	pdata = dev_get_platdata(&pdev->dev);
+
+	in = omap_dss_find_output(pdata->source);
+	if (in == NULL) {
+		dev_err(&pdev->dev, "failed to find video source '%s'\n",
+				pdata->source);
+		return -EPROBE_DEFER;
+	}
+
+	ddata->in = in;
+
+	ddata->data_lines = pdata->data_lines;
+
+	videomode_from_timing(pdata->display_timing, &vm);
+	videomode_to_omap_video_timings(&vm, &ddata->videomode);
+
+	dssdev = &ddata->dssdev;
+	dssdev->name = pdata->name;
+
+	ddata->enable_gpio = pdata->enable_gpio;
+	ddata->backlight_gpio = pdata->backlight_gpio;
+
+	return 0;
+}
+
+static int panel_dpi_probe(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata;
+	struct omap_dss_device *dssdev;
+	int r;
+
+	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
+	if (ddata == NULL)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ddata);
+
+	if (dev_get_platdata(&pdev->dev)) {
+		r = panel_dpi_probe_pdata(pdev);
+		if (r)
+			return r;
+	} else {
+		return -ENODEV;
+	}
+
+	if (gpio_is_valid(ddata->enable_gpio)) {
+		r = devm_gpio_request_one(&pdev->dev, ddata->enable_gpio,
+				GPIOF_OUT_INIT_LOW, "panel enable");
+		if (r)
+			goto err_gpio;
+	}
+
+	if (gpio_is_valid(ddata->backlight_gpio)) {
+		r = devm_gpio_request_one(&pdev->dev, ddata->backlight_gpio,
+				GPIOF_OUT_INIT_LOW, "panel backlight");
+		if (r)
+			goto err_gpio;
+	}
+
+	dssdev = &ddata->dssdev;
+	dssdev->dev = &pdev->dev;
+	dssdev->driver = &panel_dpi_ops;
+	dssdev->type = OMAP_DISPLAY_TYPE_DPI;
+	dssdev->owner = THIS_MODULE;
+	dssdev->panel.timings = ddata->videomode;
+	dssdev->phy.dpi.data_lines = ddata->data_lines;
+
+	r = omapdss_register_display(dssdev);
+	if (r) {
+		dev_err(&pdev->dev, "Failed to register panel\n");
+		goto err_reg;
+	}
+
+	return 0;
+
+err_reg:
+err_gpio:
+	omap_dss_put_device(ddata->in);
+	return r;
+}
+
+static int __exit panel_dpi_remove(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct omap_dss_device *dssdev = &ddata->dssdev;
+	struct omap_dss_device *in = ddata->in;
+
+	omapdss_unregister_display(dssdev);
+
+	panel_dpi_disable(dssdev);
+	panel_dpi_disconnect(dssdev);
+
+	omap_dss_put_device(in);
+
+	return 0;
+}
+
+static struct platform_driver panel_dpi_driver = {
+	.probe = panel_dpi_probe,
+	.remove = __exit_p(panel_dpi_remove),
+	.driver = {
+		.name = "panel-dpi",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(panel_dpi_driver);
+
+MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@ti.com>");
+MODULE_DESCRIPTION("Generic MIPI DPI Panel Driver");
+MODULE_LICENSE("GPL");
-- 
1.8.1.2


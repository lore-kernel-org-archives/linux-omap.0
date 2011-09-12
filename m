From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 10/15] OMAP: DSS2: add panel-dvi driver
Date: Mon, 12 Sep 2011 12:13:33 +0300
Message-ID: <1315818818-18733-11-git-send-email-tomi.valkeinen@ti.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:40212 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754425Ab1ILJOS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:14:18 -0400
In-Reply-To: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

We have currently panel-generic-dpi driver, which is a combined driver
for dummy panels and also for DVI output.

The aim is to split the panel-generic-dpi into two, one for fixed size
dummy panels connected via DPI, and the other (this) for variable
resolution output which supports DDC channel (in practice a DVI framer
chip connected to DPI output).

Original i2c code by: Ricardo Salveti de Araujo
<ricardo.salveti@canonical.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/Kconfig     |    7 +
 drivers/video/omap2/displays/Makefile    |    1 +
 drivers/video/omap2/displays/panel-dvi.c |  363 ++++++++++++++++++++++++++++++
 include/video/omap-panel-dvi.h           |   37 +++
 4 files changed, 408 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-dvi.c
 create mode 100644 include/video/omap-panel-dvi.h

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 6ddb401..16e3eab 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -10,6 +10,13 @@ config PANEL_GENERIC_DPI
 	  Supports LCD Panel used in TI SDP3430 and EVM boards,
 	  OMAP3517 EVM boards and CM-T35.
 
+config PANEL_DVI
+	tristate "DVI output"
+	depends on OMAP2_DSS_DPI
+	help
+	  Driver for external monitors, connected via DVI. The driver uses i2c
+	  to read EDID information from the monitor.
+
 config PANEL_LGPHILIPS_LB035Q02
 	tristate "LG.Philips LB035Q02 LCD Panel"
 	depends on OMAP2_DSS_DPI && SPI
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index d90f73c..abfda35 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_PANEL_GENERIC_DPI) += panel-generic-dpi.o
+obj-$(CONFIG_PANEL_DVI) += panel-dvi.o
 obj-$(CONFIG_PANEL_LGPHILIPS_LB035Q02) += panel-lgphilips-lb035q02.o
 obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
 obj-$(CONFIG_PANEL_NEC_NL8048HL11_01B) += panel-nec-nl8048hl11-01b.o
diff --git a/drivers/video/omap2/displays/panel-dvi.c b/drivers/video/omap2/displays/panel-dvi.c
new file mode 100644
index 0000000..03eb14a
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-dvi.c
@@ -0,0 +1,363 @@
+/*
+ * DVI output support
+ *
+ * Copyright (C) 2011 Texas Instruments Inc
+ * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
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
+#include <linux/slab.h>
+#include <video/omapdss.h>
+#include <linux/i2c.h>
+#include <drm/drm_edid.h>
+
+#include <video/omap-panel-dvi.h>
+
+static const struct omap_video_timings panel_dvi_default_timings = {
+	.x_res		= 640,
+	.y_res		= 480,
+
+	.pixel_clock	= 23500,
+
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+
+	.vfp		= 3,
+	.vsw		= 4,
+	.vbp		= 7,
+};
+
+struct panel_drv_data {
+	struct omap_dss_device *dssdev;
+
+	struct mutex lock;
+};
+
+static inline struct panel_dvi_platform_data
+*get_pdata(const struct omap_dss_device *dssdev)
+{
+	return dssdev->data;
+}
+
+static int panel_dvi_power_on(struct omap_dss_device *dssdev)
+{
+	struct panel_dvi_platform_data *pdata = get_pdata(dssdev);
+	int r;
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+		return 0;
+
+	r = omapdss_dpi_display_enable(dssdev);
+	if (r)
+		goto err0;
+
+	if (pdata->platform_enable) {
+		r = pdata->platform_enable(dssdev);
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
+static void panel_dvi_power_off(struct omap_dss_device *dssdev)
+{
+	struct panel_dvi_platform_data *pdata = get_pdata(dssdev);
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
+		return;
+
+	if (pdata->platform_disable)
+		pdata->platform_disable(dssdev);
+
+	omapdss_dpi_display_disable(dssdev);
+}
+
+static int panel_dvi_probe(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata;
+
+	ddata = kzalloc(sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	dssdev->panel.timings = panel_dvi_default_timings;
+	dssdev->panel.config = OMAP_DSS_LCD_TFT;
+
+	ddata->dssdev = dssdev;
+	mutex_init(&ddata->lock);
+
+	dev_set_drvdata(&dssdev->dev, ddata);
+
+	return 0;
+}
+
+static void __exit panel_dvi_remove(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&ddata->lock);
+
+	dev_set_drvdata(&dssdev->dev, NULL);
+
+	mutex_unlock(&ddata->lock);
+
+	kfree(ddata);
+}
+
+static int panel_dvi_enable(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	mutex_lock(&ddata->lock);
+
+	r = panel_dvi_power_on(dssdev);
+	if (r == 0)
+		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	mutex_unlock(&ddata->lock);
+
+	return r;
+}
+
+static void panel_dvi_disable(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&ddata->lock);
+
+	panel_dvi_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+
+	mutex_unlock(&ddata->lock);
+}
+
+static int panel_dvi_suspend(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&ddata->lock);
+
+	panel_dvi_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+
+	mutex_unlock(&ddata->lock);
+
+	return 0;
+}
+
+static int panel_dvi_resume(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	mutex_lock(&ddata->lock);
+
+	r = panel_dvi_power_on(dssdev);
+	if (r == 0)
+		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	mutex_unlock(&ddata->lock);
+
+	return r;
+}
+
+static void panel_dvi_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&ddata->lock);
+	dpi_set_timings(dssdev, timings);
+	mutex_unlock(&ddata->lock);
+}
+
+static void panel_dvi_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&ddata->lock);
+	*timings = dssdev->panel.timings;
+	mutex_unlock(&ddata->lock);
+}
+
+static int panel_dvi_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	mutex_lock(&ddata->lock);
+	r = dpi_check_timings(dssdev, timings);
+	mutex_unlock(&ddata->lock);
+
+	return r;
+}
+
+
+static int panel_dvi_ddc_read(struct i2c_adapter *adapter,
+		unsigned char *buf, u16 count, u8 offset)
+{
+	int r, retries;
+
+	for (retries = 3; retries > 0; retries--) {
+		struct i2c_msg msgs[] = {
+			{
+				.addr   = DDC_ADDR,
+				.flags  = 0,
+				.len    = 1,
+				.buf    = &offset,
+			}, {
+				.addr   = DDC_ADDR,
+				.flags  = I2C_M_RD,
+				.len    = count,
+				.buf    = buf,
+			}
+		};
+
+		r = i2c_transfer(adapter, msgs, 2);
+		if (r == 2)
+			return 0;
+
+		if (r != -EAGAIN)
+			break;
+	}
+
+	return r < 0 ? r : -EIO;
+}
+
+static int panel_dvi_read_edid(struct omap_dss_device *dssdev,
+		u8 *edid, int len)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+	struct panel_dvi_platform_data *pdata = get_pdata(dssdev);
+	struct i2c_adapter *adapter;
+	int r, l, bytes_read;
+
+	mutex_lock(&ddata->lock);
+
+	if (pdata->i2c_bus_num == 0) {
+		r = -ENODEV;
+		goto err;
+	}
+
+	adapter = i2c_get_adapter(pdata->i2c_bus_num);
+	if (!adapter) {
+		dev_err(&dssdev->dev, "Failed to get I2C adapter, bus %d\n",
+				pdata->i2c_bus_num);
+		r = -EINVAL;
+		goto err;
+	}
+
+	l = min(EDID_LENGTH, len);
+	r = panel_dvi_ddc_read(adapter, edid, l, 0);
+	if (r)
+		goto err;
+
+	bytes_read = l;
+
+	/* if there are extensions, read second block */
+	if (len > EDID_LENGTH && edid[0x7e] > 0) {
+		l = min(EDID_LENGTH, len - EDID_LENGTH);
+
+		r = panel_dvi_ddc_read(adapter, edid + EDID_LENGTH,
+				l, EDID_LENGTH);
+		if (r)
+			goto err;
+
+		bytes_read += l;
+	}
+
+	mutex_unlock(&ddata->lock);
+
+	return bytes_read;
+
+err:
+	mutex_unlock(&ddata->lock);
+	return r;
+}
+
+static bool panel_dvi_detect(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+	struct panel_dvi_platform_data *pdata = get_pdata(dssdev);
+	struct i2c_adapter *adapter;
+	unsigned char out;
+	int r;
+
+	mutex_lock(&ddata->lock);
+
+	if (pdata->i2c_bus_num == 0)
+		goto out;
+
+	adapter = i2c_get_adapter(pdata->i2c_bus_num);
+	if (!adapter)
+		goto out;
+
+	r = panel_dvi_ddc_read(adapter, &out, 1, 0);
+
+	mutex_unlock(&ddata->lock);
+
+	return r == 0;
+
+out:
+	mutex_unlock(&ddata->lock);
+	return true;
+}
+
+static struct omap_dss_driver panel_dvi_driver = {
+	.probe		= panel_dvi_probe,
+	.remove		= __exit_p(panel_dvi_remove),
+
+	.enable		= panel_dvi_enable,
+	.disable	= panel_dvi_disable,
+	.suspend	= panel_dvi_suspend,
+	.resume		= panel_dvi_resume,
+
+	.set_timings	= panel_dvi_set_timings,
+	.get_timings	= panel_dvi_get_timings,
+	.check_timings	= panel_dvi_check_timings,
+
+	.read_edid	= panel_dvi_read_edid,
+	.detect		= panel_dvi_detect,
+
+	.driver         = {
+		.name   = "dvi",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init panel_dvi_init(void)
+{
+	return omap_dss_register_driver(&panel_dvi_driver);
+}
+
+static void __exit panel_dvi_exit(void)
+{
+	omap_dss_unregister_driver(&panel_dvi_driver);
+}
+
+module_init(panel_dvi_init);
+module_exit(panel_dvi_exit);
+MODULE_LICENSE("GPL");
diff --git a/include/video/omap-panel-dvi.h b/include/video/omap-panel-dvi.h
new file mode 100644
index 0000000..87ad567
--- /dev/null
+++ b/include/video/omap-panel-dvi.h
@@ -0,0 +1,37 @@
+/*
+ * Header for DVI output driver
+ *
+ * Copyright (C) 2011 Texas Instruments Inc
+ * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
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
+#ifndef __OMAP_PANEL_DVI_H
+#define __OMAP_PANEL_DVI_H
+
+struct omap_dss_device;
+
+/**
+ * struct panel_dvi_platform_data - panel driver configuration data
+ * @platform_enable: platform specific panel enable function
+ * @platform_disable: platform specific panel disable function
+ * @i2c_bus_num: i2c bus id for the panel
+ */
+struct panel_dvi_platform_data {
+	int (*platform_enable)(struct omap_dss_device *dssdev);
+	void (*platform_disable)(struct omap_dss_device *dssdev);
+	u16 i2c_bus_num;
+};
+
+#endif /* __OMAP_PANEL_DVI_H */
-- 
1.7.4.1


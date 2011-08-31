From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/12] OMAP: DSS2: Generic-dpi: add detect & read_edid support
Date: Wed, 31 Aug 2011 16:23:21 +0300
Message-ID: <1314797003-17638-11-git-send-email-tomi.valkeinen@ti.com>
References: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:56226 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755816Ab1HaNXx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:23:53 -0400
In-Reply-To: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add i2c_bus_num field to panel_generic_dpi_data, and use it in the
panel-generic-dpi.c to detect if a panel is connected and to read EDID
from the panel.

Original by: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   92 ++++++++++++++++++++++
 include/video/omap-panel-generic-dpi.h           |    2 +
 2 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 9c90f75..6ef36ad 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -34,6 +34,8 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <video/omapdss.h>
+#include <linux/i2c.h>
+#include <drm/drm_edid.h>
 
 #include <video/omap-panel-generic-dpi.h>
 
@@ -407,6 +409,93 @@ static int generic_dpi_panel_check_timings(struct omap_dss_device *dssdev,
 	return dpi_check_timings(dssdev, timings);
 }
 
+
+static int generic_dpi_ddc_read(struct i2c_adapter *adapter,
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
+static int generic_dpi_panel_read_edid(struct omap_dss_device *dssdev,
+		u8 *edid, int len)
+{
+	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
+	struct i2c_adapter *adapter;
+	int r, l, bytes_read;
+
+	if (panel_data->i2c_bus_num == 0)
+		return -ENODEV;
+
+	adapter = i2c_get_adapter(panel_data->i2c_bus_num);
+	if (!adapter) {
+		dev_err(&dssdev->dev, "Failed to get I2C adapter, bus %d\n",
+				panel_data->i2c_bus_num);
+		return -EINVAL;
+	}
+
+	l = min(EDID_LENGTH, len);
+	r = generic_dpi_ddc_read(adapter, edid, l, 0);
+	if (r)
+		return r;
+
+	bytes_read = l;
+
+	/* if there are extensions, read second block */
+	if (len > EDID_LENGTH && edid[0x7e] > 0) {
+		l = min(EDID_LENGTH, len - EDID_LENGTH);
+
+		r = generic_dpi_ddc_read(adapter, edid + EDID_LENGTH,
+				l, EDID_LENGTH);
+		if (r)
+			return r;
+
+		bytes_read += l;
+	}
+
+	return bytes_read;
+}
+
+static bool generic_dpi_panel_detect(struct omap_dss_device *dssdev)
+{
+	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
+	struct i2c_adapter *adapter;
+	unsigned char out;
+
+	if (panel_data->i2c_bus_num == 0)
+		return true;
+
+	adapter = i2c_get_adapter(panel_data->i2c_bus_num);
+	if (!adapter)
+		return true;
+
+	return generic_dpi_ddc_read(adapter, &out, 1, 0) == 0;
+}
+
 static struct omap_dss_driver dpi_driver = {
 	.probe		= generic_dpi_panel_probe,
 	.remove		= __exit_p(generic_dpi_panel_remove),
@@ -420,6 +509,9 @@ static struct omap_dss_driver dpi_driver = {
 	.get_timings	= generic_dpi_panel_get_timings,
 	.check_timings	= generic_dpi_panel_check_timings,
 
+	.read_edid	= generic_dpi_panel_read_edid,
+	.detect		= generic_dpi_panel_detect,
+
 	.driver         = {
 		.name   = "generic_dpi_panel",
 		.owner  = THIS_MODULE,
diff --git a/include/video/omap-panel-generic-dpi.h b/include/video/omap-panel-generic-dpi.h
index 127e3f2..3ab023a 100644
--- a/include/video/omap-panel-generic-dpi.h
+++ b/include/video/omap-panel-generic-dpi.h
@@ -27,11 +27,13 @@ struct omap_dss_device;
  * @name: panel name
  * @platform_enable: platform specific panel enable function
  * @platform_disable: platform specific panel disable function
+ * @i2c_bus_num: i2c bus id for the panel
  */
 struct panel_generic_dpi_data {
 	const char *name;
 	int (*platform_enable)(struct omap_dss_device *dssdev);
 	void (*platform_disable)(struct omap_dss_device *dssdev);
+	u16 i2c_bus_num;
 };
 
 #endif /* __OMAP_PANEL_GENERIC_DPI_H */
-- 
1.7.4.1


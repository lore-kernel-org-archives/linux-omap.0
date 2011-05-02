From: Mayuresh Janorkar <mayur@ti.com>
Subject: [PATCH v2 3/7] OMAP: DSS: Adding a picodlp panel driver
Date: Mon,  2 May 2011 20:22:47 +0530
Message-ID: <1304347971-1504-4-git-send-email-mayur@ti.com>
References: <1304347971-1504-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56020 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759538Ab1EBOjO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 May 2011 10:39:14 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p42EdE99025764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 2 May 2011 09:39:14 -0500
In-Reply-To: <1304347971-1504-1-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>, Mayuresh Janorkar <mayur@ti.com>

From: Mythri P K <mythripk@ti.com>

A projector panel named picodlp is supported by OMAP.
panel driver is required to be added with the name picodlp_panel.

It is a WVGA panel with resolution 864 X 480 and panel timing data
is defined in the panel driver.

picodlp makes use of parallel (DPI) interface multiplexed with secondary lcd
in case of OMAP4.

Signed-off-by: Mythri P K <mythripk@ti.com>
Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
Changes since v1:
	1. Removed msleep
	
 drivers/video/omap2/displays/panel-picodlp.c |  226 ++++++++++++++++++++++++++
 1 files changed, 226 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-picodlp.c

diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
new file mode 100644
index 0000000..e83e399
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -0,0 +1,226 @@
+/*
+ * picodlp panel driver
+ *
+ * Copyright (C) 2009-2011 Texas Instruments
+ * Author: Mythri P K <mythripk@ti.com>
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
+#include <linux/input.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/firmware.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+
+#include <plat/display.h>
+#include <plat/panel-picodlp.h>
+
+struct picodlp_data {
+	struct mutex lock;
+};
+
+static struct omap_video_timings pico_ls_timings = {
+	.x_res		= 864,
+	.y_res		= 480,
+	.hsw		= 7,
+	.hfp		= 11,
+	.hbp		= 7,
+
+	.pixel_clock	= 19200,
+
+	.vsw		= 2,
+	.vfp		= 3,
+	.vbp		= 14,
+};
+
+static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	if (dssdev->platform_enable) {
+		r = dssdev->platform_enable(dssdev);
+		if (r)
+			return r;
+	}
+
+	r = omapdss_dpi_display_enable(dssdev);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to enable DPI\n");
+		goto err;
+	}
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+
+err:
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+
+	return r;
+}
+
+static void picodlp_panel_power_off(struct omap_dss_device *dssdev)
+{
+	omapdss_dpi_display_disable(dssdev);
+
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+}
+
+static int picodlp_panel_probe(struct omap_dss_device *dssdev)
+{
+	struct picodlp_data *picod;
+
+	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_ONOFF |
+				OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IVS;
+	dssdev->panel.acb = 0x0;
+	dssdev->panel.timings = pico_ls_timings;
+
+	picod =  kzalloc(sizeof(struct picodlp_data), GFP_KERNEL);
+	if (!picod)
+		return -ENOMEM;
+
+	mutex_init(&picod->lock);
+	dev_set_drvdata(&dssdev->dev, picod);
+	return 0;
+}
+
+static void picodlp_panel_remove(struct omap_dss_device *dssdev)
+{
+	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
+
+	dev_set_drvdata(&dssdev->dev, NULL);
+	dev_dbg(&dssdev->dev, " removing picodlp panel\n");
+	kfree(picod);
+}
+
+static int picodlp_panel_enable(struct omap_dss_device *dssdev)
+{
+	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	dev_dbg(&dssdev->dev, "enabling picodlp panel\n");
+
+	mutex_lock(&picod->lock);
+	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
+		mutex_unlock(&picod->lock);
+		return -EINVAL;
+	}
+
+	r = picodlp_panel_power_on(dssdev);
+	mutex_unlock(&picod->lock);
+
+	return r;
+}
+
+static void picodlp_panel_disable(struct omap_dss_device *dssdev)
+{
+	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&picod->lock);
+	/* Turn off DLP Power */
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+		picodlp_panel_power_off(dssdev);
+
+	dev_dbg(&dssdev->dev, " disabling picodlp panel\n");
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+
+	mutex_unlock(&picod->lock);
+}
+
+static int picodlp_panel_suspend(struct omap_dss_device *dssdev)
+{
+	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&picod->lock);
+	/* Turn off DLP Power */
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
+		dev_dbg(&dssdev->dev, " unable to suspend picodlp panel,"\
+						" panel is not ACTIVE\n");
+		mutex_unlock(&picod->lock);
+		return -EINVAL;
+	}
+
+	picodlp_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+	dev_dbg(&dssdev->dev, " suspending picodlp panel\n");
+
+	mutex_unlock(&picod->lock);
+	return 0;
+}
+
+static int picodlp_panel_resume(struct omap_dss_device *dssdev)
+{
+	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	mutex_lock(&picod->lock);
+	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED) {
+		dev_dbg(&dssdev->dev, " unable to resume picodlp panel,"
+					" panel is not ACTIVE\n");
+		mutex_unlock(&picod->lock);
+		return -EINVAL;
+	}
+
+	dev_dbg(&dssdev->dev, " resuming picodlp panel\n");
+	r = picodlp_panel_power_on(dssdev);
+	mutex_unlock(&picod->lock);
+
+	return r;
+}
+
+static void picodlp_get_resolution(struct omap_dss_device *dssdev,
+					u16 *xres, u16 *yres)
+{
+	*xres = dssdev->panel.timings.x_res;
+	*yres = dssdev->panel.timings.y_res;
+}
+
+static struct omap_dss_driver picodlp_driver = {
+	.probe		= picodlp_panel_probe,
+	.remove		= picodlp_panel_remove,
+
+	.enable		= picodlp_panel_enable,
+	.disable	= picodlp_panel_disable,
+
+	.get_resolution	= picodlp_get_resolution,
+
+	.suspend	= picodlp_panel_suspend,
+	.resume		= picodlp_panel_resume,
+
+	.driver		= {
+		.name	= "picodlp_panel",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init picodlp_init(void)
+{
+	return omap_dss_register_driver(&picodlp_driver);
+}
+
+static void __exit picodlp_exit(void)
+{
+	omap_dss_unregister_driver(&picodlp_driver);
+}
+
+module_init(picodlp_init);
+module_exit(picodlp_exit);
+
+MODULE_AUTHOR("Mythri P K <mythripk@ti.com>");
+MODULE_DESCRIPTION("picodlp driver");
+MODULE_LICENSE("GPL");
-- 
1.7.1


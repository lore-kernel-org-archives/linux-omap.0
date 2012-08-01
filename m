From: Archit Taneja <archit@ti.com>
Subject: [RFC 15/17] OMAPDSS: VENC: Split VENC into interface and panel driver
Date: Wed, 1 Aug 2012 16:01:26 +0530
Message-ID: <1343817088-29645-16-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39567 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754440Ab2HAKeD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 06:34:03 -0400
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com, Archit Taneja <archit@ti.com>

The current venc.c driver contains both the interface and panel driver code.
This makes the driver hard to read, and difficult to understand the work split
between the interface and panel driver and the how the locking works.

This also makes it easier to clearly define the VENC interface ops called by the
panel driver.

Split venc.c into venc.c and venc_panel.c representing the interface and panel
driver respectively. This split is done along the lines of the HDMI interface
and panel drivers.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/Makefile     |    2 +-
 drivers/video/omap2/dss/dss.h        |   10 ++
 drivers/video/omap2/dss/venc.c       |  208 ++++++++----------------------
 drivers/video/omap2/dss/venc_panel.c |  231 ++++++++++++++++++++++++++++++++++
 4 files changed, 295 insertions(+), 156 deletions(-)
 create mode 100644 drivers/video/omap2/dss/venc_panel.c

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 5c450b0..30a48fb 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -3,7 +3,7 @@ omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o \
 	manager.o overlay.o apply.o
 omapdss-$(CONFIG_OMAP2_DSS_DPI) += dpi.o
 omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
-omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
+omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o venc_panel.o
 omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
 omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
 omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi.o \
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index df49c5d..69b6ab9 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -470,6 +470,16 @@ static inline unsigned long venc_get_pixel_clock(void)
 	return 0;
 }
 #endif
+int omapdss_venc_display_enable(struct omap_dss_device *dssdev);
+void omapdss_venc_display_disable(struct omap_dss_device *dssdev);
+void omapdss_venc_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings);
+int omapdss_venc_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings);
+u32 omapdss_venc_get_wss(struct omap_dss_device *dssdev);
+int omapdss_venc_set_wss(struct omap_dss_device *dssdev, u32 wss);
+int venc_panel_init(void);
+void venc_panel_exit(void);
 
 /* HDMI */
 #ifdef CONFIG_OMAP4_DSS_HDMI
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 3a22087..ffca542 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -427,6 +427,10 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 	u32 l;
 	int r;
 
+	r = venc_runtime_get();
+	if (r)
+		goto err0;
+
 	venc_reset();
 	venc_write_config(venc_timings_to_config(&dssdev->panel.timings));
 
@@ -449,26 +453,22 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 
 	r = regulator_enable(venc.vdda_dac_reg);
 	if (r)
-		goto err;
-
-	if (dssdev->platform_enable)
-		dssdev->platform_enable(dssdev);
+		goto err1;
 
 	r = dss_mgr_enable(dssdev->manager);
 	if (r)
-		goto err;
+		goto err2;
 
 	return 0;
 
-err:
+err2:
+	regulator_disable(venc.vdda_dac_reg);
+err1:
 	venc_write_reg(VENC_OUTPUT_CONTROL, 0);
 	dss_set_dac_pwrdn_bgz(0);
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
-	regulator_disable(venc.vdda_dac_reg);
-
+	venc_runtime_put();
+err0:
 	return r;
 }
 
@@ -479,10 +479,9 @@ static void venc_power_off(struct omap_dss_device *dssdev)
 
 	dss_mgr_disable(dssdev->manager);
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
 	regulator_disable(venc.vdda_dac_reg);
+
+	venc_runtime_put();
 }
 
 unsigned long venc_get_pixel_clock(void)
@@ -491,171 +490,95 @@ unsigned long venc_get_pixel_clock(void)
 	return 13500000;
 }
 
-static ssize_t display_output_type_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+int omapdss_venc_display_enable(struct omap_dss_device *dssdev)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	const char *ret;
-
-	switch (dssdev->phy.venc.type) {
-	case OMAP_DSS_VENC_TYPE_COMPOSITE:
-		ret = "composite";
-		break;
-	case OMAP_DSS_VENC_TYPE_SVIDEO:
-		ret = "svideo";
-		break;
-	default:
-		return -EINVAL;
-	}
+	int r;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ret);
-}
-
-static ssize_t display_output_type_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t size)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	enum omap_dss_venc_type new_type;
-
-	if (sysfs_streq("composite", buf))
-		new_type = OMAP_DSS_VENC_TYPE_COMPOSITE;
-	else if (sysfs_streq("svideo", buf))
-		new_type = OMAP_DSS_VENC_TYPE_SVIDEO;
-	else
-		return -EINVAL;
+	DSSDBG("venc_display_enable\n");
 
 	mutex_lock(&venc.venc_lock);
 
-	if (dssdev->phy.venc.type != new_type) {
-		dssdev->phy.venc.type = new_type;
-		if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
-			venc_power_off(dssdev);
-			venc_power_on(dssdev);
-		}
+	if (dssdev->manager == NULL) {
+		DSSERR("Failed to enable display: no manager\n");
+		r = -ENODEV;
+		goto err0;
 	}
 
-	mutex_unlock(&venc.venc_lock);
-
-	return size;
-}
-
-static DEVICE_ATTR(output_type, S_IRUGO | S_IWUSR,
-		display_output_type_show, display_output_type_store);
-
-/* driver */
-static int venc_panel_probe(struct omap_dss_device *dssdev)
-{
-	dssdev->panel.timings = omap_dss_pal_timings;
-
-	return device_create_file(&dssdev->dev, &dev_attr_output_type);
-}
-
-static void venc_panel_remove(struct omap_dss_device *dssdev)
-{
-	device_remove_file(&dssdev->dev, &dev_attr_output_type);
-}
-
-static int venc_panel_enable(struct omap_dss_device *dssdev)
-{
-	int r = 0;
-
-	DSSDBG("venc_enable_display\n");
-
-	mutex_lock(&venc.venc_lock);
-
 	r = omap_dss_start_device(dssdev);
 	if (r) {
 		DSSERR("failed to start device\n");
 		goto err0;
 	}
 
-	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
-		r = -EINVAL;
-		goto err1;
-	}
+	if (dssdev->platform_enable)
+		dssdev->platform_enable(dssdev);
 
-	r = venc_runtime_get();
-	if (r)
-		goto err1;
 
 	r = venc_power_on(dssdev);
 	if (r)
-		goto err2;
+		goto err1;
 
 	venc.wss_data = 0;
 
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
 	mutex_unlock(&venc.venc_lock);
+
 	return 0;
-err2:
-	venc_runtime_put();
 err1:
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
 	omap_dss_stop_device(dssdev);
 err0:
 	mutex_unlock(&venc.venc_lock);
-
 	return r;
 }
 
-static void venc_panel_disable(struct omap_dss_device *dssdev)
+void omapdss_venc_display_disable(struct omap_dss_device *dssdev)
 {
-	DSSDBG("venc_disable_display\n");
+	DSSDBG("venc_display_disable\n");
 
 	mutex_lock(&venc.venc_lock);
 
-	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED)
-		goto end;
-
-	if (dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED) {
-		/* suspended is the same as disabled with venc */
-		dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-		goto end;
-	}
-
 	venc_power_off(dssdev);
 
-	venc_runtime_put();
-
-	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-
 	omap_dss_stop_device(dssdev);
-end:
-	mutex_unlock(&venc.venc_lock);
-}
 
-static int venc_panel_suspend(struct omap_dss_device *dssdev)
-{
-	venc_panel_disable(dssdev);
-	return 0;
-}
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
 
-static int venc_panel_resume(struct omap_dss_device *dssdev)
-{
-	return venc_panel_enable(dssdev);
+	mutex_unlock(&venc.venc_lock);
 }
 
-static void venc_set_timings(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings)
+void omapdss_venc_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
 {
 	DSSDBG("venc_set_timings\n");
 
+	mutex_lock(&venc.venc_lock);
+
 	/* Reset WSS data when the TV standard changes. */
 	if (memcmp(&dssdev->panel.timings, timings, sizeof(*timings)))
 		venc.wss_data = 0;
 
 	dssdev->panel.timings = *timings;
+
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+		int r;
+
 		/* turn the venc off and on to get new timings to use */
-		venc_panel_disable(dssdev);
-		venc_panel_enable(dssdev);
+		venc_power_off(dssdev);
+
+		r = venc_power_on(dssdev);
+		if (r)
+			DSSERR("failed to power on VENC\n");
 	} else {
 		dss_mgr_set_timings(dssdev->manager, timings);
 	}
+
+	mutex_unlock(&venc.venc_lock);
 }
 
-static int venc_check_timings(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings)
+int omapdss_venc_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
 {
 	DSSDBG("venc_check_timings\n");
 
@@ -668,13 +591,13 @@ static int venc_check_timings(struct omap_dss_device *dssdev,
 	return -EINVAL;
 }
 
-static u32 venc_get_wss(struct omap_dss_device *dssdev)
+u32 omapdss_venc_get_wss(struct omap_dss_device *dssdev)
 {
 	/* Invert due to VENC_L21_WC_CTL:INV=1 */
 	return (venc.wss_data >> 8) ^ 0xfffff;
 }
 
-static int venc_set_wss(struct omap_dss_device *dssdev,	u32 wss)
+int omapdss_venc_set_wss(struct omap_dss_device *dssdev, u32 wss)
 {
 	const struct venc_config *config;
 	int r;
@@ -703,31 +626,6 @@ err:
 	return r;
 }
 
-static struct omap_dss_driver venc_driver = {
-	.probe		= venc_panel_probe,
-	.remove		= venc_panel_remove,
-
-	.enable		= venc_panel_enable,
-	.disable	= venc_panel_disable,
-	.suspend	= venc_panel_suspend,
-	.resume		= venc_panel_resume,
-
-	.get_resolution	= omapdss_default_get_resolution,
-	.get_recommended_bpp = omapdss_default_get_recommended_bpp,
-
-	.set_timings	= venc_set_timings,
-	.check_timings	= venc_check_timings,
-
-	.get_wss	= venc_get_wss,
-	.set_wss	= venc_set_wss,
-
-	.driver         = {
-		.name   = "venc",
-		.owner  = THIS_MODULE,
-	},
-};
-/* driver end */
-
 static int __init venc_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
@@ -897,9 +795,9 @@ static int __init omap_venchw_probe(struct platform_device *pdev)
 
 	venc_runtime_put();
 
-	r = omap_dss_register_driver(&venc_driver);
+	r = venc_panel_init();
 	if (r)
-		goto err_reg_panel_driver;
+		goto err_panel_init;
 
 	dss_debugfs_create_file("venc", venc_dump_regs);
 
@@ -907,7 +805,7 @@ static int __init omap_venchw_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_reg_panel_driver:
+err_panel_init:
 err_runtime_get:
 	pm_runtime_disable(&pdev->dev);
 	venc_put_clocks();
@@ -923,7 +821,7 @@ static int __exit omap_venchw_remove(struct platform_device *pdev)
 		venc.vdda_dac_reg = NULL;
 	}
 
-	omap_dss_unregister_driver(&venc_driver);
+	venc_panel_exit();
 
 	pm_runtime_disable(&pdev->dev);
 	venc_put_clocks();
diff --git a/drivers/video/omap2/dss/venc_panel.c b/drivers/video/omap2/dss/venc_panel.c
new file mode 100644
index 0000000..6b31298
--- /dev/null
+++ b/drivers/video/omap2/dss/venc_panel.c
@@ -0,0 +1,231 @@
+/*
+ * Copyright (C) 2009 Nokia Corporation
+ * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
+ *
+ * VENC panel driver
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
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+
+#include <video/omapdss.h>
+
+#include "dss.h"
+
+static struct {
+	struct mutex lock;
+} venc_panel;
+
+static ssize_t display_output_type_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	const char *ret;
+
+	switch (dssdev->phy.venc.type) {
+	case OMAP_DSS_VENC_TYPE_COMPOSITE:
+		ret = "composite";
+		break;
+	case OMAP_DSS_VENC_TYPE_SVIDEO:
+		ret = "svideo";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", ret);
+}
+
+static ssize_t display_output_type_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	enum omap_dss_venc_type new_type;
+
+	if (sysfs_streq("composite", buf))
+		new_type = OMAP_DSS_VENC_TYPE_COMPOSITE;
+	else if (sysfs_streq("svideo", buf))
+		new_type = OMAP_DSS_VENC_TYPE_SVIDEO;
+	else
+		return -EINVAL;
+
+	mutex_lock(&venc_panel.lock);
+
+	if (dssdev->phy.venc.type != new_type) {
+		dssdev->phy.venc.type = new_type;
+		if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+			omapdss_venc_display_disable(dssdev);
+			omapdss_venc_display_enable(dssdev);
+		}
+	}
+
+	mutex_unlock(&venc_panel.lock);
+
+	return size;
+}
+
+static DEVICE_ATTR(output_type, S_IRUGO | S_IWUSR,
+		display_output_type_show, display_output_type_store);
+
+static int venc_panel_probe(struct omap_dss_device *dssdev)
+{
+	mutex_init(&venc_panel.lock);
+
+	/* set initial timings to PAL */
+	dssdev->panel.timings = (struct omap_video_timings)
+		{ 720, 574, 13500, 64, 12, 68, 5, 5, 41,
+			OMAPDSS_SIG_ACTIVE_HIGH, OMAPDSS_SIG_ACTIVE_HIGH,
+			true,
+		};
+
+	return device_create_file(&dssdev->dev, &dev_attr_output_type);
+}
+
+static void venc_panel_remove(struct omap_dss_device *dssdev)
+{
+	device_remove_file(&dssdev->dev, &dev_attr_output_type);
+}
+
+static int venc_panel_enable(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	dev_dbg(&dssdev->dev, "venc_panel_enable\n");
+
+	mutex_lock(&venc_panel.lock);
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
+		r = -EINVAL;
+		goto err;
+	}
+
+	r = omapdss_venc_display_enable(dssdev);
+	if (r)
+		goto err;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	mutex_unlock(&venc_panel.lock);
+
+	return 0;
+err:
+	mutex_unlock(&venc_panel.lock);
+
+	return r;
+}
+
+static void venc_panel_disable(struct omap_dss_device *dssdev)
+{
+	dev_dbg(&dssdev->dev, "venc_panel_disable\n");
+
+	mutex_lock(&venc_panel.lock);
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED)
+		goto end;
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED) {
+		/* suspended is the same as disabled with venc */
+		dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+		goto end;
+	}
+
+	omapdss_venc_display_disable(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+end:
+	mutex_unlock(&venc_panel.lock);
+}
+
+static int venc_panel_suspend(struct omap_dss_device *dssdev)
+{
+	venc_panel_disable(dssdev);
+	return 0;
+}
+
+static int venc_panel_resume(struct omap_dss_device *dssdev)
+{
+	return venc_panel_enable(dssdev);
+}
+
+static void venc_panel_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	dev_dbg(&dssdev->dev, "venc_panel_set_timings\n");
+
+	mutex_lock(&venc_panel.lock);
+
+	omapdss_venc_set_timings(dssdev, timings);
+
+	mutex_unlock(&venc_panel.lock);
+}
+
+static int venc_panel_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	dev_dbg(&dssdev->dev, "venc_panel_check_timings\n");
+
+	return omapdss_venc_check_timings(dssdev, timings);
+}
+
+static u32 venc_panel_get_wss(struct omap_dss_device *dssdev)
+{
+	dev_dbg(&dssdev->dev, "venc_panel_get_wss\n");
+
+	return omapdss_venc_get_wss(dssdev);
+}
+
+static int venc_panel_set_wss(struct omap_dss_device *dssdev, u32 wss)
+{
+	dev_dbg(&dssdev->dev, "venc_panel_set_wss\n");
+
+	return omapdss_venc_set_wss(dssdev, wss);
+}
+
+static struct omap_dss_driver venc_driver = {
+	.probe		= venc_panel_probe,
+	.remove		= venc_panel_remove,
+
+	.enable		= venc_panel_enable,
+	.disable	= venc_panel_disable,
+	.suspend	= venc_panel_suspend,
+	.resume		= venc_panel_resume,
+
+	.get_resolution	= omapdss_default_get_resolution,
+	.get_recommended_bpp = omapdss_default_get_recommended_bpp,
+
+	.set_timings	= venc_panel_set_timings,
+	.check_timings	= venc_panel_check_timings,
+
+	.get_wss	= venc_panel_get_wss,
+	.set_wss	= venc_panel_set_wss,
+
+	.driver         = {
+		.name   = "venc",
+		.owner  = THIS_MODULE,
+	},
+};
+
+int venc_panel_init(void)
+{
+	return omap_dss_register_driver(&venc_driver);
+}
+
+void venc_panel_exit(void)
+{
+	omap_dss_unregister_driver(&venc_driver);
+}
-- 
1.7.9.5


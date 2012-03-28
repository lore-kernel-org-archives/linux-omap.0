From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] OMAPDSS: VENC: allow switching venc type at runtime
Date: Thu, 29 Mar 2012 02:45:12 +0300
Message-ID: <1332978312-11959-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:62327 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933213Ab2C1XpT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Mar 2012 19:45:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

VENC type (composite/svideo) doesn't have to be fixed by board wiring,
it is possible to provide both connectors, which is what pandora does.
Having to recompile the kernel for users who have TV connector types
that's don't match default board setting is very inconvenient, especially
for users of a consumer device, so add support for switching VENC type
at runtime over a new sysfs file venc_type.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 Documentation/arm/OMAP/DSS     |    1 +
 drivers/video/omap2/dss/venc.c |   55 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
index 888ae7b..18e2214 100644
--- a/Documentation/arm/OMAP/DSS
+++ b/Documentation/arm/OMAP/DSS
@@ -156,6 +156,7 @@ timings		Display timings (pixclock,xres/hfp/hbp/hsw,yres/vfp/vbp/vsw)
 		"pal" and "ntsc"
 panel_name
 tear_elim	Tearing elimination 0=off, 1=on
+venc_type	Output type (video encoder only): "composite" or "svideo"
 
 There are also some debugfs files at <debugfs>/omapdss/ which show information
 about clocks and registers.
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 9c3daf7..aa2e74a 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -485,16 +485,69 @@ unsigned long venc_get_pixel_clock(void)
 	return 13500000;
 }
 
+static ssize_t display_venc_type_show(struct device *dev,
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
+		ret = "unknown";
+		break;
+	}
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", ret);
+}
+
+static ssize_t display_venc_type_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	enum omap_dss_venc_type new_type;
+
+	if (strncmp("composite", buf, 9) == 0)
+		new_type = OMAP_DSS_VENC_TYPE_COMPOSITE;
+	else if (strncmp("svideo", buf, 6) == 0)
+		new_type = OMAP_DSS_VENC_TYPE_SVIDEO;
+	else
+		return -EINVAL;
+
+	mutex_lock(&venc.venc_lock);
+
+	if (dssdev->phy.venc.type != new_type) {
+		dssdev->phy.venc.type = new_type;
+		if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+			venc_power_off(dssdev);
+			venc_power_on(dssdev);
+		}
+	}
+
+	mutex_unlock(&venc.venc_lock);
+
+	return size;
+}
+
+static DEVICE_ATTR(venc_type, S_IRUGO | S_IWUSR,
+		display_venc_type_show, display_venc_type_store);
+
 /* driver */
 static int venc_panel_probe(struct omap_dss_device *dssdev)
 {
 	dssdev->panel.timings = omap_dss_pal_timings;
 
-	return 0;
+	return device_create_file(&dssdev->dev, &dev_attr_venc_type);
 }
 
 static void venc_panel_remove(struct omap_dss_device *dssdev)
 {
+	device_remove_file(&dssdev->dev, &dev_attr_venc_type);
 }
 
 static int venc_panel_enable(struct omap_dss_device *dssdev)
-- 
1.7.0.4


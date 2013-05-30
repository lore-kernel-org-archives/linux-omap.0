From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/32] OMAPDSS: add helpers to get mgr or output from display
Date: Thu, 30 May 2013 12:34:30 +0300
Message-ID: <1369906493-27538-10-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49810 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030278Ab3E3Jfe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:35:34 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add two helper functions that can be used to find either the DSS output
or the overlay manager that is connected to the given display.

This hides how the output and the manager are actually connected, making
it easier to change the connections in the future.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c        |  5 ++++-
 drivers/video/omap2/dss/manager-sysfs.c   |  4 +++-
 drivers/video/omap2/dss/output.c          | 19 +++++++++++++++++++
 drivers/video/omap2/omapfb/omapfb-ioctl.c |  9 +++++++--
 drivers/video/omap2/omapfb/omapfb-main.c  | 16 +++++++---------
 include/video/omapdss.h                   |  3 +++
 6 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 9c53c25..691e760 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -247,6 +247,9 @@ static int omap_modeset_init(struct drm_device *dev)
 		struct drm_encoder *encoder = priv->encoders[i];
 		struct omap_dss_device *dssdev =
 					omap_encoder_get_dssdev(encoder);
+		struct omap_dss_output *output;
+
+		output = omapdss_find_output_from_display(dssdev);
 
 		/* figure out which crtc's we can connect the encoder to: */
 		encoder->possible_crtcs = 0;
@@ -259,7 +262,7 @@ static int omap_modeset_init(struct drm_device *dev)
 			supported_outputs =
 				dss_feat_get_supported_outputs(crtc_channel);
 
-			if (supported_outputs & dssdev->output->id)
+			if (supported_outputs & output->id)
 				encoder->possible_crtcs |= (1 << id);
 		}
 	}
diff --git a/drivers/video/omap2/dss/manager-sysfs.c b/drivers/video/omap2/dss/manager-sysfs.c
index 9a2fb59..5104681 100644
--- a/drivers/video/omap2/dss/manager-sysfs.c
+++ b/drivers/video/omap2/dss/manager-sysfs.c
@@ -78,7 +78,9 @@ static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
 	}
 
 	if (dssdev) {
-		struct omap_dss_output *out = dssdev->output;
+		struct omap_dss_output *out;
+
+		out = omapdss_find_output_from_display(dssdev);
 
 		/*
 		 * a registered device should have an output connected to it
diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index 4d01001..ab2c0f0 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -141,6 +141,25 @@ struct omap_dss_output *omap_dss_find_output_by_node(struct device_node *node)
 }
 EXPORT_SYMBOL(omap_dss_find_output_by_node);
 
+struct omap_dss_output *omapdss_find_output_from_display(struct omap_dss_device *dssdev)
+{
+	return dssdev->output;
+}
+EXPORT_SYMBOL(omapdss_find_output_from_display);
+
+struct omap_overlay_manager *omapdss_find_mgr_from_display(struct omap_dss_device *dssdev)
+{
+	struct omap_dss_output *out;
+
+	out = omapdss_find_output_from_display(dssdev);
+
+	if (out == NULL)
+		return NULL;
+
+	return out->manager;
+}
+EXPORT_SYMBOL(omapdss_find_mgr_from_display);
+
 static const struct dss_mgr_ops *dss_mgr_ops;
 
 int dss_install_mgr_ops(const struct dss_mgr_ops *mgr_ops)
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index d30b45d..146b6f5 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -770,12 +770,17 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 
 	case OMAPFB_WAITFORVSYNC:
 		DBG("ioctl WAITFORVSYNC\n");
-		if (!display || !display->output || !display->output->manager) {
+
+		if (!display) {
 			r = -EINVAL;
 			break;
 		}
 
-		mgr = display->output->manager;
+		mgr = omapdss_find_mgr_from_display(display);
+		if (!mgr) {
+			r = -EINVAL;
+			break;
+		}
 
 		r = mgr->wait_for_vsync(mgr);
 		break;
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index c84bb8a..dd972c5 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2363,18 +2363,16 @@ static int omapfb_init_connections(struct omapfb2_device *fbdev,
 	int i, r;
 	struct omap_overlay_manager *mgr;
 
-	if (!def_dssdev->output) {
-		dev_err(fbdev->dev, "no output for the default display\n");
-		return -EINVAL;
-	}
-
 	for (i = 0; i < fbdev->num_displays; ++i) {
 		struct omap_dss_device *dssdev = fbdev->displays[i].dssdev;
-		struct omap_dss_output *out = dssdev->output;
+		struct omap_dss_output *out;
 
-		mgr = omap_dss_get_overlay_manager(out->dispc_channel);
+		out = omapdss_find_output_from_display(dssdev);
+		if (!out)
+			continue;
 
-		if (!mgr || !out)
+		mgr = omap_dss_get_overlay_manager(out->dispc_channel);
+		if (!mgr)
 			continue;
 
 		if (mgr->output)
@@ -2383,7 +2381,7 @@ static int omapfb_init_connections(struct omapfb2_device *fbdev,
 		mgr->set_output(mgr, out);
 	}
 
-	mgr = def_dssdev->output->manager;
+	mgr = omapdss_find_mgr_from_display(def_dssdev);
 
 	if (!mgr) {
 		dev_err(fbdev->dev, "no ovl manager for the default display\n");
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 7fe6144..68b2345 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -785,6 +785,9 @@ int omapdss_output_set_device(struct omap_dss_output *out,
 		struct omap_dss_device *dssdev);
 int omapdss_output_unset_device(struct omap_dss_output *out);
 
+struct omap_dss_output *omapdss_find_output_from_display(struct omap_dss_device *dssdev);
+struct omap_overlay_manager *omapdss_find_mgr_from_display(struct omap_dss_device *dssdev);
+
 void omapdss_default_get_resolution(struct omap_dss_device *dssdev,
 		u16 *xres, u16 *yres);
 int omapdss_default_get_recommended_bpp(struct omap_dss_device *dssdev);
-- 
1.8.1.2


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 31/32] OMAPDSS: output: increase refcount in find_output funcs
Date: Thu, 30 May 2013 12:34:52 +0300
Message-ID: <1369906493-27538-32-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37464 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030378Ab3E3JgD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:36:03 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that omap_dss_output has been combined into omap_dss_device, we can
add ref counting for the relevant output functions also.

This patch adds omap_dss_get_device() calls to the various find_output()
style functions. This, of course, means that the users of those
find_output functions need to do a omap_dss_put_device() after use.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c |  2 ++
 drivers/video/omap2/dss/output.c   | 13 +++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index a72100c..4c0bc40 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -277,6 +277,8 @@ static int omap_modeset_init(struct drm_device *dev)
 			if (supported_outputs & output->id)
 				encoder->possible_crtcs |= (1 << id);
 		}
+
+		omap_dss_put_device(output);
 	}
 
 	DBG("registered %d planes, %d crtcs, %d encoders and %d connectors\n",
diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index cc81fec..9ad7d21 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -121,7 +121,7 @@ struct omap_dss_device *omap_dss_find_output(const char *name)
 
 	list_for_each_entry(out, &output_list, list) {
 		if (strcmp(out->name, name) == 0)
-			return out;
+			return omap_dss_get_device(out);
 	}
 
 	return NULL;
@@ -134,7 +134,7 @@ struct omap_dss_device *omap_dss_find_output_by_node(struct device_node *node)
 
 	list_for_each_entry(out, &output_list, list) {
 		if (out->dev->of_node == node)
-			return out;
+			return omap_dss_get_device(out);
 	}
 
 	return NULL;
@@ -143,20 +143,25 @@ EXPORT_SYMBOL(omap_dss_find_output_by_node);
 
 struct omap_dss_device *omapdss_find_output_from_display(struct omap_dss_device *dssdev)
 {
-	return dssdev->output;
+	return omap_dss_get_device(dssdev->output);
 }
 EXPORT_SYMBOL(omapdss_find_output_from_display);
 
 struct omap_overlay_manager *omapdss_find_mgr_from_display(struct omap_dss_device *dssdev)
 {
 	struct omap_dss_device *out;
+	struct omap_overlay_manager *mgr;
 
 	out = omapdss_find_output_from_display(dssdev);
 
 	if (out == NULL)
 		return NULL;
 
-	return out->manager;
+	mgr = out->manager;
+
+	omap_dss_put_device(out);
+
+	return mgr;
 }
 EXPORT_SYMBOL(omapdss_find_mgr_from_display);
 
-- 
1.8.1.2


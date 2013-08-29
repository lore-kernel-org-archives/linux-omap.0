From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/15] OMAPDSS: rename omap_dss_device's 'output' to 'src'
Date: Thu, 29 Aug 2013 16:31:59 +0300
Message-ID: <1377783120-14001-15-git-send-email-tomi.valkeinen@ti.com>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49975 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754762Ab3H2Nc2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:32:28 -0400
In-Reply-To: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

In the old panel device model we had "outputs", which were the encoders
inside OMAP DSS block, and panel devices (omap_dss_device). The panel
devices had a reference to the source of the video data, i.e. reference
to an "output", in a field named "output".

That was somewhat confusing even in the old panel device model, but even
more so with the panel device model where we can have longer chains of
display entities.

This patch renames the "output" field to "src", which much better tells
what the field points to.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_encoder.c               | 2 +-
 drivers/video/omap2/displays-new/encoder-tfp410.c    | 4 ++--
 drivers/video/omap2/displays-new/encoder-tpd12s015.c | 4 ++--
 drivers/video/omap2/dss/output.c                     | 8 ++++----
 include/video/omapdss.h                              | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index c29451b..6a12e89 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -133,7 +133,7 @@ int omap_encoder_update(struct drm_encoder *encoder,
 	struct omap_dss_driver *dssdrv = dssdev->driver;
 	int ret;
 
-	dssdev->output->manager = mgr;
+	dssdev->src->manager = mgr;
 
 	if (dssdrv->check_timings) {
 		ret = dssdrv->check_timings(dssdev, timings);
diff --git a/drivers/video/omap2/displays-new/encoder-tfp410.c b/drivers/video/omap2/displays-new/encoder-tfp410.c
index a04f658..454f771 100644
--- a/drivers/video/omap2/displays-new/encoder-tfp410.c
+++ b/drivers/video/omap2/displays-new/encoder-tfp410.c
@@ -43,7 +43,7 @@ static int tfp410_connect(struct omap_dss_device *dssdev,
 	if (r)
 		return r;
 
-	dst->output = dssdev;
+	dst->src = dssdev;
 	dssdev->device = dst;
 
 	return 0;
@@ -63,7 +63,7 @@ static void tfp410_disconnect(struct omap_dss_device *dssdev,
 	if (dst != dssdev->device)
 		return;
 
-	dst->output = NULL;
+	dst->src = NULL;
 	dssdev->device = NULL;
 
 	in->ops.dpi->disconnect(in, &ddata->dssdev);
diff --git a/drivers/video/omap2/displays-new/encoder-tpd12s015.c b/drivers/video/omap2/displays-new/encoder-tpd12s015.c
index ce0e010..a3d2991 100644
--- a/drivers/video/omap2/displays-new/encoder-tpd12s015.c
+++ b/drivers/video/omap2/displays-new/encoder-tpd12s015.c
@@ -66,7 +66,7 @@ static int tpd_connect(struct omap_dss_device *dssdev,
 	if (r)
 		return r;
 
-	dst->output = dssdev;
+	dst->src = dssdev;
 	dssdev->device = dst;
 
 	INIT_COMPLETION(ddata->hpd_completion);
@@ -102,7 +102,7 @@ static void tpd_disconnect(struct omap_dss_device *dssdev,
 
 	gpio_set_value_cansleep(ddata->ct_cp_hpd_gpio, 0);
 
-	dst->output = NULL;
+	dst->src = NULL;
 	dssdev->device = NULL;
 
 	in->ops.hdmi->disconnect(in, &ddata->dssdev);
diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index 3f5c0a7..15f47af 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -48,7 +48,7 @@ int omapdss_output_set_device(struct omap_dss_device *out,
 	}
 
 	out->device = dssdev;
-	dssdev->output = out;
+	dssdev->src = out;
 
 	mutex_unlock(&output_lock);
 
@@ -79,7 +79,7 @@ int omapdss_output_unset_device(struct omap_dss_device *out)
 		goto err;
 	}
 
-	out->device->output = NULL;
+	out->device->src = NULL;
 	out->device = NULL;
 
 	mutex_unlock(&output_lock);
@@ -146,8 +146,8 @@ EXPORT_SYMBOL(omap_dss_find_output_by_node);
 
 struct omap_dss_device *omapdss_find_output_from_display(struct omap_dss_device *dssdev)
 {
-	while (dssdev->output)
-		dssdev = dssdev->output;
+	while (dssdev->src)
+		dssdev = dssdev->src;
 
 	if (dssdev->id != 0)
 		return omap_dss_get_device(dssdev);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 763b11b..5fa81dd 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -774,7 +774,7 @@ struct omap_dss_device {
 
 	enum omap_display_caps caps;
 
-	struct omap_dss_device *output;
+	struct omap_dss_device *src;
 
 	enum omap_dss_display_state state;
 
@@ -1011,7 +1011,7 @@ void dss_mgr_unregister_framedone_handler(struct omap_overlay_manager *mgr,
 
 static inline bool omapdss_device_is_connected(struct omap_dss_device *dssdev)
 {
-	return dssdev->output;
+	return dssdev->src;
 }
 
 static inline bool omapdss_device_is_enabled(struct omap_dss_device *dssdev)
-- 
1.8.1.2


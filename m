From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/15] OMAPDSS: rename omap_dss_device's 'device' field to 'dst'
Date: Thu, 29 Aug 2013 16:32:00 +0300
Message-ID: <1377783120-14001-16-git-send-email-tomi.valkeinen@ti.com>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51693 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754762Ab3H2Nca (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:32:30 -0400
In-Reply-To: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

In the old panel device model we had omap_dss_output entities,
representing the encoders in the DSS block. This entity had "device"
field, which pointed to the panel that was using the omap_dss_output.

With the new panel device model, the omap_dss_output is integrated into
omap_dss_device, which now represents a "display entity". Thus the "device"
field, now in omap_dss_device, points to the next entity in the display
entity-chain.

This patch renames the "device" field to "dst", which much better tells
what the field points to.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays-new/encoder-tfp410.c    | 10 +++++-----
 drivers/video/omap2/displays-new/encoder-tpd12s015.c | 10 +++++-----
 drivers/video/omap2/dss/apply.c                      |  4 ++--
 drivers/video/omap2/dss/dpi.c                        |  4 ++--
 drivers/video/omap2/dss/dsi.c                        |  4 ++--
 drivers/video/omap2/dss/hdmi.c                       |  4 ++--
 drivers/video/omap2/dss/output.c                     | 16 ++++++++--------
 drivers/video/omap2/dss/sdi.c                        |  4 ++--
 drivers/video/omap2/dss/venc.c                       |  4 ++--
 include/video/omapdss.h                              |  2 +-
 10 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/video/omap2/displays-new/encoder-tfp410.c b/drivers/video/omap2/displays-new/encoder-tfp410.c
index 454f771..4a291e7 100644
--- a/drivers/video/omap2/displays-new/encoder-tfp410.c
+++ b/drivers/video/omap2/displays-new/encoder-tfp410.c
@@ -44,7 +44,7 @@ static int tfp410_connect(struct omap_dss_device *dssdev,
 		return r;
 
 	dst->src = dssdev;
-	dssdev->device = dst;
+	dssdev->dst = dst;
 
 	return 0;
 }
@@ -59,12 +59,12 @@ static void tfp410_disconnect(struct omap_dss_device *dssdev,
 	if (!omapdss_device_is_connected(dssdev))
 		return;
 
-	WARN_ON(dst != dssdev->device);
-	if (dst != dssdev->device)
+	WARN_ON(dst != dssdev->dst);
+	if (dst != dssdev->dst)
 		return;
 
 	dst->src = NULL;
-	dssdev->device = NULL;
+	dssdev->dst = NULL;
 
 	in->ops.dpi->disconnect(in, &ddata->dssdev);
 }
@@ -244,7 +244,7 @@ static int __exit tfp410_remove(struct platform_device *pdev)
 
 	WARN_ON(omapdss_device_is_connected(dssdev));
 	if (omapdss_device_is_connected(dssdev))
-		tfp410_disconnect(dssdev, dssdev->device);
+		tfp410_disconnect(dssdev, dssdev->dst);
 
 	omap_dss_put_device(in);
 
diff --git a/drivers/video/omap2/displays-new/encoder-tpd12s015.c b/drivers/video/omap2/displays-new/encoder-tpd12s015.c
index a3d2991..798ef20 100644
--- a/drivers/video/omap2/displays-new/encoder-tpd12s015.c
+++ b/drivers/video/omap2/displays-new/encoder-tpd12s015.c
@@ -67,7 +67,7 @@ static int tpd_connect(struct omap_dss_device *dssdev,
 		return r;
 
 	dst->src = dssdev;
-	dssdev->device = dst;
+	dssdev->dst = dst;
 
 	INIT_COMPLETION(ddata->hpd_completion);
 
@@ -95,15 +95,15 @@ static void tpd_disconnect(struct omap_dss_device *dssdev,
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
 	struct omap_dss_device *in = ddata->in;
 
-	WARN_ON(dst != dssdev->device);
+	WARN_ON(dst != dssdev->dst);
 
-	if (dst != dssdev->device)
+	if (dst != dssdev->dst)
 		return;
 
 	gpio_set_value_cansleep(ddata->ct_cp_hpd_gpio, 0);
 
 	dst->src = NULL;
-	dssdev->device = NULL;
+	dssdev->dst = NULL;
 
 	in->ops.hdmi->disconnect(in, &ddata->dssdev);
 }
@@ -372,7 +372,7 @@ static int __exit tpd_remove(struct platform_device *pdev)
 
 	WARN_ON(omapdss_device_is_connected(dssdev));
 	if (omapdss_device_is_connected(dssdev))
-		tpd_disconnect(dssdev, dssdev->device);
+		tpd_disconnect(dssdev, dssdev->dst);
 
 	omap_dss_put_device(in);
 
diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index d6212d63..60758db 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -428,8 +428,8 @@ static struct omap_dss_device *dss_mgr_get_device(struct omap_overlay_manager *m
 	if (dssdev == NULL)
 		return NULL;
 
-	while (dssdev->device)
-		dssdev = dssdev->device;
+	while (dssdev->dst)
+		dssdev = dssdev->dst;
 
 	if (dssdev->driver)
 		return dssdev;
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index b268d04..bd48cde 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -643,9 +643,9 @@ static int dpi_connect(struct omap_dss_device *dssdev,
 static void dpi_disconnect(struct omap_dss_device *dssdev,
 		struct omap_dss_device *dst)
 {
-	WARN_ON(dst != dssdev->device);
+	WARN_ON(dst != dssdev->dst);
 
-	if (dst != dssdev->device)
+	if (dst != dssdev->dst)
 		return;
 
 	omapdss_output_unset_device(dssdev);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 3daaf7e..a598b58 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5264,9 +5264,9 @@ static int dsi_connect(struct omap_dss_device *dssdev,
 static void dsi_disconnect(struct omap_dss_device *dssdev,
 		struct omap_dss_device *dst)
 {
-	WARN_ON(dst != dssdev->device);
+	WARN_ON(dst != dssdev->dst);
 
-	if (dst != dssdev->device)
+	if (dst != dssdev->dst)
 		return;
 
 	omapdss_output_unset_device(dssdev);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 0b8e4de..75f3c74 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -900,9 +900,9 @@ static int hdmi_connect(struct omap_dss_device *dssdev,
 static void hdmi_disconnect(struct omap_dss_device *dssdev,
 		struct omap_dss_device *dst)
 {
-	WARN_ON(dst != dssdev->device);
+	WARN_ON(dst != dssdev->dst);
 
-	if (dst != dssdev->device)
+	if (dst != dssdev->dst)
 		return;
 
 	omapdss_output_unset_device(dssdev);
diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index 15f47af..2ab3afa 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -34,9 +34,9 @@ int omapdss_output_set_device(struct omap_dss_device *out,
 
 	mutex_lock(&output_lock);
 
-	if (out->device) {
+	if (out->dst) {
 		DSSERR("output already has device %s connected to it\n",
-			out->device->name);
+			out->dst->name);
 		r = -EINVAL;
 		goto err;
 	}
@@ -47,7 +47,7 @@ int omapdss_output_set_device(struct omap_dss_device *out,
 		goto err;
 	}
 
-	out->device = dssdev;
+	out->dst = dssdev;
 	dssdev->src = out;
 
 	mutex_unlock(&output_lock);
@@ -66,21 +66,21 @@ int omapdss_output_unset_device(struct omap_dss_device *out)
 
 	mutex_lock(&output_lock);
 
-	if (!out->device) {
+	if (!out->dst) {
 		DSSERR("output doesn't have a device connected to it\n");
 		r = -EINVAL;
 		goto err;
 	}
 
-	if (out->device->state != OMAP_DSS_DISPLAY_DISABLED) {
+	if (out->dst->state != OMAP_DSS_DISPLAY_DISABLED) {
 		DSSERR("device %s is not disabled, cannot unset device\n",
-				out->device->name);
+				out->dst->name);
 		r = -EINVAL;
 		goto err;
 	}
 
-	out->device->src = NULL;
-	out->device = NULL;
+	out->dst->src = NULL;
+	out->dst = NULL;
 
 	mutex_unlock(&output_lock);
 
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index b327688..ccc569a 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -306,9 +306,9 @@ static int sdi_connect(struct omap_dss_device *dssdev,
 static void sdi_disconnect(struct omap_dss_device *dssdev,
 		struct omap_dss_device *dst)
 {
-	WARN_ON(dst != dssdev->device);
+	WARN_ON(dst != dssdev->dst);
 
-	if (dst != dssdev->device)
+	if (dst != dssdev->dst)
 		return;
 
 	omapdss_output_unset_device(dssdev);
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 0d8ccde..5f88ac4 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -753,9 +753,9 @@ static int venc_connect(struct omap_dss_device *dssdev,
 static void venc_disconnect(struct omap_dss_device *dssdev,
 		struct omap_dss_device *dst)
 {
-	WARN_ON(dst != dssdev->device);
+	WARN_ON(dst != dssdev->dst);
 
-	if (dst != dssdev->device)
+	if (dst != dssdev->dst)
 		return;
 
 	omapdss_output_unset_device(dssdev);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 5fa81dd..3d7c51a 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -793,7 +793,7 @@ struct omap_dss_device {
 	/* dynamic fields */
 	struct omap_overlay_manager *manager;
 
-	struct omap_dss_device *device;
+	struct omap_dss_device *dst;
 };
 
 struct omap_dss_hdmi_data
-- 
1.8.1.2


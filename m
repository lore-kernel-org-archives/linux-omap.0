From: Archit Taneja <archit@ti.com>
Subject: [PATCH 16/23] OMAPDSS: VENC: Pass outputs from panel driver to VENC interface driver
Date: Tue, 21 Aug 2012 11:28:23 +0530
Message-ID: <1345528711-27801-17-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34844 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab2HUGBR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Aug 2012 02:01:17 -0400
In-Reply-To: <1345528711-27801-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com, Archit Taneja <archit@ti.com>

With outputs introduces as new entities, we can now pass output pointer to
functions used to configure the connected interface. These functions currently
pass the omap_dss_device pointer, and extract output information via
omap_dss_device. This is unnecessary, and it doesn't make sense for interface
related functions to get the panel's/device's pointer, it should receive a
pointer related to the connected interface, which in our case is the output
entity.

With the addition of outputs. There is a possibility that an omap_dss_device
isn't connected to an output yet. Ensure that the venc panel driver calls the
interface functions only if output is non NULL.

Modify VENC functions to pass omap_dss_output pointer instead of omap_dss_device
pointer. Modify the venc panel driver to call the updated functions.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.h        |   16 +++++-----
 drivers/video/omap2/dss/venc.c       |   58 +++++++++++++++++-----------------
 drivers/video/omap2/dss/venc_panel.c |   53 ++++++++++++++++++++++++-------
 3 files changed, 78 insertions(+), 49 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index a119506..5fd3cc5 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -476,17 +476,17 @@ static inline unsigned long venc_get_pixel_clock(void)
 	return 0;
 }
 #endif
-int omapdss_venc_display_enable(struct omap_dss_device *dssdev);
-void omapdss_venc_display_disable(struct omap_dss_device *dssdev);
-void omapdss_venc_set_timings(struct omap_dss_device *dssdev,
+int omapdss_venc_display_enable(struct omap_dss_output *out);
+void omapdss_venc_display_disable(struct omap_dss_output *out);
+void omapdss_venc_set_timings(struct omap_dss_output *out,
 		struct omap_video_timings *timings);
-int omapdss_venc_check_timings(struct omap_dss_device *dssdev,
+int omapdss_venc_check_timings(struct omap_dss_output *out,
 		struct omap_video_timings *timings);
-u32 omapdss_venc_get_wss(struct omap_dss_device *dssdev);
-int omapdss_venc_set_wss(struct omap_dss_device *dssdev, u32 wss);
-void omapdss_venc_set_type(struct omap_dss_device *dssdev,
+u32 omapdss_venc_get_wss(struct omap_dss_output *out);
+int omapdss_venc_set_wss(struct omap_dss_output *out, u32 wss);
+void omapdss_venc_set_type(struct omap_dss_output *out,
 		enum omap_dss_venc_type type);
-void omapdss_venc_invert_vid_out_polarity(struct omap_dss_device *dssdev,
+void omapdss_venc_invert_vid_out_polarity(struct omap_dss_output *out,
 		bool invert_polarity);
 int venc_panel_init(void);
 void venc_panel_exit(void);
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 264c5ec..7b399e7 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -426,7 +426,7 @@ static const struct venc_config *venc_timings_to_config(
 	return NULL;
 }
 
-static int venc_power_on(struct omap_dss_device *dssdev)
+static int venc_power_on(struct omap_dss_output *out)
 {
 	u32 l;
 	int r;
@@ -453,13 +453,13 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 
 	venc_write_reg(VENC_OUTPUT_CONTROL, l);
 
-	dss_mgr_set_timings(dssdev->manager, &venc.timings);
+	dss_mgr_set_timings(out->manager, &venc.timings);
 
 	r = regulator_enable(venc.vdda_dac_reg);
 	if (r)
 		goto err1;
 
-	r = dss_mgr_enable(dssdev->manager);
+	r = dss_mgr_enable(out->manager);
 	if (r)
 		goto err2;
 
@@ -476,12 +476,12 @@ err0:
 	return r;
 }
 
-static void venc_power_off(struct omap_dss_device *dssdev)
+static void venc_power_off(struct omap_dss_output *out)
 {
 	venc_write_reg(VENC_OUTPUT_CONTROL, 0);
 	dss_set_dac_pwrdn_bgz(0);
 
-	dss_mgr_disable(dssdev->manager);
+	dss_mgr_disable(out->manager);
 
 	regulator_disable(venc.vdda_dac_reg);
 
@@ -494,7 +494,7 @@ unsigned long venc_get_pixel_clock(void)
 	return 13500000;
 }
 
-int omapdss_venc_display_enable(struct omap_dss_device *dssdev)
+int omapdss_venc_display_enable(struct omap_dss_output *out)
 {
 	int r;
 
@@ -502,23 +502,23 @@ int omapdss_venc_display_enable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&venc.venc_lock);
 
-	if (dssdev->manager == NULL) {
+	if (out->manager == NULL) {
 		DSSERR("Failed to enable display: no manager\n");
 		r = -ENODEV;
 		goto err0;
 	}
 
-	r = omap_dss_start_device(dssdev);
+	r = omap_dss_start_device(out->device);
 	if (r) {
 		DSSERR("failed to start device\n");
 		goto err0;
 	}
 
-	if (dssdev->platform_enable)
-		dssdev->platform_enable(dssdev);
+	if (out->device->platform_enable)
+		out->device->platform_enable(out->device);
 
 
-	r = venc_power_on(dssdev);
+	r = venc_power_on(out);
 	if (r)
 		goto err1;
 
@@ -528,31 +528,31 @@ int omapdss_venc_display_enable(struct omap_dss_device *dssdev)
 
 	return 0;
 err1:
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-	omap_dss_stop_device(dssdev);
+	if (out->device->platform_disable)
+		out->device->platform_disable(out->device);
+	omap_dss_stop_device(out->device);
 err0:
 	mutex_unlock(&venc.venc_lock);
 	return r;
 }
 
-void omapdss_venc_display_disable(struct omap_dss_device *dssdev)
+void omapdss_venc_display_disable(struct omap_dss_output *out)
 {
 	DSSDBG("venc_display_disable\n");
 
 	mutex_lock(&venc.venc_lock);
 
-	venc_power_off(dssdev);
+	venc_power_off(out);
 
-	omap_dss_stop_device(dssdev);
+	omap_dss_stop_device(out->device);
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
+	if (out->device->platform_disable)
+		out->device->platform_disable(out->device);
 
 	mutex_unlock(&venc.venc_lock);
 }
 
-void omapdss_venc_set_timings(struct omap_dss_device *dssdev,
+void omapdss_venc_set_timings(struct omap_dss_output *out,
 		struct omap_video_timings *timings)
 {
 	DSSDBG("venc_set_timings\n");
@@ -565,23 +565,23 @@ void omapdss_venc_set_timings(struct omap_dss_device *dssdev,
 
 	venc.timings = *timings;
 
-	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+	if (out->device->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		int r;
 
 		/* turn the venc off and on to get new timings to use */
-		venc_power_off(dssdev);
+		venc_power_off(out);
 
-		r = venc_power_on(dssdev);
+		r = venc_power_on(out);
 		if (r)
 			DSSERR("failed to power on VENC\n");
 	} else {
-		dss_mgr_set_timings(dssdev->manager, timings);
+		dss_mgr_set_timings(out->manager, timings);
 	}
 
 	mutex_unlock(&venc.venc_lock);
 }
 
-int omapdss_venc_check_timings(struct omap_dss_device *dssdev,
+int omapdss_venc_check_timings(struct omap_dss_output *out,
 		struct omap_video_timings *timings)
 {
 	DSSDBG("venc_check_timings\n");
@@ -595,13 +595,13 @@ int omapdss_venc_check_timings(struct omap_dss_device *dssdev,
 	return -EINVAL;
 }
 
-u32 omapdss_venc_get_wss(struct omap_dss_device *dssdev)
+u32 omapdss_venc_get_wss(struct omap_dss_output *out)
 {
 	/* Invert due to VENC_L21_WC_CTL:INV=1 */
 	return (venc.wss_data >> 8) ^ 0xfffff;
 }
 
-int omapdss_venc_set_wss(struct omap_dss_device *dssdev, u32 wss)
+int omapdss_venc_set_wss(struct omap_dss_output *out, u32 wss)
 {
 	const struct venc_config *config;
 	int r;
@@ -630,7 +630,7 @@ err:
 	return r;
 }
 
-void omapdss_venc_set_type(struct omap_dss_device *dssdev,
+void omapdss_venc_set_type(struct omap_dss_output *out,
 		enum omap_dss_venc_type type)
 {
 	mutex_lock(&venc.venc_lock);
@@ -640,7 +640,7 @@ void omapdss_venc_set_type(struct omap_dss_device *dssdev,
 	mutex_unlock(&venc.venc_lock);
 }
 
-void omapdss_venc_invert_vid_out_polarity(struct omap_dss_device *dssdev,
+void omapdss_venc_invert_vid_out_polarity(struct omap_dss_output *out,
 		bool invert_polarity)
 {
 	mutex_lock(&venc.venc_lock);
diff --git a/drivers/video/omap2/dss/venc_panel.c b/drivers/video/omap2/dss/venc_panel.c
index d55b878..0669f10 100644
--- a/drivers/video/omap2/dss/venc_panel.c
+++ b/drivers/video/omap2/dss/venc_panel.c
@@ -67,11 +67,14 @@ static ssize_t display_output_type_store(struct device *dev,
 	mutex_lock(&venc_panel.lock);
 
 	if (dssdev->phy.venc.type != new_type) {
+		struct omap_dss_output *out = dssdev->output;
+
 		dssdev->phy.venc.type = new_type;
-		omapdss_venc_set_type(dssdev, new_type);
+		omapdss_venc_set_type(out, new_type);
+
 		if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
-			omapdss_venc_display_disable(dssdev);
-			omapdss_venc_display_enable(dssdev);
+			omapdss_venc_display_disable(out);
+			omapdss_venc_display_enable(out);
 		}
 	}
 
@@ -117,10 +120,14 @@ static void venc_panel_remove(struct omap_dss_device *dssdev)
 
 static int venc_panel_enable(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	dev_dbg(&dssdev->dev, "venc_panel_enable\n");
 
+	if (out == NULL)
+		return -ENODEV;
+
 	mutex_lock(&venc_panel.lock);
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
@@ -128,12 +135,12 @@ static int venc_panel_enable(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	omapdss_venc_set_timings(dssdev, &dssdev->panel.timings);
-	omapdss_venc_set_type(dssdev, dssdev->phy.venc.type);
-	omapdss_venc_invert_vid_out_polarity(dssdev,
+	omapdss_venc_set_timings(out, &dssdev->panel.timings);
+	omapdss_venc_set_type(out, dssdev->phy.venc.type);
+	omapdss_venc_invert_vid_out_polarity(out,
 		dssdev->phy.venc.invert_polarity);
 
-	r = omapdss_venc_display_enable(dssdev);
+	r = omapdss_venc_display_enable(out);
 	if (r)
 		goto err;
 
@@ -150,6 +157,8 @@ err:
 
 static void venc_panel_disable(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
+
 	dev_dbg(&dssdev->dev, "venc_panel_disable\n");
 
 	mutex_lock(&venc_panel.lock);
@@ -163,7 +172,7 @@ static void venc_panel_disable(struct omap_dss_device *dssdev)
 		goto end;
 	}
 
-	omapdss_venc_display_disable(dssdev);
+	omapdss_venc_display_disable(out);
 
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 end:
@@ -184,11 +193,16 @@ static int venc_panel_resume(struct omap_dss_device *dssdev)
 static void venc_panel_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
+	struct omap_dss_output *out = dssdev->output;
+
 	dev_dbg(&dssdev->dev, "venc_panel_set_timings\n");
 
+	if (out == NULL)
+		return;
+
 	mutex_lock(&venc_panel.lock);
 
-	omapdss_venc_set_timings(dssdev, timings);
+	omapdss_venc_set_timings(out, timings);
 	dssdev->panel.timings = *timings;
 
 	mutex_unlock(&venc_panel.lock);
@@ -197,23 +211,38 @@ static void venc_panel_set_timings(struct omap_dss_device *dssdev,
 static int venc_panel_check_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
+	struct omap_dss_output *out = dssdev->output;
+
 	dev_dbg(&dssdev->dev, "venc_panel_check_timings\n");
 
-	return omapdss_venc_check_timings(dssdev, timings);
+	if (out == NULL)
+		return -ENODEV;
+
+	return omapdss_venc_check_timings(out, timings);
 }
 
 static u32 venc_panel_get_wss(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
+
 	dev_dbg(&dssdev->dev, "venc_panel_get_wss\n");
 
-	return omapdss_venc_get_wss(dssdev);
+	if (out == NULL)
+		return -ENODEV;
+
+	return omapdss_venc_get_wss(out);
 }
 
 static int venc_panel_set_wss(struct omap_dss_device *dssdev, u32 wss)
 {
+	struct omap_dss_output *out = dssdev->output;
+
 	dev_dbg(&dssdev->dev, "venc_panel_set_wss\n");
 
-	return omapdss_venc_set_wss(dssdev, wss);
+	if (out == NULL)
+		return -ENODEV;
+
+	return omapdss_venc_set_wss(out, wss);
 }
 
 static struct omap_dss_driver venc_driver = {
-- 
1.7.9.5


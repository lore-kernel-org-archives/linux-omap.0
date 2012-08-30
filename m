From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 16/23] OMAPDSS: VENC: Pass omap_dss_output within the driver
Date: Thu, 30 Aug 2012 17:10:38 +0530
Message-ID: <1346326845-16583-17-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57664 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab2H3LnS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 07:43:18 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

When a panel driver calls a VENC function, it passes the omap_dss_device
pointer, this pointer currently propagates within the VENC driver to configure
the interface.

Extract the omap_dss_output pointer from omap_dss_device received from the panel
driver, pass the output pointer to VENC functions local to the driver to
configure the interface, these functions no longer need omap_dss_device since
the driver now maintains a copy of output parameters.

Replace dssdev->manager references with out->manager references as only these
will be valid later.

With the addition of outputs. There is a possibility that an omap_dss_device
isn't connected to an output, or a manager isn't connected to an output yet.
Ensure that the VENC interface functions proceed only if the output is non NULL.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/venc.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 942a378..3fe974f 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -428,7 +428,7 @@ static const struct venc_config *venc_timings_to_config(
 	return NULL;
 }
 
-static int venc_power_on(struct omap_dss_device *dssdev)
+static int venc_power_on(struct omap_dss_output *out)
 {
 	u32 l;
 	int r;
@@ -455,13 +455,13 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 
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
 
@@ -478,12 +478,12 @@ err0:
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
 
@@ -498,14 +498,15 @@ unsigned long venc_get_pixel_clock(void)
 
 int omapdss_venc_display_enable(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	DSSDBG("venc_display_enable\n");
 
 	mutex_lock(&venc.venc_lock);
 
-	if (dssdev->manager == NULL) {
-		DSSERR("Failed to enable display: no manager\n");
+	if (out == NULL || out->manager == NULL) {
+		DSSERR("Failed to enable display: no output/manager\n");
 		r = -ENODEV;
 		goto err0;
 	}
@@ -520,7 +521,7 @@ int omapdss_venc_display_enable(struct omap_dss_device *dssdev)
 		dssdev->platform_enable(dssdev);
 
 
-	r = venc_power_on(dssdev);
+	r = venc_power_on(out);
 	if (r)
 		goto err1;
 
@@ -540,11 +541,13 @@ err0:
 
 void omapdss_venc_display_disable(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
+
 	DSSDBG("venc_display_disable\n");
 
 	mutex_lock(&venc.venc_lock);
 
-	venc_power_off(dssdev);
+	venc_power_off(out);
 
 	omap_dss_stop_device(dssdev);
 
@@ -557,8 +560,13 @@ void omapdss_venc_display_disable(struct omap_dss_device *dssdev)
 void omapdss_venc_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
+	struct omap_dss_output *out = dssdev->output;
+
 	DSSDBG("venc_set_timings\n");
 
+	if (out == NULL)
+		return;
+
 	mutex_lock(&venc.venc_lock);
 
 	/* Reset WSS data when the TV standard changes. */
@@ -571,13 +579,13 @@ void omapdss_venc_set_timings(struct omap_dss_device *dssdev,
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
-- 
1.7.9.5


From: Archit Taneja <archit@ti.com>
Subject: [PATCH 17/23] OMAPDSS: HDMI: Pass outputs from panel driver to HDMI interface driver
Date: Tue, 21 Aug 2012 11:28:24 +0530
Message-ID: <1345528711-27801-18-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57192 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043Ab2HUGBV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 02:01:21 -0400
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
isn't connected to an output yet. Ensure that panel drivers call the interface
functions only if outputs are non NULL.

Modify HDMI functions to pass omap_dss_output pointer instead of omap_dss_device
pointer. Modify the panel drivers to call the updated functions.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.h        |   10 +++----
 drivers/video/omap2/dss/hdmi.c       |   50 +++++++++++++++++++---------------
 drivers/video/omap2/dss/hdmi_panel.c |   47 ++++++++++++++++++++++++--------
 3 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 5fd3cc5..bfa8b4d 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -503,12 +503,12 @@ static inline unsigned long hdmi_get_pixel_clock(void)
 	return 0;
 }
 #endif
-int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev);
-void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev);
-void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev,
+int omapdss_hdmi_display_enable(struct omap_dss_output *out);
+void omapdss_hdmi_display_disable(struct omap_dss_output *out);
+void omapdss_hdmi_display_set_timing(struct omap_dss_output *out,
+		struct omap_video_timings *timings);
+int omapdss_hdmi_display_check_timing(struct omap_dss_output *out,
 		struct omap_video_timings *timings);
-int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
-					struct omap_video_timings *timings);
 int omapdss_hdmi_read_edid(u8 *buf, int len);
 bool omapdss_hdmi_detect(void);
 int hdmi_panel_init(void);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index d32dbc3..16b745c 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -405,9 +405,10 @@ unsigned long hdmi_get_pixel_clock(void)
 	return hdmi.ip_data.cfg.timings.pixel_clock * 1000;
 }
 
-static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
+static void hdmi_compute_pll(struct omap_dss_output *out, int phy,
 		struct hdmi_pll_info *pi)
 {
+	struct omap_dss_device *dssdev = out->device;
 	unsigned long clkin, refclk;
 	u32 mf;
 
@@ -456,7 +457,7 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	DSSDBG("range = %d sd = %d\n", pi->dcofreq, pi->regsd);
 }
 
-static int hdmi_power_on(struct omap_dss_device *dssdev)
+static int hdmi_power_on(struct omap_dss_output *out)
 {
 	int r;
 	struct omap_video_timings *p;
@@ -466,7 +467,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		return r;
 
-	dss_mgr_disable(dssdev->manager);
+	dss_mgr_disable(out->manager);
 
 	p = &hdmi.ip_data.cfg.timings;
 
@@ -474,7 +475,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	phy = p->pixel_clock;
 
-	hdmi_compute_pll(dssdev, phy, &hdmi.ip_data.pll_data);
+	hdmi_compute_pll(out, phy, &hdmi.ip_data.pll_data);
 
 	hdmi.ip_data.ops->video_disable(&hdmi.ip_data);
 
@@ -502,19 +503,19 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	 * dynamically by user. This can be moved to single location , say
 	 * Boardfile.
 	 */
-	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
+	dss_select_dispc_clk_source(out->device->clocks.dispc.dispc_fclk_src);
 
 	/* bypass TV gamma table */
 	dispc_enable_gamma_table(0);
 
 	/* tv size */
-	dss_mgr_set_timings(dssdev->manager, p);
+	dss_mgr_set_timings(out->manager, p);
 
 	r = hdmi.ip_data.ops->video_enable(&hdmi.ip_data);
 	if (r)
 		goto err_vid_enable;
 
-	r = dss_mgr_enable(dssdev->manager);
+	r = dss_mgr_enable(out->manager);
 	if (r)
 		goto err_mgr_enable;
 
@@ -531,9 +532,9 @@ err:
 	return -EIO;
 }
 
-static void hdmi_power_off(struct omap_dss_device *dssdev)
+static void hdmi_power_off(struct omap_dss_output *out)
 {
-	dss_mgr_disable(dssdev->manager);
+	dss_mgr_disable(out->manager);
 
 	hdmi.ip_data.ops->video_disable(&hdmi.ip_data);
 	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
@@ -541,8 +542,8 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 	hdmi_runtime_put();
 }
 
-int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
-					struct omap_video_timings *timings)
+int omapdss_hdmi_display_check_timing(struct omap_dss_output *out,
+		struct omap_video_timings *timings)
 {
 	struct hdmi_cm cm;
 
@@ -555,7 +556,7 @@ int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 
 }
 
-void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev,
+void omapdss_hdmi_display_set_timing(struct omap_dss_output *out,
 		struct omap_video_timings *timings)
 {
 	struct hdmi_cm cm;
@@ -570,16 +571,16 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev,
 	if (t != NULL)
 		hdmi.ip_data.cfg = *t;
 
-	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+	if (out->device->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		int r;
 
-		hdmi_power_off(dssdev);
+		hdmi_power_off(out);
 
-		r = hdmi_power_on(dssdev);
+		r = hdmi_power_on(out);
 		if (r)
 			DSSERR("failed to power on device\n");
 	} else {
-		dss_mgr_set_timings(dssdev->manager, &t->timings);
+		dss_mgr_set_timings(out->manager, &t->timings);
 	}
 
 	mutex_unlock(&hdmi.lock);
@@ -635,21 +636,24 @@ bool omapdss_hdmi_detect(void)
 	return r == 1;
 }
 
-int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
+int omapdss_hdmi_display_enable(struct omap_dss_output *out)
 {
-	struct omap_dss_hdmi_data *priv = dssdev->data;
+	struct omap_dss_device *dssdev = out->device;
+	struct omap_dss_hdmi_data *priv;
 	int r = 0;
 
 	DSSDBG("ENTER hdmi_display_enable\n");
 
 	mutex_lock(&hdmi.lock);
 
-	if (dssdev->manager == NULL) {
+	if (out == NULL || out->manager == NULL || dssdev == NULL) {
 		DSSERR("failed to enable display: no manager\n");
 		r = -ENODEV;
 		goto err0;
 	}
 
+	priv = dssdev->data;
+
 	hdmi.ip_data.hpd_gpio = priv->hpd_gpio;
 
 	r = omap_dss_start_device(dssdev);
@@ -666,7 +670,7 @@ int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 		}
 	}
 
-	r = hdmi_power_on(dssdev);
+	r = hdmi_power_on(out);
 	if (r) {
 		DSSERR("failed to power on device\n");
 		goto err2;
@@ -685,13 +689,15 @@ err0:
 	return r;
 }
 
-void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
+void omapdss_hdmi_display_disable(struct omap_dss_output *out)
 {
+	struct omap_dss_device *dssdev = out->device;
+
 	DSSDBG("Enter hdmi_display_disable\n");
 
 	mutex_lock(&hdmi.lock);
 
-	hdmi_power_off(dssdev);
+	hdmi_power_off(out);
 
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 2feb2cd..fb35bbb 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -233,9 +233,13 @@ static int hdmi_panel_audio_config(struct omap_dss_device *dssdev,
 
 static int hdmi_panel_enable(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r = 0;
 	DSSDBG("ENTER hdmi_panel_enable\n");
 
+	if (out == NULL)
+		return -ENODEV;
+
 	mutex_lock(&hdmi.lock);
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
@@ -243,9 +247,9 @@ static int hdmi_panel_enable(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	omapdss_hdmi_display_set_timing(dssdev, &dssdev->panel.timings);
+	omapdss_hdmi_display_set_timing(out, &dssdev->panel.timings);
 
-	r = omapdss_hdmi_display_enable(dssdev);
+	r = omapdss_hdmi_display_enable(out);
 	if (r) {
 		DSSERR("failed to power on\n");
 		goto err;
@@ -261,6 +265,7 @@ err:
 
 static void hdmi_panel_disable(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	mutex_lock(&hdmi.lock);
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
@@ -270,7 +275,7 @@ static void hdmi_panel_disable(struct omap_dss_device *dssdev)
 		 * machine.
 		 */
 		hdmi_panel_audio_disable(dssdev);
-		omapdss_hdmi_display_disable(dssdev);
+		omapdss_hdmi_display_disable(out);
 	}
 
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
@@ -280,6 +285,7 @@ static void hdmi_panel_disable(struct omap_dss_device *dssdev)
 
 static int hdmi_panel_suspend(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r = 0;
 
 	mutex_lock(&hdmi.lock);
@@ -296,7 +302,7 @@ static int hdmi_panel_suspend(struct omap_dss_device *dssdev)
 	hdmi_panel_audio_disable(dssdev);
 
 	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-	omapdss_hdmi_display_disable(dssdev);
+	omapdss_hdmi_display_disable(out);
 
 err:
 	mutex_unlock(&hdmi.lock);
@@ -306,6 +312,7 @@ err:
 
 static int hdmi_panel_resume(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r = 0;
 
 	mutex_lock(&hdmi.lock);
@@ -315,7 +322,7 @@ static int hdmi_panel_resume(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	r = omapdss_hdmi_display_enable(dssdev);
+	r = omapdss_hdmi_display_enable(out);
 	if (r) {
 		DSSERR("failed to power on\n");
 		goto err;
@@ -343,8 +350,13 @@ static void hdmi_get_timings(struct omap_dss_device *dssdev,
 static void hdmi_set_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
+	struct omap_dss_output *out = dssdev->output;
+
 	DSSDBG("hdmi_set_timings\n");
 
+	if (out == NULL)
+		return;
+
 	mutex_lock(&hdmi.lock);
 
 	/*
@@ -353,7 +365,8 @@ static void hdmi_set_timings(struct omap_dss_device *dssdev,
 	 */
 	hdmi_panel_audio_disable(dssdev);
 
-	omapdss_hdmi_display_set_timing(dssdev, timings);
+	omapdss_hdmi_display_set_timing(out, timings);
+
 	dssdev->panel.timings = *timings;
 
 	mutex_unlock(&hdmi.lock);
@@ -362,13 +375,17 @@ static void hdmi_set_timings(struct omap_dss_device *dssdev,
 static int hdmi_check_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r = 0;
 
 	DSSDBG("hdmi_check_timings\n");
 
+	if (out == NULL)
+		return -ENODEV;
+
 	mutex_lock(&hdmi.lock);
 
-	r = omapdss_hdmi_display_check_timing(dssdev, timings);
+	r = omapdss_hdmi_display_check_timing(out, timings);
 
 	mutex_unlock(&hdmi.lock);
 	return r;
@@ -376,12 +393,16 @@ static int hdmi_check_timings(struct omap_dss_device *dssdev,
 
 static int hdmi_read_edid(struct omap_dss_device *dssdev, u8 *buf, int len)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
+	if (out == NULL)
+		return -ENODEV;
+
 	mutex_lock(&hdmi.lock);
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
-		r = omapdss_hdmi_display_enable(dssdev);
+		r = omapdss_hdmi_display_enable(out);
 		if (r)
 			goto err;
 	}
@@ -390,7 +411,7 @@ static int hdmi_read_edid(struct omap_dss_device *dssdev, u8 *buf, int len)
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED ||
 			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
-		omapdss_hdmi_display_disable(dssdev);
+		omapdss_hdmi_display_disable(out);
 err:
 	mutex_unlock(&hdmi.lock);
 
@@ -399,12 +420,16 @@ err:
 
 static bool hdmi_detect(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
+	if (out == NULL)
+		return false;
+
 	mutex_lock(&hdmi.lock);
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
-		r = omapdss_hdmi_display_enable(dssdev);
+		r = omapdss_hdmi_display_enable(out);
 		if (r)
 			goto err;
 	}
@@ -413,7 +438,7 @@ static bool hdmi_detect(struct omap_dss_device *dssdev)
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED ||
 			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
-		omapdss_hdmi_display_disable(dssdev);
+		omapdss_hdmi_display_disable(out);
 err:
 	mutex_unlock(&hdmi.lock);
 
-- 
1.7.9.5


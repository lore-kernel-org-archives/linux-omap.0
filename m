From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 17/23] OMAPDSS: HDMI: Pass omap_dss_output within the driver
Date: Thu, 30 Aug 2012 17:10:39 +0530
Message-ID: <1346326845-16583-18-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36973 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177Ab2H3LnV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:43:21 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

When a panel driver calls a HDMI function, it passes the omap_dss_device
pointer, this pointer currently propagates within the HDMI driver to configure
the interface.

Extract the omap_dss_output pointer from omap_dss_device received from the panel
driver, pass the output pointer to HDMI functions local to the driver to
configure the interface, these functions no longer need omap_dss_device since
the driver now maintains a copy of output parameters.

Replace dssdev->manager references with out->manager references as only these
will be valid later.

With the addition of outputs. There is a possibility that an omap_dss_device
isn't connected to an output, or a manager isn't connected to an output yet.
Ensure that the HDMI interface functions proceed only if the output is non NULL.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index d93954d..3c89904 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -407,9 +407,10 @@ unsigned long hdmi_get_pixel_clock(void)
 	return hdmi.ip_data.cfg.timings.pixel_clock * 1000;
 }
 
-static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
+static void hdmi_compute_pll(struct omap_dss_output *out, int phy,
 		struct hdmi_pll_info *pi)
 {
+	struct omap_dss_device *dssdev = out->device;
 	unsigned long clkin, refclk;
 	u32 mf;
 
@@ -458,7 +459,7 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	DSSDBG("range = %d sd = %d\n", pi->dcofreq, pi->regsd);
 }
 
-static int hdmi_power_on(struct omap_dss_device *dssdev)
+static int hdmi_power_on(struct omap_dss_output *out)
 {
 	int r;
 	struct omap_video_timings *p;
@@ -468,7 +469,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		return r;
 
-	dss_mgr_disable(dssdev->manager);
+	dss_mgr_disable(out->manager);
 
 	p = &hdmi.ip_data.cfg.timings;
 
@@ -476,7 +477,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	phy = p->pixel_clock;
 
-	hdmi_compute_pll(dssdev, phy, &hdmi.ip_data.pll_data);
+	hdmi_compute_pll(out, phy, &hdmi.ip_data.pll_data);
 
 	hdmi.ip_data.ops->video_disable(&hdmi.ip_data);
 
@@ -504,19 +505,19 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
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
 
@@ -533,9 +534,9 @@ err:
 	return -EIO;
 }
 
-static void hdmi_power_off(struct omap_dss_device *dssdev)
+static void hdmi_power_off(struct omap_dss_output *out)
 {
-	dss_mgr_disable(dssdev->manager);
+	dss_mgr_disable(out->manager);
 
 	hdmi.ip_data.ops->video_disable(&hdmi.ip_data);
 	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
@@ -560,9 +561,13 @@ int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
+	struct omap_dss_output *out = dssdev->output;
 	struct hdmi_cm cm;
 	const struct hdmi_config *t;
 
+	if (out == NULL)
+		return;
+
 	mutex_lock(&hdmi.lock);
 
 	cm = hdmi_get_code(timings);
@@ -575,13 +580,13 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev,
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
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
@@ -640,14 +645,15 @@ bool omapdss_hdmi_detect(void)
 int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 {
 	struct omap_dss_hdmi_data *priv = dssdev->data;
+	struct omap_dss_output *out = dssdev->output;
 	int r = 0;
 
 	DSSDBG("ENTER hdmi_display_enable\n");
 
 	mutex_lock(&hdmi.lock);
 
-	if (dssdev->manager == NULL) {
-		DSSERR("failed to enable display: no manager\n");
+	if (out == NULL || out->manager == NULL) {
+		DSSERR("failed to enable display: no output/manager\n");
 		r = -ENODEV;
 		goto err0;
 	}
@@ -668,7 +674,7 @@ int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 		}
 	}
 
-	r = hdmi_power_on(dssdev);
+	r = hdmi_power_on(out);
 	if (r) {
 		DSSERR("failed to power on device\n");
 		goto err2;
@@ -689,11 +695,13 @@ err0:
 
 void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
+
 	DSSDBG("Enter hdmi_display_disable\n");
 
 	mutex_lock(&hdmi.lock);
 
-	hdmi_power_off(dssdev);
+	hdmi_power_off(out);
 
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
-- 
1.7.9.5


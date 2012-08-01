From: Archit Taneja <archit@ti.com>
Subject: [RFC 09/17] OMAPDSS: HDMI: Use our own omap_video_timings field when setting interface timings
Date: Wed, 1 Aug 2012 16:01:20 +0530
Message-ID: <1343817088-29645-10-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50164 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934Ab2HAKdg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 06:33:36 -0400
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com, Archit Taneja <archit@ti.com>

The hdmi driver currently updates only the 'code' member of hdmi_config when
the op omapdss_hdmi_display_set_timing() is called by the hdmi panel driver.
The 'timing' field of hdmi_config is updated only when hdmi_power_on is called.
It makes more sense to configure the whole hdmi_config field in the set_timing
op called by the panel driver. This way, we don't need to call both functions
to ensure that our hdmi_config is configured correctly. Also, we don't need to
calculate hdmi_config during hdmi_power_on, or rely on the omap_video_timings
in the panel's omap_dss_device struct.

A default timing is now configured in hdmi's probe if the panel driver doesn't
set any timing, or doesn't set a valid timing before enabling the panel. Also,
when setting manager timings, use the omap_video_timing calculated by
hdmi_get_timings(), this returns the timings as specified in the CEA/VESA
tables, don't use the one provided by the panel driver directly.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.h        |    3 ++-
 drivers/video/omap2/dss/hdmi.c       |   41 +++++++++++++++++-----------------
 drivers/video/omap2/dss/hdmi_panel.c |    2 +-
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 8a9630b..7e38ffd 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -485,7 +485,8 @@ static inline unsigned long hdmi_get_pixel_clock(void)
 #endif
 int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev);
-void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev);
+void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings);
 int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 					struct omap_video_timings *timings);
 int omapdss_hdmi_read_edid(u8 *buf, int len);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 6635b09..01665fa 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -462,7 +462,6 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 {
 	const struct omapdss_clock_config *clks;
 	int r;
-	const struct hdmi_config *timing;
 	struct omap_video_timings *p;
 	unsigned long phy;
 
@@ -472,22 +471,10 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	dss_mgr_disable(dssdev->manager);
 
-	p = &dssdev->panel.timings;
+	p = &hdmi.ip_data.cfg.timings;
 
-	DSSDBG("hdmi_power_on x_res= %d y_res = %d\n",
-		dssdev->panel.timings.x_res,
-		dssdev->panel.timings.y_res);
+	DSSDBG("hdmi_power_on x_res= %d y_res = %d\n", p->x_res, p->y_res);
 
-	timing = hdmi_get_timings();
-	if (timing == NULL) {
-		/* HDMI code 4 corresponds to 640 * 480 VGA */
-		hdmi.ip_data.cfg.cm.code = 4;
-		/* DVI mode 1 corresponds to HDMI 0 to DVI */
-		hdmi.ip_data.cfg.cm.mode = HDMI_DVI;
-		hdmi.ip_data.cfg = vesa_timings[0];
-	} else {
-		hdmi.ip_data.cfg = *timing;
-	}
 	phy = p->pixel_clock;
 
 	hdmi_compute_pll(phy, &hdmi.ip_data.pll_data);
@@ -525,7 +512,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	dispc_enable_gamma_table(0);
 
 	/* tv size */
-	dss_mgr_set_timings(dssdev->manager, &dssdev->panel.timings);
+	dss_mgr_set_timings(dssdev->manager, p);
 
 	r = hdmi.ip_data.ops->video_enable(&hdmi.ip_data);
 	if (r)
@@ -571,13 +558,18 @@ int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 
 }
 
-void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
+void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
 {
 	struct hdmi_cm cm;
+	const struct hdmi_config *timing;
+
+	cm = hdmi_get_code(timings);
+	hdmi.ip_data.cfg.cm = cm;
 
-	cm = hdmi_get_code(&dssdev->panel.timings);
-	hdmi.ip_data.cfg.cm.code = cm.code;
-	hdmi.ip_data.cfg.cm.mode = cm.mode;
+	timing = hdmi_get_timings();
+	if (timing != NULL)
+		hdmi.ip_data.cfg = *timing;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		int r;
@@ -588,7 +580,7 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
 		if (r)
 			DSSERR("failed to power on device\n");
 	} else {
-		dss_mgr_set_timings(dssdev->manager, &dssdev->panel.timings);
+		dss_mgr_set_timings(dssdev->manager, &timing->timings);
 	}
 }
 
@@ -933,6 +925,13 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 	hdmi.ip_data.core_av_offset = HDMI_CORE_AV;
 	hdmi.ip_data.pll_offset = HDMI_PLLCTRL;
 	hdmi.ip_data.phy_offset = HDMI_PHY;
+
+	/*
+	 * initialize hdmi timings to default value:
+	 * HDMI code 4(VGA) and HDMI mode 1(DVI)
+	 */
+	hdmi.ip_data.cfg = vesa_timings[0];
+
 	mutex_init(&hdmi.ip_data.lock);
 
 	hdmi_panel_init();
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index e10844f..8dce206 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -336,8 +336,8 @@ static void hdmi_set_timings(struct omap_dss_device *dssdev,
 	 */
 	hdmi_panel_audio_disable(dssdev);
 
+	omapdss_hdmi_display_set_timing(dssdev, timings);
 	dssdev->panel.timings = *timings;
-	omapdss_hdmi_display_set_timing(dssdev);
 
 	mutex_unlock(&hdmi.lock);
 }
-- 
1.7.9.5


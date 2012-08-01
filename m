From: Archit Taneja <archit@ti.com>
Subject: [RFC 10/17] OMAPDSS: HDMI: Add a get_timing function for HDMI interface
Date: Wed, 1 Aug 2012 16:01:21 +0530
Message-ID: <1343817088-29645-11-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39552 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934Ab2HAKdl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 06:33:41 -0400
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com, Archit Taneja <archit@ti.com>

Add function omapdss_hdmi_display_get_timing() which returns the timings
maintained by the HDMI interface driver in it's hdmi_config field. This
prevents the need for the panel driver to configure default timings in it's
probe.

This function is just intended to be used once during the panel driver's probe.
It makes sense for those interfaces which can be configured to a default timing.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.h        |    2 ++
 drivers/video/omap2/dss/hdmi.c       |    6 ++++++
 drivers/video/omap2/dss/hdmi_panel.c |   10 +++++-----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 7e38ffd..df49c5d 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -485,6 +485,8 @@ static inline unsigned long hdmi_get_pixel_clock(void)
 #endif
 int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev);
+void omapdss_hdmi_display_get_timing(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings);
 void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings);
 int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 01665fa..2de1f91 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -544,6 +544,12 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 	hdmi_runtime_put();
 }
 
+void omapdss_hdmi_display_get_timing(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	*timings = hdmi.ip_data.cfg.timings;
+}
+
 int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 					struct omap_video_timings *timings)
 {
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 8dce206..8473193 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -41,13 +41,13 @@ static struct {
 
 static int hdmi_panel_probe(struct omap_dss_device *dssdev)
 {
+	struct omap_video_timings timings;
+
 	DSSDBG("ENTER hdmi_panel_probe\n");
 
-	dssdev->panel.timings = (struct omap_video_timings)
-			{ 640, 480, 25175, 96, 16, 48, 2, 11, 31,
-				OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_LOW,
-				false,
-			};
+	omapdss_hdmi_display_get_timing(dssdev, &timings);
+
+	dssdev->panel.timings = timings;
 
 	DSSDBG("hdmi_panel_probe x_res= %d y_res = %d\n",
 		dssdev->panel.timings.x_res,
-- 
1.7.9.5

